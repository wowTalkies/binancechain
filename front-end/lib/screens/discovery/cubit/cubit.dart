import 'package:bnbapp/auth_cubit/auth_cubit.dart';
import 'package:bnbapp/screens/discovery/cubit/state.dart';
import 'package:bnbapp/utils/base_cubit.dart';
import 'package:flutter/material.dart';

class DiscoverCubit extends BaseCubit<DiscoverState>{
  DiscoverCubit(AuthCubit authCubit) : super(DiscoverState());

  Future<void> init() async {
    emit(DiscoverLoadingState());
    debugPrint('hi wellCome');
  }
}