import 'dart:convert';

import 'package:bnbapp/contract/WowTPoints.g.dart';
import 'package:bnbapp/model/profile_model.dart';
import 'package:bnbapp/paths/path.dart';
import 'package:bnbapp/utils/base_cubit.dart';
import 'package:bnbapp/utils/preferencehelper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

import 'auth_state.dart';

class AuthCubit extends BaseCubit<AuthState> {
  AuthCubit() : super(AuthState());
  static const Color black = Color(0xff000000);
  static const Color white = Color(0xffffffff);
  String? profileAbout;
  String? address = "";
  ValueNotifier<String> addressNotifier = ValueNotifier("");
  ProfileModel? profileModel;

  // int? points = 0;
  Paths? paths = Paths();
  String? node = '';
  BigInt? points;
  final httpClient = Client();
  List<EthereumAddress> leaderBoard = [];

  Future<void> init() async {
    emit(AuthInitialState());
    emit(AuthLoadingState());
    await Future.delayed(const Duration(seconds: 3));
    final userId = await PreferenceHelper.getUserId() ?? '';
    address = userId.toString();
    addressNotifier.value = address.toString();
    debugPrint(
        'the notifier is ${addressNotifier.value.toString()} ${addressNotifier.value.toString()}');
    final snapshot = await paths?.node.get();
    node = snapshot?.value.toString();

    debugPrint('the node url is ${node.toString()} ${userId.toString()}');
    await paths?.profile.get().then((value) => profileModel =
        ProfileModel.fromJson(
            jsonDecode(jsonEncode(value.value)) as Map<String, dynamic>));
    debugPrint('all datas are ${profileModel?.badge}');
    //debugPrint("all profile elements are ${profileSnapShot?.value.toString()}");
    if (userId.toString() != null && userId != "") {
      Web3Client client = Web3Client(node.toString(), httpClient);
      EthereumAddress addresss = EthereumAddress.fromHex(userId.toString());
      EthereumAddress cdAddress =
          EthereumAddress.fromHex(profileModel!.points!);
      WowTPoints wowTPoints = WowTPoints(address: cdAddress, client: client);
      var owner = await wowTPoints.owner();
      debugPrint(
          'owner address  coming ${owner.toString()} ${address.toString()}');
      points = await wowTPoints.getPoints(addresss);
      leaderBoard = await wowTPoints.getTopLeaderBoards();
      debugPrint('the leader board list was ${leaderBoard.toString()}');
      debugPrint('the about text is ${points.toString()}');
      emit(AuthenticatedState());
    } else {
      emit(UnAuthenticatedState());
    }

    /*
    if (paths?.currrentUser != null) {
      final snapshot =
          await paths?.master.child("${paths?.uId}").child("address").get();
      var addressIs = snapshot?.value.toString();
      address = addressIs;
      debugPrint('the user address is ${addressIs.toString()}');
      await Future.delayed(const Duration(seconds: 3));
      emit(AuthenticatedState());
    }else{
      emit(UnAuthenticatedState());
    }
     */
  }

  login() {
    emit(AuthenticatedState());
  }
}
