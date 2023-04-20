import 'package:bnbapp/auth_cubit/auth_cubit.dart';
import 'package:bnbapp/screens/profile/cubit/state.dart';
import 'package:bnbapp/utils/base_cubit.dart';
import 'package:flutter/material.dart';

class ProfileCubit extends BaseCubit<ProfileState>{
  final AuthCubit authCubit;
  ProfileCubit(this.authCubit) : super(ProfileInitialState());

  Future<void> init() async {
    emit(ProfileLoadingState());
    debugPrint('hi wellCome come');

    emit(ProfileLoadedState());
  }
}