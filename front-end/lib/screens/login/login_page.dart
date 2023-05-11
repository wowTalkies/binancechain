import 'package:bnbapp/utils/colors.dart';
import 'package:bnbapp/widgets/button.dart';
import 'package:bnbapp/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  Widget build(BuildContext context) {
    final cubit = context.read<LoginCubit>();
    return BlocBuilder<LoginCubit, LoginState>(
      bloc: cubit,
      builder: (context, state) => Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          colors: [AllColor.white, AllColor.white],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 5,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 3,
                    child: Image.asset("images/playstore.png"),
                  ),
                  SizedBox(
                    height: 45,
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
                  /*
                  ElevatedButton(
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut();
                      },
                      child: const Text('Logout')),

                   */
                  Center(
                    child: Button(
                      color1: AllColor.linear1,
                      color2: AllColor.linear1,
                      width: MediaQuery.of(context).size.width / 2,
                      height: MediaQuery.of(context).size.height / 20,
                      text: "Login/Sign up",
                      textSize: 16,
                      textColor: AllColor.white,
                      //image: "images/person.png",
                      onPressed: () async {
                        debugPrint('hello ${cubit.controller.value.text}');
                        await cubit.login();
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
