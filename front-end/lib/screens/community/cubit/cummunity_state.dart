
import 'package:bnbapp/utils/base_equatable.dart';

class CommunityState extends BaseEquatable {}
class CommunityInitialState extends CommunityState {}
class CommunityLoadingState extends CommunityState {}
class CommunityLoadedState extends CommunityState {}
class CommunityErrorState extends CommunityState{
  final String error;
  CommunityErrorState(this.error);
  @override
  bool operator ==(Object other) => false;
}