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
  BigInt? userPoint = BigInt.parse("0");
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
    userPoint =
        await wowTPoints.getPoints(EthereumAddress.fromHex(userId.toString()));
    points.value =
        await wowTPoints.getPoints(EthereumAddress.fromHex(userId.toString()));
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

      descriptionList.add(abc.description);
      imageUrl.add(abc.imageUrl);
      totalMembers.add(abc.totalMembers);
    }

    emit(CommunityLoadedState());
  }

  checkMembership(community) async {
    emit(CommunityJoinCheckState());
    userNameFirstLetter?.value.clear();
    feeds.value.clear();
    communityNameForPost = community.toString();
    var user = await wowTCommunity!.checkMembership(
        community.toString(), EthereumAddress.fromHex(userId.toString()));

    feeds.value[community] = (await wowTCommunity?.getPosts(community))!;
    for (var i = 0; i < feeds.value[community]!.length; i++) {
      final userName = await paths.address
          .child(feeds.value[community]![i][2].toString())
          .child("userName")
          .get();
      userNameFirstLetter?.value?.add(userName.value.toString());
    }

    if (user) {
      debugPrint('user joined');
      await init();
      emit(CommunityJointedState());
    } else {
      await addMembers();
      emit(CommunityNotJointedState());
    }
  }

  addMembers() async {
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
      debugPrint('member added');
      await init();
      emit(CommunityJointedState());
    } else {
      if (int.parse(userPoint.toString()) < 10) {
        emit(CommunityErrorState(
            "You don't have enough points to join the community. Please attend quiz or refer your friend to earn points. You need 10 points to join the community."));
      } else {
        emit(CommunityErrorState("Something went wrong, try again"));
      }
      debugPrint('member not added');
    }
  }

  vkj() async {
    emit(CommunityPostRequestedState());
  }

  createPost() async {
    emit(CommunityPostRequestedState());
    var url = '';
    if (postImageFile.value.path.toString().isNotEmpty) {
      url = await uploadFiles(postImageFile.value.path.toString());
    } else {
      url = "";
    }

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
      try {
        await checkMembership(communityNameForPost.toString());
        emit(CommunityPostedState());
      } catch (ex) {
        debugPrint('error is ${ex.toString()}');
      }
    } else {
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
