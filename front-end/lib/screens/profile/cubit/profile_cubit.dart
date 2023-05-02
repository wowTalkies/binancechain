import 'dart:convert';

import 'package:bnbapp/auth_cubit/auth_cubit.dart';
import 'package:bnbapp/paths/path.dart';
import 'package:bnbapp/screens/profile/cubit/profile_state.dart';
import 'package:bnbapp/utils/base_cubit.dart';
import 'package:bnbapp/utils/preferencehelper.dart';
import 'package:flutter/cupertino.dart';

class ProfileCubit extends BaseCubit<ProfileState> {
  final AuthCubit authCubit;
  Paths paths = Paths();
  TextEditingController? textEditingController = TextEditingController();
  ValueNotifier<String> about = ValueNotifier("");
  String userId = "";

  ProfileCubit(this.authCubit) : super(ProfileInitialState());

  Future<void> init() async {
    emit(ProfileLoadingState());
    await Future.delayed(const Duration(seconds: 3));
    userId = await PreferenceHelper.getUserId() ?? '';
    await paths?.address
        .child(userId.toString())
        .child("About")
        .onValue
        .listen((event) {
      about?.value = jsonDecode(jsonEncode(event.snapshot.value));
      debugPrint("the about is ${about.value.toString()}");
    });

    emit(ProfileLoadedState());
  }

  uploadAbout() async {
    final userId = await PreferenceHelper.getUserId();
    await paths.address
        .child(userId.toString())
        .update({"About": "${textEditingController?.value.text.toString()}"});
  }
}
