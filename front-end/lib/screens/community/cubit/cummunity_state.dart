import 'package:bnbapp/utils/base_equatable.dart';

class CommunityState extends BaseEquatable {}

class CommunityInitialState extends CommunityState {}

class CommunityLoadingState extends CommunityState {}

class CommunityLoadedState extends CommunityState {}

class CommunityJointedState extends CommunityState {}

class CommunityJoinCheckState extends CommunityState {}

class CommunityNotJointedState extends CommunityState {}

class CommunityUserJointedState extends CommunityState {}

class CommunityJoinRequestedState extends CommunityState {}

class CommunityPostRequestedState extends CommunityState {}

class CommunityPostedState extends CommunityState {}

class CommunityErrorState extends CommunityState {
  final String error;

  CommunityErrorState(this.error);

  @override
  bool operator ==(Object other) => false;
}
