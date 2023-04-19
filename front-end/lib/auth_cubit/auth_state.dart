import 'package:bnbapp/utils/base_equatable.dart';

class AuthState extends BaseEquatable {}
class AuthInitialState extends AuthState {}
class AuthenticatedState extends AuthState {}
class AuthRefreshState extends AuthState {}
class UnAuthenticatedState extends AuthState {}