import 'package:bnbapp/paths/path.dart';
import 'package:bnbapp/screens/profile/contracts/WowTPoints.g.dart';
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

  // int? points = 0;
  Paths? paths = Paths();
  String? node = '';
  BigInt? points;
  final httpClient = Client();

  Future<void> init() async {
    emit(AuthInitialState());
    emit(AuthLoadingState());
    await Future.delayed(const Duration(seconds: 3));
    final userId = await PreferenceHelper.getUserId() ?? '';
    address = userId.toString();
    final snapshot = await paths?.node.get();
    node = snapshot?.value.toString();

    debugPrint('the node url is ${node.toString()} ${userId.toString()}');
    if (userId.toString() != null && userId != "") {
      Web3Client client = Web3Client(node.toString(), httpClient);
      EthereumAddress addresss = EthereumAddress.fromHex(userId.toString());
      EthereumAddress cdAddress =
          EthereumAddress.fromHex("0x7faf3239A9bE79072a1FaA43A3acb664F2af78f9");
      WowTPoints wowTPoints = WowTPoints(address: cdAddress, client: client);
      var owner = await wowTPoints.owner();
      debugPrint('owner address  coming ${owner.toString()}');
      points = await wowTPoints.getPoints(addresss);
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
