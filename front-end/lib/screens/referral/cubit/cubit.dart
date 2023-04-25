import 'package:bnbapp/auth_cubit/auth_cubit.dart';
import 'package:bnbapp/screens/referral/cubit/state.dart';
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

  ReferralCubit(this.authCubit) : super(ReferralInitialState());

  Future<void> init() async {
    emit(ReferralLoadingState());
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
