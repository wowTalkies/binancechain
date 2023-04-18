import 'dart:convert';

import 'package:bnbapp/utils/colors.dart';
import 'package:bnbapp/widgets/button.dart';
import 'package:bnbapp/widgets/textfield.dart';
import 'package:convert/convert.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_sdk/magic_sdk.dart';
import 'package:pointycastle/digests/keccak.dart';
import 'cubit/login_cubit.dart';
import 'cubit/login_state.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LoginCubit>();
    return Scaffold(
      body: BlocListener(
        bloc: cubit,
        listener: (context, state) {
          if (state is LoginErrorState) {
            if (!state.error.contains('404')) {
              const SnackBar(
                content: Text("error"),
              );
            }
          }
        },
        child: const Logins(),
      ),
    );
  }
}

class Logins extends StatefulWidget {
  const Logins({Key? key}) : super(key: key);

  @override
  State<Logins> createState() => _LoginsState();
}

class _LoginsState extends State<Logins> {
  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky,
        overlays: [SystemUiOverlay.bottom]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LoginCubit>();
    return BlocBuilder<LoginCubit, LoginState>(
      bloc: cubit,
      builder: (context, state) => Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          colors: [Color(0xffFFFFFF), Color(0xff1DFCFF)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 3,
                  ),
                  SizedBox(
                    child: Center(
                      child: CustomTextField(
                        obscure: false,
                        //height:  MediaQuery.of(context).size.height/18,
                        width: MediaQuery.of(context).size.width / 1.2,
                        cursorColor: AllColor.black,
                        controller: cubit.controller,
                        hintText: "Enter email",
                        textFieldColor: AllColor.white,
                        prefixWigdget: const Icon(
                          Icons.mail_sharp,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 15,
                  ),
                  Center(
                    child: Button(
                      width: MediaQuery.of(context).size.width / 1.6,
                      text: "Sign in with Google",
                      textSize: 20,
                      image: "images/google.png",
                      onPressed: () async {

                        debugPrint('hello ${cubit.controller.value.text}');
                        await  cubit.login();
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
