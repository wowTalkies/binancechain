import 'package:bnbapp/auth_cubit/auth_cubit.dart';
import 'package:bnbapp/screens/referral/cubit/refrral_state.dart';
import 'package:bnbapp/utils/base_cubit.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart' as cont;
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:flutter_sms/flutter_sms.dart';

class ReferralCubit extends BaseCubit<ReferralState> {
  final AuthCubit authCubit;
  List<cont.Contact> contacts = [];
  final FlutterShareMe flutterShareMe = FlutterShareMe();
  final Email? email = Email();
  PendingDynamicLinkData? initialLink;
  Uri? deepLink;
  String? queryAddress;

  ReferralCubit(this.authCubit) : super(ReferralInitialState());

  Future<void> init() async {
    emit(ReferralLoadingState());
    debugPrint('referral cubit init');
    initialLink = await FirebaseDynamicLinks.instance.getInitialLink();

    if (initialLink != null) {
      Uri deepLink = initialLink!.link;
      debugPrint('the link is ${deepLink.toString()}');
      var qAddress = deepLink.query;
      queryAddress = qAddress.toString().substring(10);
      debugPrint('the query address is ${queryAddress.toString()}');
      debugPrint('the link query is ${deepLink.query}');
      // Example of using the dynamic link to push the user to a different screen
      FirebaseDynamicLinks.instance.onLink.listen(
        (pendingDynamicLinkData) {
          // Set up the `onLink` event listener next as it may be received here
          if (pendingDynamicLinkData != null) {
            deepLink = pendingDynamicLinkData.link;
            debugPrint('pending link dynamic data is ${deepLink.toString()}');
            // Example of using the dynamic link to push the user to a different screen
          } else {
            debugPrint('pending link dynamic data null');
          }
        },
      );
    } else {
      debugPrint('referral link null');
    }

    await cont.FlutterContacts.requestPermission();
    debugPrint('hi wellCome come');
    // Get contact with specific ID (fully fetched)
    debugPrint('the contacts are ${contacts.toString()}');
    if (await cont.FlutterContacts.requestPermission()) {
      contacts = await cont.FlutterContacts.getContacts(
          withProperties: true, withPhoto: true);
      debugPrint('the contacts is ${contacts.toString()}');
    }
    emit(ReferralLoadedState());
  }

  sendMessage(message, recipients) async {
    List<String> rece = [];
    rece.add(recipients);
    await sendSMS(message: message, recipients: rece);
  }

  createLinkandShare(String channel) async {
    final dynamicLinkParams = DynamicLinkParameters(
      link: Uri.parse(
          "https://www.wowtalkies.com/referral?invitedby=1234567654321"),
      uriPrefix: "https://wowtbnb.page.link",
      androidParameters:
          const AndroidParameters(packageName: "com.wowtbnb.web3"),
      //  iosParameters: const IOSParameters(bundleId: "com.example.app.ios"),
    );
    final dynamicLink =
        await FirebaseDynamicLinks.instance.buildLink(dynamicLinkParams);

    switch (channel) {
      case "WhatsApp":
        {
          flutterShareMe.shareToWhatsApp(
              msg:
                  'Use my referral link to download the wowTalkies app - ${initialLink.toString()}');
          // statements;
        }
        break;
      case "Instagram":
        {
          flutterShareMe.shareToInstagram(
              filePath:
                  'Use my referral link to download the wowTalkies app - ${dynamicLink.toString()}');
          // statements;
        }
        break;
      case "Telegram":
        {
          flutterShareMe.shareToTelegram(
              msg:
                  'Use my referral link to download the wowTalkies app - ${dynamicLink.toString()}');
          // statements;
        }
        break;
      case "Link":
        {
          flutterShareMe.shareToTelegram(
              msg:
                  'Use my referral link to download the wowTalkies app - ${dynamicLink.toString()}');
          // statements;
        }
        break;

      default:
        {
          //statements;
        }
        break;
    }
  }

  send() async {
    //cont.Contact? contact = await cont.FlutterContacts.getContact(contacts.first.id);
    await cont.FlutterContacts.openExternalView(contacts[0].id);
    // await cont.FlutterContacts.openExternalInsert();
  }
}
