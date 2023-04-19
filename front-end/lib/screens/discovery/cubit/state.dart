
import 'package:bnbapp/utils/base_equatable.dart';

class DiscoverState extends BaseEquatable {}
class DiscoverLoadingState extends DiscoverState {}
class DiscoverErrorState extends DiscoverState{
  final String error;
  DiscoverErrorState(this.error);
  @override
  bool operator ==(Object other) => false;
}