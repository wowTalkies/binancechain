import 'package:bnbapp/auth_cubit/auth_cubit.dart';
import 'package:bnbapp/screens/tab/cubit/tab_state.dart';
import 'package:bnbapp/utils/base_cubit.dart';
import 'package:flutter/material.dart';

class TabScreenCubit extends BaseCubit<TabScreenState>{
  TabScreenCubit(AuthCubit authCubit, TabScreenArgs args) : super(TabScreenState()){
    if (args.toString().isNotEmpty) {
      tabIndex = args.tabIndex;
    }
  }
  int tabIndex = 0;
  Future<void> init() async {
    debugPrint('hi wellCome');
  }
  void onTabIndexChanged(int index) {
    tabIndex = index;
    debugPrint('the value is $index');
    emit(TabScreenRefreshState());
  }
}
class TabScreenArgs {
  final int tabIndex;
  TabScreenArgs(this.tabIndex);
}