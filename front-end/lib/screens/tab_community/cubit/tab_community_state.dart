import 'package:bnbapp/utils/base_equatable.dart';

class TabCommunityState extends BaseEquatable {}

class TabCommunityInitialState extends TabCommunityState {}

class TabCommunityLoadingState extends TabCommunityState {}

class TabCommunityLoadedState extends TabCommunityState {}

class TabCommunityErrorState extends TabCommunityState {
  final String error;

  TabCommunityErrorState(this.error);

  @override
  bool operator ==(Object other) => false;
}
