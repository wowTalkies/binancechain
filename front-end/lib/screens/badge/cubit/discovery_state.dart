import 'package:bnbapp/utils/base_equatable.dart';

class QuizState extends BaseEquatable {}

class QuizInitialState extends QuizState {}

class QuizLoadingState extends QuizState {}

class QuizLoadedState extends QuizState {}

class QuizErrorState extends QuizState {
  final String error;

  QuizErrorState(this.error);

  @override
  bool operator ==(Object other) => false;
}
