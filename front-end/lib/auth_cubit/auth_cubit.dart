
import 'package:bnbapp/utils/base_cubit.dart';
import 'package:flutter/material.dart';

import 'auth_state.dart';

class AuthCubit extends BaseCubit<AuthState> {
  AuthCubit() : super(AuthState());
  Future<void> init() async {
    debugPrint('hi wellCome');
  }
}