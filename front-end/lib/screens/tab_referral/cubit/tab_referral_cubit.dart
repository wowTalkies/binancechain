import 'package:bnbapp/auth_cubit/auth_cubit.dart';
import 'package:bnbapp/contract/WowTPoints.g.dart';
import 'package:bnbapp/contract/WowTReferral.g.dart';
import 'package:bnbapp/paths/path.dart';
import 'package:bnbapp/screens/tab_referral/cubit/tab_referral_state.dart';
import 'package:bnbapp/utils/base_cubit.dart';
import 'package:bnbapp/utils/preferencehelper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

class TabReferralCubit extends BaseCubit<TabReferralState> {
  final AuthCubit authCubit;
  BigInt? referralPoint;
  Paths paths = Paths();
  List<String> userName = [];
  List<String> referralFullNameList = [];
  List<String> referralNameList = [];

  TabReferralCubit(this.authCubit) : super(TabReferralInitialState());
  List<String> list = [
    "https://firebasestorage.googleapis.com/v0/b/bnbhackathon.appspot.com/o/jackie.jpg?alt=media&token=8fe45dfc-6e35-47a1-9bee-c60e4f494e0f",
    "https://firebasestorage.googleapis.com/v0/b/bnbhackathon.appspot.com/o/marvel.jpg?alt=media&token=549b7f2f-ac05-4d81-87dd-3345166dd2e0",
    "https://firebasestorage.googleapis.com/v0/b/bnbhackathon.appspot.com/o/miim.jpg?alt=media&token=0ac0d1a3-a7d2-4c34-84c6-216efd85aee2"
  ];

  Future<void> init() async {
    emit(TabReferralLoadingState());
    debugPrint('hi wellCome');
    var httpClient = Client();
    Web3Client client = Web3Client(authCubit.node.toString(), httpClient);
    WowTPoints wowTReferral = WowTPoints(
        address:
            EthereumAddress.fromHex(authCubit.profileModel!.points.toString()),
        client: client);
    WowTReferral wowTReferrals = WowTReferral(
      address:
          EthereumAddress.fromHex(authCubit.profileModel!.referrals.toString()),
      client: client,
    );
    var preAddress = await PreferenceHelper.getUserId();
    var referrals = await wowTReferrals
        .getReferrals(EthereumAddress.fromHex(preAddress.toString()));
    var address = await PreferenceHelper.getUserId();
    debugPrint(
        'the  userid is ${authCubit.address.toString()}  ${address.toString()}');
    referralPoint = await wowTReferral
        .getReferralPoints(EthereumAddress.fromHex(address.toString()));
    for (var j = 0; j < referrals.length; j++) {
      var snapshot = await paths?.address
          .child(referrals[j].toString())
          .child("userName")
          .get();

      referralFullNameList.add(snapshot!.value.toString());
      referralNameList
          .add(snapshot!.value.toString().substring(0, 1).toUpperCase());

      debugPrint("the username is ${referralNameList.toString()}");
    }
    debugPrint('the referral point is ${referralPoint.toString()}');
    emit(TabReferralLoadedState());
  }
}
