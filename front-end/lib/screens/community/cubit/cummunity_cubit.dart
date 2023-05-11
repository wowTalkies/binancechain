import 'dart:io';

import 'package:bnbapp/auth_cubit/auth_cubit.dart';
import 'package:bnbapp/contract/WowTCommunity.g.dart';
import 'package:bnbapp/contract/WowTPoints.g.dart';
import 'package:bnbapp/paths/path.dart';
import 'package:bnbapp/screens/community/cubit/cummunity_state.dart';
import 'package:bnbapp/utils/base_cubit.dart';
import 'package:bnbapp/utils/preferencehelper.dart';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

class CommunityCubit extends BaseCubit<CommunityState> {
  final AuthCubit authCubit;
  List<String> lists = [];
  List<String> imageUrl = [];
  List<String> descriptionList = [];
  List<BigInt> totalMembers = [];
  String? userId = '';
  String? postImageUrl = "";
  Paths paths = Paths();
  ValueNotifier<BigInt> points = ValueNotifier(BigInt.parse("0"));
  int checkIndex = 20;

  // File postImageFile = File('');
  ValueNotifier<File> postImageFile = ValueNotifier(File(''));
  WowTCommunity? wowTCommunity;
  ValueNotifier<Map<String, List<dynamic>>> feeds = ValueNotifier({"": []});

  // feeds = {};
  ValueNotifier<List<String>>? userNameFirstLetter = ValueNotifier([]);
  List<String> joinOrOpen = [];

  // List<String>?  = [];
  TextEditingController postMesage = TextEditingController();
  String? communityNameForPost;

  // CommunityMap? abc = CommunityMap([]);

  // var abc;

  CommunityCubit(this.authCubit) : super(CommunityInitialState());

  Future<void> init() async {
    emit(CommunityLoadingState());
    joinOrOpen.clear();
    userId = await PreferenceHelper.getUserId();
    var httpClient = Client();
    lists.clear();
    imageUrl.clear();
    EthereumAddress address =
        EthereumAddress.fromHex(authCubit.profileModel!.community.toString());
    Web3Client client = Web3Client(authCubit.node.toString(), httpClient);
    wowTCommunity = WowTCommunity(address: address, client: client);
    lists = await wowTCommunity!.getCommunities();

    WowTPoints wowTPoints = WowTPoints(
        client: client,
        address:
            EthereumAddress.fromHex(authCubit.profileModel!.points.toString()));
    points.value =
        await wowTPoints.getPoints(EthereumAddress.fromHex(userId.toString()));
    debugPrint('the point is ${points.value.toString()}');
    for (var i = 0; i < lists.length; i++) {
      var membersCheck = await wowTCommunity!.checkMembership(
          lists[i].toString(), EthereumAddress.fromHex(userId.toString()));
      if (membersCheck) {
        joinOrOpen.add("joined");
      } else {
        joinOrOpen.add("not");
      }

      var abd = await wowTCommunity!.getCommunityDetails(lists[i]);
      var abc = await wowTCommunity!.communityMap(lists[i]);
      // feeds.value[lists[i]] = (await wowTCommunity?.getPosts(lists[i]))!;
      //  debugPrint('community list was is ${feeds.toString()}');
      //wowTCommunity.c
      descriptionList.add(abc.description);
      imageUrl.add(abc.imageUrl);
      totalMembers.add(abc.totalMembers);
      debugPrint('the community list is ${lists.toString()}');

      // debugPrint('the community list is ${abd.var1.toString()}');
    }

    debugPrint('hi wellCome');
    emit(CommunityLoadedState());
  }

  checkMembership(community) async {
    emit(CommunityJoinCheckState());
    userNameFirstLetter?.value.clear();
    feeds.value.clear();
    debugPrint('the community is ${community.toString()}');
    communityNameForPost = community.toString();
    var user = await wowTCommunity!.checkMembership(
        community.toString(), EthereumAddress.fromHex(userId.toString()));

    feeds.value[community] = (await wowTCommunity?.getPosts(community))!;
    debugPrint('the user is abcd ${feeds.value[community]!.toString()}');
    for (var i = 0; i < feeds.value[community]!.length; i++) {
      final userName = await paths.address
          .child(feeds.value[community]![i][2].toString())
          .child("userName")
          .get();
      userNameFirstLetter?.value?.add(userName.value.toString());
      debugPrint('the user names hi hello'
          ' ${feeds.value[community]![i][0].toString()}');
      debugPrint('the user names are ${userNameFirstLetter.toString()}');
    }

    // debugPrint('the user is ${feeds.value["Marvel Cinematic Universe"].toString()}');
    if (user) {
      debugPrint('user joined');
      await init();
      emit(CommunityJointedState());
    } else {
      emit(CommunityNotJointedState());

      // debugPrint('user not joined');
    }
  }

  addMembers() async {
    debugPrint('userid is ${userId.toString()}');
    emit(CommunityJoinRequestedState());
    var jsons = {
      "method": "addMember",
      "communityName": communityNameForPost.toString(),
      "userAddress": userId.toString()
    };

    final result = await Dio().post(
        authCubit.profileModel!.requestUrl.toString(),
        options: Options(
            headers: {"x-api-key": authCubit.profileModel!.apiKey.toString()},
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            }),
        data: jsons);
    debugPrint('result is ${result.toString()}');
    if (result.toString().contains('member added successfully')) {
      joinOrOpen[0] = "Joined";
      // emit(CommunityJointedState());
      debugPrint('member added');
      await init();
      emit(CommunityJointedState());
    } else {
      emit(CommunityErrorState("Something went wrong, try again"));
      debugPrint('member not added');
    }
  }

  vkj() async {
    emit(CommunityPostRequestedState());
  }

  createPost() async {
    emit(CommunityPostRequestedState());
    debugPrint(
        'postImageFile.value.path ${postImageFile.value.path.toString()}');
    var url = '';
    if (postImageFile.value.path.toString().isNotEmpty) {
      url = await uploadFiles(postImageFile.value.path.toString());
    } else {
      url =
          "https://firebasestorage.googleapis.com/v0/b/bnbhackathon.appspot.com/o/dummy.png?alt=media&token=4fcfd9cf-3855-4f5a-9959-e797a54b79bf";
    }
    debugPrint('the one ${url.toString()}');
    debugPrint('the one 123 ${communityNameForPost.toString()}');
    debugPrint('the one 1234 ${postMesage.value.text.toString()}');
    debugPrint('the one 12345 ${userId.toString()}');
    var jsons = {
      "method": "createPost",
      "communityName": communityNameForPost.toString(),
      "message": postMesage.value.text.toString(),
      "imageUrl": url.toString(),
      "userAddress": userId.toString()
    };
    final result = await Dio().post(
        authCubit.profileModel!.requestUrl.toString(),
        options: Options(
            headers: {"x-api-key": authCubit.profileModel!.apiKey.toString()},
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            }),
        data: jsons);

    debugPrint('the result is ${result.data.toString()}');
    if (result.toString().contains("post created successfully")) {
      debugPrint('fjhdsfi');
      // feeds.value.clear();
      // Map<String, List<dynamic>> posts = {};
      //feeds.value[communityNameForPost.toString()]?.clear();
      // posts[communityNameForPost.toString()] =
      //
      try {
        // feeds.value[communityNameForPost.toString()]?.clear();
        // userNameFirstLetter.value.clear();
        // feeds.value[communityNameForPost.toString()] =
        // (await wowTCommunity?.getPosts(communityNameForPost.toString()))!;

        await checkMembership(communityNameForPost.toString());
        emit(CommunityPostedState());
      } catch (ex) {
        debugPrint('error is ${ex.toString()}');
      }
    } else {
      debugPrint('fjhdsfi kvg');
      emit(CommunityErrorState("Something went wrong, try again"));
    }
  }

  Future<String> uploadFiles(String filepath) async {
    final storageRef = FirebaseStorage.instance.ref();
    int timeStamp = DateTime.now().millisecondsSinceEpoch;
    String timeStampString = timeStamp.toString();

    var childref = storageRef.child("fanposts/${userId!}/$timeStampString.jpg");
    try {
      File file = File(filepath);

      await childref.putFile(file);
      return childref.getDownloadURL();
    } catch (e) {
      debugPrint('Something went wrong! $e');
      return "Error";
    }
  }
}
