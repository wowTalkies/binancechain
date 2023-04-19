import 'package:bnbapp/utils/base_equatable.dart';

class LoginState extends BaseEquatable {}
class LoginErrorState extends LoginState{
  final String error;
  LoginErrorState(this.error);
  @override
  bool operator ==(Object other) => false;
}