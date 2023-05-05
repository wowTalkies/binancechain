import 'package:bnbapp/auth_cubit/auth_cubit.dart';
import 'package:bnbapp/utils/base_cubit.dart';
import 'package:flutter/material.dart';

import 'discovery_state.dart';

class QuizCubit extends BaseCubit<QuizState> {
  final AuthCubit authCubit;

  QuizCubit(this.authCubit) : super(QuizInitialState());
  List<String> list = [
    "https://firebasestorage.googleapis.com/v0/b/bnbhackathon.appspot.com/o/jackie.jpg?alt=media&token=8fe45dfc-6e35-47a1-9bee-c60e4f494e0f",
    "https://firebasestorage.googleapis.com/v0/b/bnbhackathon.appspot.com/o/marvel.jpg?alt=media&token=549b7f2f-ac05-4d81-87dd-3345166dd2e0",
    "https://firebasestorage.googleapis.com/v0/b/bnbhackathon.appspot.com/o/miim.jpg?alt=media&token=0ac0d1a3-a7d2-4c34-84c6-216efd85aee2"
  ];

  Future<void> init() async {
    emit(QuizLoadingState());
    debugPrint('hi wellCome');

    emit(QuizLoadedState());
  }
}
