import 'package:bnbapp/paths/path.dart';
import 'package:bnbapp/utils/base_cubit.dart';
import 'package:flutter/material.dart';

import 'auth_state.dart';

class AuthCubit extends BaseCubit<AuthState> {
  AuthCubit() : super(AuthState());
  static const Color black = Color(0xff000000);
  static const Color white = Color(0xffffffff);

  String? address = "";

  Paths? paths = Paths();

  Future<void> init() async {
    emit(AuthInitialState());
    await Future.delayed(const Duration(seconds: 3));
    emit(AuthenticatedState());
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

  login() async {
    emit(AuthenticatedState());
  }
}
