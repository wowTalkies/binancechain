import 'package:bnbapp/utils/base_equatable.dart';

class LeaderBoardState extends BaseEquatable {}

class LeaderBoardInitialState extends LeaderBoardState {}

class LeaderBoardLoadingState extends LeaderBoardState {}

class LeaderBoardLoadedState extends LeaderBoardState {}

class LeaderBoardErrorState extends LeaderBoardState {
  final String error;

  LeaderBoardErrorState(this.error);

  @override
  bool operator ==(Object other) => false;
}
