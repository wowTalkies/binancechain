
import 'package:bnbapp/utils/base_equatable.dart';

class ProfileState extends BaseEquatable {}
class ProfileLoadingState extends ProfileState {}
class ProfileErrorState extends ProfileState{
  final String error;
  ProfileErrorState(this.error);
  @override
  bool operator ==(Object other) => false;
}