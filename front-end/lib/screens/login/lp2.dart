import 'package:flutter/material.dart';

import 'package:magic_sdk/magic_sdk.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Magic magic = Magic.instance;

  final myController = TextEditingController(text: 'sivasethu@wowtalkies.com');

  @override
  void initState() {
    super.initState();

    /// Checks if the user is already loggedIn
    var future = magic.user.isLoggedIn();
    future.then((isLoggedIn) {
      if (isLoggedIn) {
        /// Navigate to home page
        //   Navigator.push(context,
        //       MaterialPageRoute(builder: (context) => const HomePage()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Magic Demo Login'),
          automaticallyImplyLeading: false,
        ),
        body: Center(
            child:
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: TextFormField(
                  controller: myController,
                  decoration: const InputDecoration(
                    hintText: 'Enter your email',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
              ), Magic.instance.relayer,
              TextButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                ),
                onPressed: () async {

                  debugPrint('hi hello how are');
                  await magic.auth.loginWithMagicLink(email: "sivasethu@wowtalkies.com");
                  final account = await MagicCredential(magic.provider).getAccount();
                  debugPrint('token, $account');
                  },
                child: const Text('Login With Magic Link'),
              ),
            ])));
  }
}