import 'dart:convert';

import 'package:bnbapp/auth_cubit/WowTReferral.g.dart';
import 'package:bnbapp/auth_cubit/auth_cubit.dart';
import 'package:bnbapp/paths/path.dart';
import 'package:bnbapp/screens/profile/cubit/profile_state.dart';
import 'package:bnbapp/utils/base_cubit.dart';
import 'package:bnbapp/utils/preferencehelper.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

class ProfileCubit extends BaseCubit<ProfileState> {
  final AuthCubit authCubit;
  Paths paths = Paths();
  TextEditingController? textEditingController = TextEditingController();
  ValueNotifier<String> about = ValueNotifier("");
  ValueNotifier<List<dynamic>> referredBy = ValueNotifier([]);
  String userId = "";
  final httpClient = Client();

  // List<dynamic> referredBy = [];
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
    });
    Web3Client client = Web3Client(authCubit.node.toString(), httpClient);
    debugPrint(
        'its coming ${userId.toString().substring(2)} ${EthereumAddress.fromHex(userId.toString())}');
    EthereumAddress address = EthereumAddress.fromHex(userId.toString());

    EthereumAddress cdAddressReferral =
        EthereumAddress.fromHex("0x8267D49a6E55A459428F820e4FecDF50BD89a139");

    WowTReferral wowTReferral = WowTReferral(
      address: cdAddressReferral,
      client: client,
    );
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
    referredBy.value = await wowTReferral.getReferrals(address);
    //debugPrint('referred by ${referredBy.toString()}');
    if (referredBy.value[1] == true) {
      debugPrint('referred by ${referredBy.value[1].toString()}');
    } else {
      debugPrint('no referrals');
    }
    debugPrint('its coming');
    debugPrint('the total points are ${points.toString()}');
    emit(ProfileLoadedState());
  }

  uploadAbout() async {
    final userId = await PreferenceHelper.getUserId();
    await paths.address
        .child(userId.toString())
        .update({"About": "${textEditingController?.value.text.toString()}"});
  }
}
