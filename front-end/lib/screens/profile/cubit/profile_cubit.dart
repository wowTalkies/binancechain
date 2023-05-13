import 'dart:convert';

import 'package:bnbapp/auth_cubit/auth_cubit.dart';
import 'package:bnbapp/contract/WowTBadge.g.dart';
import 'package:bnbapp/contract/WowTPoints.g.dart';
import 'package:bnbapp/contract/WowTReferral.g.dart';
import 'package:bnbapp/paths/path.dart';
import 'package:bnbapp/screens/profile/cubit/profile_state.dart';
import 'package:bnbapp/utils/base_cubit.dart';
import 'package:bnbapp/utils/preferencehelper.dart';
import 'package:dio/dio.dart';
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
  ValueNotifier<BigInt> points = ValueNotifier(BigInt.parse("0"));
  List<dynamic> badges = [];
  List<dynamic> badgeYearList = [];
  List<dynamic> badgeImageList = [];
  String? fbName;

  ProfileCubit(this.authCubit) : super(ProfileInitialState());

  Future<void> init() async {
    emit(ProfileLoadingState());
    await Future.delayed(const Duration(seconds: 3));
    userId = await PreferenceHelper.getUserId() ?? '';

    final aboutFb =
    await paths?.address.child(userId.toString()).child("About").get();
    debugPrint('the fbRead is ${aboutFb?.value.toString()}');
    if (aboutFb?.value.toString() != null) {
      await paths?.address
          .child(userId.toString())
          .child("About")
          .onValue
          .listen((event) {
        about?.value = jsonDecode(jsonEncode(event.snapshot.value));
        debugPrint("the about is ${about.value.toString()}");
        aboutText = about.value.toString();
      });
    }

    Web3Client client = Web3Client(authCubit.node.toString(), httpClient);
    debugPrint(
        'its coming ${userId.toString().substring(2)} ${EthereumAddress.fromHex(
            userId.toString())}');
    EthereumAddress address = EthereumAddress.fromHex(userId.toString());

    EthereumAddress cdAddressReferral =
    EthereumAddress.fromHex(authCubit.profileModel!.referrals.toString());

    WowTReferral wowTReferral = WowTReferral(
      address: cdAddressReferral,
      client: client,
    );
    referrals = await wowTReferral.getReferrals(address);
    WowTPoints wowTPoints = WowTPoints(
        client: client,
        address:
        EthereumAddress.fromHex(authCubit.profileModel!.points.toString()));
    points.value = await wowTPoints.getPoints(address);
    WowTBadge wowTBadge = WowTBadge(
        client: client,
        address:
        EthereumAddress.fromHex(authCubit.profileModel!.badge.toString()));
    badges = await wowTBadge.getBadges(address);
    for (var z = 0; z < badges.length; z++) {
      badgeYearList.add(badges[z][0]);
      badgeImageList.add(badges[z][1]);
    }
    var userName =
    await paths?.address.child(userId.toString()).child("userName").get();
    fbName = userName?.value.toString().substring(0, 1).toUpperCase();
    debugPrint('the all badge year list ${badgeImageList.toString()}');
    debugPrint('the all badges was ${badgeYearList.toString()}');
    // debugPrint('the all badges are ${badges[0].toString()}');
    for (var j = 0; j < referrals.length; j++) {
      var snapshot = await paths?.address
          .child(referrals[j].toString())
          .child("userName")
          .get();
      referralFullNameList.add(snapshot!.value.toString());
      referralNameList
          .add(snapshot!.value.toString().substring(0, 1).toUpperCase());
    }
    PendingDynamicLinkData? initialLink =
    await FirebaseDynamicLinks.instance.getInitialLink();
    var firstInvite =
    await paths?.address.child(userId!).child("firstInvite").get();
    Uri? initLink = initialLink?.link;
    String? inviteLink = firstInvite?.value.toString();

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


          var jsons = {
            "method": "addReferralPoints",
            "userAddress": userId.toString(),
            "referralAddress": queryAddress.toString()
          };
          final result = await Dio().post(
              authCubit.profileModel!.requestUrl.toString(),
              options: Options(
                  headers: {
                    "x-api-key": authCubit.profileModel!.apiKey.toString()
                  },
                  followRedirects: false,
                  validateStatus: (status) {
                    return status! < 500;
                  }),
              data: jsons);
          debugPrint('the result is ${result.toString()}');
        }
      }
    } catch (ex) {
      debugPrint('the error is ${ex.toString()}');
    }
    referredBy.value = await wowTReferral.getReferrer(address);
    debugPrint('referred by ${referredBy.value.toString()}');
    if (referredBy.value[1] == true) {
      String reAddress = referredBy.value[0].toString();
      var snapshots = await paths?.address
          .child(reAddress.toString())
          .child("userName")
          .get();
      referrerNameAndAddress.add(snapshots!.value.toString());
      referrerNameAndAddress.add(referredBy.value[0].toString());
      referrerName
          .add(snapshots!.value.toString().substring(0, 1).toUpperCase());
    } else {
      debugPrint('no referrals');
    }

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
