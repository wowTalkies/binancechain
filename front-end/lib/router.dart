
import 'package:bnbapp/screens/login/cubit/login_cubit.dart';
import 'package:bnbapp/screens/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_cubit/auth_cubit.dart';
import 'auth_cubit/auth_state.dart';

class AppRoutes {
  static const String login = "login";
  static const String home = "home";
  static const String walletHome = "walletHome";
  static const String utility = "utility";
  static const String settings = "settings";
  static const String nftDetail = "nftDetail";
  static const String poling = "poling";
}
Route<dynamic> getRoutes(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.login:
      return _buildLoginScreen();
    default:
      return _buildLoginScreen();
  }
}

MaterialPageRoute _buildLoginScreen() {
  return MaterialPageRoute(
    settings: const RouteSettings(name: AppRoutes.login),
    builder: (context) =>
        addAuth(context, PageBuilder.buildLoginScreen(), "Login"),
  );
}
Widget addAuth(BuildContext context, Widget widget, String callfrom) {
  debugPrint("memcheck : in addAuth $callfrom");
  final AuthCubit authCubit =
  BlocProvider.of<AuthCubit>(context);

  /*
  return StreamBuilder<ConnectivityResult>(
      stream: Connectivity().onConnectivityChanged,
      builder: (context, snapshot) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          if (snapshot.data != null &&
              snapshot.data != ConnectivityResult.mobile &&
              snapshot.data != ConnectivityResult.wifi) {
            AppUtils.showSnackBar('Oops! No internet ', context);
          }
          // debugPrint("SchedulerBinding");
        });
        */
  debugPrint(' inside Before BlocListener ');
  bool listenerrunflag = false;

  return BlocListener(
    bloc: authCubit,
    listener: (BuildContext context, AuthState state) {
      debugPrint("memcheck : in listener ");
      debugPrint(' inside BlocListener $state');
      debugPrint('came inside the loop $listenerrunflag');
      listenerrunflag = true;


    },
    child: BlocBuilder(
      bloc: authCubit,
      builder: (BuildContext context, AuthState state) {
        debugPrint("memcheck : in Blockbuilder ");
        return widget;
      },
    ),
  );

  // });
}
class PageBuilder {
  static Widget buildLoginScreen() {
    return BlocProvider(
      create: (context) {
        final AuthCubit authCubit =
        BlocProvider.of<AuthCubit>(context);
        return LoginCubit(authCubit)..init();
      },
      child: const Login(),
    );
  }
}