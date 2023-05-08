import 'package:bnbapp/auth_cubit/auth_cubit.dart';
import 'package:bnbapp/screens/referral/cubit/refrral_state.dart';
import 'package:bnbapp/utils/base_cubit.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_contacts/flutter_contacts.dart' as cont;
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:flutter_sms/flutter_sms.dart';

class ReferralCubit extends BaseCubit<ReferralState> {
  final AuthCubit authCubit;
  List<cont.Contact> contacts = [];
  final FlutterShareMe flutterShareMe = FlutterShareMe();
  final Email? email = Email();
  TextEditingController textEditingController = TextEditingController();

  Uri? initialLink;
  Uri? deepLink;
  String? queryAddress;

  ReferralCubit(this.authCubit) : super(ReferralInitialState());

  Future<void> init() async {
    emit(ReferralLoadingState());
    debugPrint('referral cubit init');
    debugPrint('the userId is ${authCubit.address}');
    /*
    final dynamicLinkParams = DynamicLinkParameters(
      link: Uri.parse("https://wowtbnb.page.link/"),
      uriPrefix:
          "https://wowtbnb.page.link/referral?invitedby=${authCubit.address}",
      androidParameters:
          const AndroidParameters(packageName: "com.wowtbnb.web3"),
      //  iosParameters: const IOSParameters(bundleId: "com.example.app.ios"),
    );
    initialLink =
        await FirebaseDynamicLinks.instance.buildLink(dynamicLinkParams);

    debugPrint("initial link is ${initialLink.toString()}");
    */

    /*
    initialLink = await FirebaseDynamicLinks.instance.getInitialLink();

    debugPrint('referral cubit link ${initialLink.toString()}');
    if (initialLink != null) {
      Uri deepLink = initialLink!.link;
      debugPrint('the link is ${deepLink.toString()}');
      var qAddress = deepLink.query;
      queryAddress = qAddress.toString().substring(10);
      debugPrint('the query address is ${queryAddress.toString()}');
      debugPrint('the link query is ${deepLink.query}');
      // Example of using the dynamic link to push the user to a different screen
      /*
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
      */
    } else {
      debugPrint('referral link null');
    }

     */

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

  createLinkandShare(String channel, recepients) async {
    debugPrint("address is ${authCubit.address} ");
    final dynamicLinkParams = DynamicLinkParameters(
      link: Uri.parse(
          "https://www.wowtalkies.com/referral?invitedby=${authCubit.address}"),
      uriPrefix: "https://wowtbnb.page.link",
      //   "https://wowtbnb.page.link/referral?invitedby=987654321",
      androidParameters:
          const AndroidParameters(packageName: "com.wowtbnb.web3"),
      //  iosParameters: const IOSParameters(bundleId: "com.example.app.ios"),
    );
    final dynamicLink =
        //      await FirebaseDynamicLinks.instance.buildLink(dynamicLinkParams);
        await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams);
    debugPrint("dynamic link is $dynamicLink");

    switch (channel) {
      case "WhatsApp":
        {
          flutterShareMe.shareToWhatsApp(
              msg:
                  'Use my referral link to download the wowTalkies app - ${dynamicLink.shortUrl}');
          // statements;
        }
        break;
      case "Telegram":
        {
          flutterShareMe.shareToTelegram(
              msg:
                  'Use my referral link to download the wowTalkies app - ${dynamicLink.shortUrl}');
          // statements;
        }
        break;
      case "Message":
        {
          List<String> rece = [];
          rece.add(recepients);
          await sendSMS(
              message:
                  'Use my referral link to download the wowTalkies app - ${dynamicLink.shortUrl}',
              recipients: rece);
          // statements;
        }
        break;
      case "Link":
        {
          Clipboard.setData(
              ClipboardData(text: dynamicLink.shortUrl.toString()));
          emit(ReferralLinkCopiedStateState());
          // statements;
        }
        break;
      case "Email":
        var email = Email(
          body:
              'Use my referral link to download the wowTalkies app - ${dynamicLink.shortUrl.toString()}',
          subject: 'App invitation',
          recipients: [],
          isHTML: false,
        );
        await FlutterEmailSender.send(email);
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
