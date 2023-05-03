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

  Future<void> init() async {
    debugPrint('hi wellCome go');
  }

  login() async {
    await magic.auth
        .loginWithMagicLink(email: controller.value.text.toString());
    var account = await MagicCredential(magic.provider).getAccount();
    var address = account.toString();
    debugPrint("the address is ${address.toString()}");
    var email = controller.value.text;
    await FirebaseAuth.instance.signInAnonymously();
    var user = FirebaseAuth.instance.currentUser?.uid;
    await PreferenceHelper.saveUserId(address.toString());
    await path.address.child(address).update({"email": email});
    if (address.isNotEmpty) {
      PendingDynamicLinkData? initialLink =
          await FirebaseDynamicLinks.instance.getInitialLink();

      debugPrint('referral cubit link ${initialLink?.link.toString()}');
      var firstInvite =
          await path?.address.child(address!).child("firstInvite").get();
      debugPrint("first invite is ${firstInvite?.value.toString()}");
      try {
        if (initialLink?.link.toString() != null &&
            firstInvite?.value.toString() == null) {
          Uri deepLink = initialLink!.link;
          debugPrint('the link is ${deepLink.toString()}');
          var qAddress = deepLink.query;
          var queryAddress = qAddress.toString().substring(10);
          debugPrint('the query address is ${queryAddress.toString()}');
          debugPrint('the link query is ${deepLink.query}');
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
