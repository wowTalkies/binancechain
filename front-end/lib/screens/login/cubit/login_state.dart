import 'package:bnbapp/utils/base_equatable.dart';

class LoginState extends BaseEquatable {}
class LoginInitialState extends LoginState {}
class LoginErrorState extends LoginState{
  final String error;
  LoginErrorState(this.error);
  @override
  bool operator ==(Object other) => false;
}