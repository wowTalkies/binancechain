import 'package:bnbapp/auth_cubit/auth_cubit.dart';
import 'package:bnbapp/screens/tab/cubit/tab_state.dart';
import 'package:bnbapp/utils/base_cubit.dart';

class TabScreenCubit extends BaseCubit<TabScreenState> {
  final AuthCubit authenticationCubit;
  int tabIndex = 0;
  TabScreenCubit(this.authenticationCubit, TabScreenArgs? args)
      : super(TabScreenInitialState()) {
    if (args != null) {
      tabIndex = args.tabIndex;
    }
  }
  Future<void> init() async {}

  void onTabIndexChanged(int index) {
    emit(TabScreenLoadingState());
    tabIndex = index;
    emit(TabScreenRefreshState());
  }
}

class TabScreenArgs {
  final int tabIndex;
  TabScreenArgs(this.tabIndex);
}
