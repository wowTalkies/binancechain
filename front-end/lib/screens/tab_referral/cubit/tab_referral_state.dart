import 'package:bnbapp/utils/base_equatable.dart';

class TabReferralState extends BaseEquatable {}

class TabReferralInitialState extends TabReferralState {}

class TabReferralLoadingState extends TabReferralState {}

class TabReferralLoadedState extends TabReferralState {}

class TabReferralErrorState extends TabReferralState {
  final String error;

  TabReferralErrorState(this.error);

  @override
  bool operator ==(Object other) => false;
}
