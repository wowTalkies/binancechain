import 'package:bnbapp/auth_cubit/auth_cubit.dart';
import 'package:bnbapp/contract/WowTPoints.g.dart';
import 'package:bnbapp/paths/path.dart';
import 'package:bnbapp/utils/base_cubit.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

import 'leaderboard_state.dart';

class LeaderBoardCubit extends BaseCubit<LeaderBoardState> {
  final AuthCubit authCubit;
  List<EthereumAddress>? leaderBoard = [];
  Paths? paths = Paths();
  List<String>? userNameList = [];

  List<BigInt> pointsList = [];

  LeaderBoardCubit(this.authCubit) : super(LeaderBoardInitialState());

  Future<void> init() async {
    emit(LeaderBoardLoadingState());
    debugPrint('hi wellCome');
    EthereumAddress address =
    EthereumAddress.fromHex(authCubit.profileModel!.points.toString());
    var httpClient = Client();
    Web3Client client = Web3Client(authCubit.node.toString(), httpClient);
    WowTPoints wowTPoints = WowTPoints(address: address, client: client);
    var leaderboards = await wowTPoints.getTopLeaderBoards();
    debugPrint('the leader board is ${leaderboards.toString()}');
    for (var i = 0; i < 6; i++) {
      leaderBoard?.add(leaderboards[i]);
      var fbNameList = await paths?.address
          .child(leaderBoard![i].toString())
          .child("userName")
          .get();
      userNameList?.add(fbNameList!.value.toString());

      pointsList.add(await wowTPoints
          .getPoints(EthereumAddress.fromHex(leaderBoard![i].toString())));
      debugPrint('the points are ${pointsList[i].toString()}');

      debugPrint('the addresses are ${leaderBoard![i].toString()}');
    }
    debugPrint('the addresses are ${userNameList.toString()}');
    emit(LeaderBoardLoadedState());
  }
}
