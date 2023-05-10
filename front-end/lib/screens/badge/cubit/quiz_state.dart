import 'package:bnbapp/utils/base_equatable.dart';

class QuizState extends BaseEquatable {}

class QuizInitialState extends QuizState {}

class QuizLoadingState extends QuizState {}

class QuizLoadedState extends QuizState {}

class QuizBackButtonState extends QuizState {}

class QuizCreateRequestedState extends QuizState {}

class QuizAddedState extends QuizState {}

class QuizNotAddedState extends QuizState {}

class QuizAnswerClickedState extends QuizState {}

class QuizAnsweredState extends QuizState {}

class QuizWrongAnswerState extends QuizState {}

class QuizErrorState extends QuizState {
  final String error;

  QuizErrorState(this.error);

  @override
  bool operator ==(Object other) => false;
}
