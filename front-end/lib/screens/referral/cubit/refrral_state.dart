import 'package:bnbapp/utils/base_equatable.dart';

class ReferralState extends BaseEquatable {}

class ReferralInitialState extends ReferralState {}

class ReferralLoadingState extends ReferralState {}

class ReferralLoadedState extends ReferralState {}

class ReferralErrorState extends ReferralState {
  final String error;

  ReferralErrorState(this.error);

  @override
  bool operator ==(Object other) => false;
}