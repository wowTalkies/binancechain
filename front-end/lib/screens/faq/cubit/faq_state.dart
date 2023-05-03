import 'package:bnbapp/utils/base_equatable.dart';

class FAQState extends BaseEquatable {}

class FAQInitialState extends FAQState {}

class FAQLoadingState extends FAQState {}

class FAQLoadedState extends FAQState {}

class FAQErrorState extends FAQState {
  final String error;

  FAQErrorState(this.error);

  @override
  bool operator ==(Object other) => false;
}
