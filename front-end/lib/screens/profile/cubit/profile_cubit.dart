import 'dart:convert';

import 'package:bnbapp/auth_cubit/auth_cubit.dart';
import 'package:bnbapp/contract/WowTReferral.g.dart';
import 'package:bnbapp/paths/path.dart';
import 'package:bnbapp/screens/profile/cubit/profile_state.dart';
import 'package:bnbapp/utils/base_cubit.dart';
import 'package:bnbapp/utils/preferencehelper.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

class ProfileCubit extends BaseCubit<ProfileState> {
  final AuthCubit authCubit;
  Paths paths = Paths();
  TextEditingController textEditingController = TextEditingController();
  ValueNotifier<String> about = ValueNotifier("");
  ValueNotifier<List<dynamic>> referredBy = ValueNotifier([]);
  String userId = "";
  final httpClient = Client();
  String aboutText = "";
  List<String> referralNameList = [];
  List<String> referralFullNameList = [];
  List<String> referrerName = [];
  List<String> referrerNameAndAddress = [];
  List<EthereumAddress> referrals = [];
  BigInt? points;

  ProfileCubit(this.authCubit) : super(ProfileInitialState());

  Future<void> init() async {
    emit(ProfileLoadingState());
    await Future.delayed(const Duration(seconds: 3));
    userId = await PreferenceHelper.getUserId() ?? '';
    await paths?.address
        .child(userId.toString())
        .child("About")
        .onValue
        .listen((event) {
      about?.value = jsonDecode(jsonEncode(event.snapshot.value));
      debugPrint("the about is ${about.value.toString()}");
      aboutText = about.value.toString();
    });
    Web3Client client = Web3Client(authCubit.node.toString(), httpClient);
    debugPrint(
        'its coming ${userId.toString().substring(2)} ${EthereumAddress.fromHex(userId.toString())}');
    EthereumAddress address = EthereumAddress.fromHex(userId.toString());

    EthereumAddress cdAddressReferral =
        EthereumAddress.fromHex(authCubit.profileModel!.referrals.toString());

    WowTReferral wowTReferral = WowTReferral(
      address: cdAddressReferral,
      client: client,
    );
    referrals = await wowTReferral.getReferrals(address);
    for (var j = 0; j < referrals.length; j++) {
      var snapshot = await paths?.address
          .child(referrals[j].toString())
          .child("userName")
          .get();
      referralFullNameList.add(snapshot!.value.toString());
      referralNameList
          .add(snapshot!.value.toString().substring(0, 1).toUpperCase());
      debugPrint("the username is ${snapshot?.value.toString()}");
    }
    debugPrint('the referral lis is ${referrals.toString()}');

    PendingDynamicLinkData? initialLink =
        await FirebaseDynamicLinks.instance.getInitialLink();

    debugPrint('referral cubit link ${initialLink?.link.toString()}');
    var firstInvite =
        await paths?.address.child(userId!).child("firstInvite").get();
    debugPrint("first invite is ${firstInvite?.value.toString()}");
    Uri? initLink = initialLink?.link;
    String? inviteLink = firstInvite?.value.toString();
    debugPrint("initLink is $initLink and invite link is $inviteLink");

    try {
      if (initLink != null) {
        if (inviteLink == "null") {
          Uri deepLink = initialLink!.link;
          debugPrint('the link is ${deepLink.toString()}');
          var qAddress = deepLink.query;
          var queryAddress = qAddress.toString().substring(10);
          debugPrint('the query address is ${queryAddress.toString()}');
          debugPrint('the link query is ${deepLink.query}');

          await paths?.address
              .child(userId!)
              .update({"firstInvite": "Invited"});
        }
      }
    } catch (ex) {
      debugPrint('the error is ${ex.toString()}');
    }
    // var referredBy = await wowTReferral.getReferrals(address);
    referredBy.value = await wowTReferral.getReferrer(address);
    debugPrint('referred by ${referredBy.value.toString()}');
    if (referredBy.value[1] == true) {
      var snapshots = await paths?.address
          .child(referrals[0].toString())
          .child("userName")
          .get();
      referrerNameAndAddress.add(snapshots!.value.toString());
      referrerNameAndAddress.add(referredBy.value[0].toString());
      referrerName
          .add(snapshots!.value.toString().substring(0, 1).toUpperCase());
      debugPrint(
          'referred by ${snapshots!.value.toString().substring(0, 1).toUpperCase()}');
    } else {
      debugPrint('no referrals');
    }
    debugPrint('its coming');
    debugPrint('the total points are ${points.toString()}');
    emit(ProfileLoadedState());
  }

  copyAddress(address) {
    Clipboard.setData(ClipboardData(text: address.toString()));
    emit(ProfileCopyStateState());
  }

  uploadAbout() async {
    final userId = await PreferenceHelper.getUserId();
    await paths.address
        .child(userId.toString())
        .update({"About": "${textEditingController?.value.text.toString()}"});
  }
}
