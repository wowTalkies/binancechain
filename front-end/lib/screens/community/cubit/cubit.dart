import 'package:bnbapp/auth_cubit/auth_cubit.dart';
import 'package:bnbapp/screens/community/cubit/state.dart';
import 'package:bnbapp/utils/base_cubit.dart';
import 'package:flutter/material.dart';

class CommunityCubit extends BaseCubit<CommunityState>{
  CommunityCubit(AuthCubit authCubit) : super(CommunityState());

  Future<void> init() async {
    emit(CommunityLoadingState());
    debugPrint('hi wellCome');
  }
}