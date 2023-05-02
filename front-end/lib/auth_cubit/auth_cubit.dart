import 'package:bnbapp/paths/path.dart';
import 'package:bnbapp/utils/base_cubit.dart';
import 'package:bnbapp/utils/preferencehelper.dart';
import 'package:flutter/material.dart';

import 'auth_state.dart';

class AuthCubit extends BaseCubit<AuthState> {
  AuthCubit() : super(AuthState());
  static const Color black = Color(0xff000000);
  static const Color white = Color(0xffffffff);
  String? profileAbout;
  String? address = "cxzfgvcxes54tyhuytdyigbvcutyvh";
  int? points = 0;
  Paths? paths = Paths();

  Future<void> init() async {
    emit(AuthInitialState());
    emit(AuthLoadingState());
    await Future.delayed(const Duration(seconds: 3));
    final userId = await PreferenceHelper.getUserId() ?? '';
    address = userId.toString();
    debugPrint('the userId is ${userId.toString()}');
    if (userId.toString() != null && userId != "") {
      debugPrint('the about text is ${profileAbout.toString()}');
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
