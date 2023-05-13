import 'package:bnbapp/auth_cubit/auth_cubit.dart';
import 'package:bnbapp/paths/path.dart';
import 'package:bnbapp/utils/base_cubit.dart';
import 'package:bnbapp/utils/preferencehelper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:magic_sdk/magic_sdk.dart';

import 'login_state.dart';

class LoginCubit extends BaseCubit<LoginState> {
  AuthCubit authCubit;

  LoginCubit(this.authCubit) : super(LoginInitialState());
  TextEditingController controller = TextEditingController();
  Magic magic = Magic.instance;
  Paths path = Paths();
  String userName = '';

  Future<void> init() async {}

  login() async {
    await magic.auth
        .loginWithMagicLink(email: controller.value.text.toString());
    for (var i = 0; i < controller.value.text.length; i++) {
      if (controller.value.text[i] != "@") {
        userName += controller.value.text[i];
      } else {
        break;
      }
    }
    var account = await MagicCredential(magic.provider).getAccount();
    var address = account.toString();
    await PreferenceHelper.saveUserId(address.toString());
    var email = controller.value.text;
    await FirebaseAuth.instance.signInAnonymously();
    var user = FirebaseAuth.instance.currentUser?.uid;
    await PreferenceHelper.saveUserId(address.toString());
    await path.address.child(address).update({
      "email": email,
      "userName": userName.toString(),
      "About": "Enter about yourself"
    });
    if (address.isNotEmpty) {
      PendingDynamicLinkData? initialLink =
          await FirebaseDynamicLinks.instance.getInitialLink();

      var firstInvite =
          await path?.address.child(address!).child("firstInvite").get();
      try {
        if (initialLink?.link.toString() != null &&
            firstInvite?.value.toString() == null) {
          Uri deepLink = initialLink!.link;
          var qAddress = deepLink.query;
          var queryAddress = qAddress.toString().substring(10);

          await path?.address
              .child(address!)
              .update({"firstInvite": "Invited"});
        }
      } catch (ex) {
        debugPrint('the error is ${ex.toString()}');
      }
      authCubit.login();
    } else {
      LoginErrorState("Invalid");
    }
  }
}
