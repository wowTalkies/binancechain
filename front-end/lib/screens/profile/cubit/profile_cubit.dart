import 'package:bnbapp/auth_cubit/auth_cubit.dart';
import 'package:bnbapp/screens/profile/cubit/profile_state.dart';
import 'package:bnbapp/utils/base_cubit.dart';

class ProfileCubit extends BaseCubit<ProfileState> {
  final AuthCubit authCubit;

  ProfileCubit(this.authCubit) : super(ProfileInitialState());

  Future<void> init() async {
    emit(ProfileLoadingState());
    emit(ProfileLoadedState());
  }
}
