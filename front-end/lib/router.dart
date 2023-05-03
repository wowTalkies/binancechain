import 'package:bnbapp/screens/community/cubit/cubit.dart';
import 'package:bnbapp/screens/discovery/cubit/discovery_cubit.dart';
import 'package:bnbapp/screens/login/cubit/login_cubit.dart';
import 'package:bnbapp/screens/login/login_page.dart';
import 'package:bnbapp/screens/profile/cubit/profile_cubit.dart';
import 'package:bnbapp/screens/referral/cubit/referral_cubit.dart';
import 'package:bnbapp/screens/referral/referral.dart';
import 'package:bnbapp/screens/tab/cubit/tab_cubit.dart';
import 'package:bnbapp/screens/tab/tab_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_cubit/auth_cubit.dart';
import 'auth_cubit/auth_state.dart';

class AppRoutes {
  static const String login = "login";
  static const String home = "home";
  static const String referral = "Referral";
}

Route<dynamic> getRoutes(RouteSettings settings) {
  debugPrint('the name is ${settings.name}');

  switch (settings.name) {
    case AppRoutes.login:
      return _buildLoginScreen();
    case AppRoutes.referral:
      return _buildReferralScreen();
    case AppRoutes.home:
      return _buildHomeScreen(settings);
    default:
      return _buildLoginScreen();
  }
}

MaterialPageRoute _buildLoginScreen() {
  return MaterialPageRoute(
    settings: const RouteSettings(name: AppRoutes.login),
    builder: (context) => addAuth(
      context,
      PageBuilder.buildLoginScreen(),
    ),
  );
}

MaterialPageRoute _buildReferralScreen() {
  return MaterialPageRoute(
    settings: const RouteSettings(name: AppRoutes.referral),
    builder: (context) => addAuth(
      context,
      PageBuilder.buildReferralScreen(),
    ),
  );
}

MaterialPageRoute _buildHomeScreen(RouteSettings settings) {
  return MaterialPageRoute(
    settings: const RouteSettings(name: AppRoutes.login),
    builder: (context) => addAuth(
      context,
      PageBuilder.buildHomeScreen(settings),
    ),
  );
}

Widget addAuth(BuildContext context, Widget widget) {
  // debugPrint("memcheck : in addAuth $callfrom");
  final AuthCubit authCubit = BlocProvider.of<AuthCubit>(context);
  debugPrint(' inside Before BlocListener ');
  bool listenerrunflag = false;

  return BlocListener(
    bloc: authCubit,
    listener: (BuildContext context, AuthState state) {
      debugPrint("memcheck : in listener ");
      debugPrint(' inside BlocListener $state');
      debugPrint('came inside the loop $listenerrunflag');
      listenerrunflag = true;

      if (state is AuthenticatedState) {
        Navigator.pushReplacementNamed(context, AppRoutes.home,
            arguments: TabScreenArgs(1));
      } else {
        Navigator.pushReplacementNamed(context, AppRoutes.login);
      }
    },
    child: BlocBuilder(
      bloc: authCubit,
      builder: (BuildContext context, AuthState state) {
        debugPrint("memcheck : in Blockbuilder ");
        if (state is AuthInitialState) {
          return Container(
            color: Colors.white,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return widget;
        }
      },
    ),
  );

  // });
}

class PageBuilder {
  static Widget buildLoginScreen() {
    return BlocProvider(
      create: (context) {
        final AuthCubit authCubit = BlocProvider.of<AuthCubit>(context);
        return LoginCubit(authCubit)..init();
      },
      child: const Login(),
    );
  }

  static Widget buildReferralScreen() {
    return BlocProvider(
      create: (context) {
        final AuthCubit authCubit = BlocProvider.of<AuthCubit>(context);
        return ReferralCubit(authCubit)..init();
      },
      child: const Referral(),
    );
  }

  static Widget buildHomeScreen(RouteSettings settings) {
    debugPrint('inside build home');
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            debugPrint('inside build tabcubit');
            final AuthCubit authenticationCubit =
                BlocProvider.of<AuthCubit>(context);
            final args = settings.arguments as TabScreenArgs;
            return TabScreenCubit(authenticationCubit, args)..init();
          },
        ),
        BlocProvider(create: (context) {
          debugPrint('inside build comcubit');
          final AuthCubit authenticationCubit =
              BlocProvider.of<AuthCubit>(context);
          return CommunityCubit(authenticationCubit)..init();
        }),
        BlocProvider(create: (context) {
          debugPrint('inside build procubit');
          final AuthCubit authenticationCubit =
              BlocProvider.of<AuthCubit>(context);
          return ReferralCubit(authenticationCubit)..init();
        }),
        BlocProvider(create: (context) {
          debugPrint('inside build procubit');
          final AuthCubit authenticationCubit =
              BlocProvider.of<AuthCubit>(context);
          return ProfileCubit(authenticationCubit)..init();
        }),
        BlocProvider(create: (context) {
          debugPrint('inside build discubit');
          final AuthCubit authenticationCubit =
              BlocProvider.of<AuthCubit>(context);
          return DiscoverCubit(authenticationCubit)..init();
        }),
      ],
      child: const TabScreen(),
    );
  }
}
