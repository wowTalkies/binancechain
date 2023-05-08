import 'package:bnbapp/auth_cubit/auth_cubit.dart';
import 'package:bnbapp/contract/WowTCommunity.g.dart';
import 'package:bnbapp/screens/community/cubit/cummunity_state.dart';
import 'package:bnbapp/utils/base_cubit.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

class CommunityCubit extends BaseCubit<CommunityState> {
  final AuthCubit authCubit;
  List<String> lists = [];
  List<String> imageUrl = [];
  List<String> descriptionList = [];
  List<BigInt> totalMembers = [];


  // CommunityMap? abc = CommunityMap([]);

  // var abc;

  CommunityCubit(this.authCubit) : super(CommunityInitialState());

  Future<void> init() async {
    emit(CommunityLoadingState());
    var httpClient = Client();
    EthereumAddress address =
    EthereumAddress.fromHex(authCubit.profileModel!.community.toString());
    Web3Client client = Web3Client(authCubit.node.toString(), httpClient);
    WowTCommunity wowTCommunity =
    WowTCommunity(address: address, client: client);
    lists = await wowTCommunity.getCommunities();
    for (var i = 0; i < lists.length; i++) {
      var abd = await wowTCommunity.getCommunityDetails(lists[i]);
      var abc = await wowTCommunity.communityMap(lists[i]);

      descriptionList.add(abc.description);
      imageUrl.add(abc.imageUrl);
      totalMembers.add(abc.totalMembers);
      debugPrint('the community list is ${abd.var1.toString()}');
    }
    debugPrint('hi wellCome');
    emit(CommunityLoadedState());
  }
}
