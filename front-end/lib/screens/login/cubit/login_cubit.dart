import 'package:bnbapp/auth_cubit/auth_cubit.dart';
import 'package:bnbapp/paths/path.dart';
import 'package:bnbapp/utils/base_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:magic_sdk/magic_sdk.dart';

import 'login_state.dart';

class LoginCubit extends BaseCubit<LoginState> {
  LoginCubit(AuthCubit authCubit) : super(LoginState());
  TextEditingController controller = TextEditingController();
  Magic magic = Magic.instance;
  Paths path = Paths();
  Future<void> init() async {
    debugPrint('hi wellCome');
  }

  login() async {
    await magic.auth
        .loginWithMagicLink(email: controller.value.text.toString());
    var account = await MagicCredential(magic.provider).getAccount();
    var address = account.toString();
    debugPrint("the address is ${address.toString()}");
    var email = controller.value.text;
   await  FirebaseAuth.instance.signInAnonymously();
   var user =  FirebaseAuth.instance.currentUser?.uid;
    await path.master.child(user!).set({"email": email, "address": address});
  }
}
