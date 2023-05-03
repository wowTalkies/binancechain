
import 'package:bnbapp/utils/base_equatable.dart';

class DiscoverState extends BaseEquatable {}
class DiscoveryInitialState extends DiscoverState {}
class DiscoverLoadingState extends DiscoverState {}
class DiscoverLoadedState extends DiscoverState {}
class DiscoverErrorState extends DiscoverState{
  final String error;
  DiscoverErrorState(this.error);
  @override
  bool operator == (Object other) => false;


}