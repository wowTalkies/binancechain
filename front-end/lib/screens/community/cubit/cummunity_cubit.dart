import 'package:bnbapp/auth_cubit/auth_cubit.dart';
import 'package:bnbapp/contract/WowTCommunity.g.dart';
import 'package:bnbapp/screens/community/cubit/cummunity_state.dart';
import 'package:bnbapp/utils/base_cubit.dart';
import 'package:bnbapp/utils/preferencehelper.dart';
import 'package:dio/dio.dart';
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
  WowTCommunity? wowTCommunity;
  Map<String, List<dynamic>> feeds = {};

  // CommunityMap? abc = CommunityMap([]);

  // var abc;

  CommunityCubit(this.authCubit) : super(CommunityInitialState());

  Future<void> init() async {
    emit(CommunityLoadingState());
    userId = await PreferenceHelper.getUserId();
    var httpClient = Client();
    EthereumAddress address =
        EthereumAddress.fromHex(authCubit.profileModel!.community.toString());
    Web3Client client = Web3Client(authCubit.node.toString(), httpClient);
    wowTCommunity = WowTCommunity(address: address, client: client);
    lists = await wowTCommunity!.getCommunities();

    for (var i = 0; i < lists.length; i++) {
      var abd = await wowTCommunity!.getCommunityDetails(lists[i]);
      var abc = await wowTCommunity!.communityMap(lists[i]);
      feeds[lists[i]] = (await wowTCommunity?.getPosts(lists[i]))!;
      debugPrint('community list was is ${feeds.toString()}');
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
    var user = await wowTCommunity!.checkMembership(
        community.toString(), EthereumAddress.fromHex(userId.toString()));
    feeds[community] = (await wowTCommunity?.getPosts(community))!;
    debugPrint('the user is ${user.toString()}');
    if (user) {
      debugPrint('user joined');
      emit(CommunityJointedState());
    } else {
      emit(CommunityNotJointedState());

      // debugPrint('user not joined');
    }
  }

  addMembers() async {
    debugPrint('userid is ${userId.toString()}');
    emit(CommunityNotJointedState());
    var jsons = {
      "method": "addMember",
      "communityName": "Community name here......",
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
      emit(CommunityNotJointedState());
      debugPrint('member added');
    } else {
      emit(CommunityErrorState("Something went wrong"));
      debugPrint('member not added');
    }
  }
}
