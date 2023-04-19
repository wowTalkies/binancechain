
import 'package:bnbapp/utils/base_equatable.dart';

class CommunityState extends BaseEquatable {}
class CommunityLoadingState extends CommunityState {}
class CommunityErrorState extends CommunityState{
  final String error;
  CommunityErrorState(this.error);
  @override
  bool operator ==(Object other) => false;
}