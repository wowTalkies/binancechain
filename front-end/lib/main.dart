import 'package:bnbapp/router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_sdk/magic_sdk.dart';

import 'auth_cubit/auth_cubit.dart';
import 'cubit.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseDatabase.instance.setPersistenceEnabled(true);
  // Bloc.observer = EchoCubitDelegate();
  //Bloc.transformer = sequential();
  Magic.instance = Magic.custom("pk_live_39D28DAB364BEA4E",
      rpcUrl:
      "https://polygon-mumbai.infura.io/v3/2f65062b3f004d508ecf97a377b4e1d0",
      chainId: 80001);
  BlocOverrides.runZoned(
        () {
      runApp(BlocProvider<AuthCubit>(
        create: (BuildContext context) {
          return AuthCubit()
            ..init();
        },
        child: const MaterialApp(
          home: MyApp(),
          debugShowCheckedModeBanner: false,
        ),
      ));
    },
    blocObserver: EchoCubitDelegate(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MaterialApp(
          onGenerateRoute: getRoutes,
          debugShowCheckedModeBanner: false,
          home: addAuth(context, Container()),
/*
          home: BlocProvider(
            create: (context) {
              final AuthCubit authenticationCubit =
                  BlocProvider.of<AuthCubit>(context);
              return FAQCubit(authenticationCubit)..init();
            },
            child: const FAQ(),
          ),

 */
        ),
        Magic.instance.relayer,
      ],
    );
  }
}
