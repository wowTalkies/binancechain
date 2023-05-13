import 'package:bnbapp/auth_cubit/auth_cubit.dart';
import 'package:bnbapp/contract/WowTPoints.g.dart';
import 'package:bnbapp/screens/referral/cubit/refrral_state.dart';
import 'package:bnbapp/utils/base_cubit.dart';
import 'package:bnbapp/utils/preferencehelper.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_contacts/flutter_contacts.dart' as cont;
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

class ReferralCubit extends BaseCubit<ReferralState> {
  final AuthCubit authCubit;
  List<cont.Contact> contacts = [];
  final FlutterShareMe flutterShareMe = FlutterShareMe();
  final Email? email = Email();
  TextEditingController textEditingController = TextEditingController();
  ValueNotifier<BigInt> refPoints = ValueNotifier(BigInt.parse("0"));
  Uri? initialLink;
  Uri? deepLink;
  String? queryAddress;
  String? userAddress;
  String? userId;

  ReferralCubit(this.authCubit) : super(ReferralInitialState());

  Future<void> init() async {
    emit(ReferralLoadingState());

    userAddress = await PreferenceHelper.getUserId();
    final httpClient = Client();
    EthereumAddress address = EthereumAddress.fromHex(userAddress.toString());
    Web3Client client = Web3Client(authCubit.node.toString(), httpClient);
    WowTPoints wowTPoints = WowTPoints(
        client: client,
        address:
            EthereumAddress.fromHex(authCubit.profileModel!.points.toString()));
    refPoints.value = await wowTPoints.getReferralPoints(address);

    await cont.FlutterContacts.requestPermission();

    if (await cont.FlutterContacts.requestPermission()) {
      contacts = await cont.FlutterContacts.getContacts(
          withProperties: true, withPhoto: true);
    }
    emit(ReferralLoadedState());
  }

  sendMessage(message, recipients) async {
    List<String> rece = [];
    rece.add(recipients);
    await sendSMS(message: message, recipients: rece);
  }

  createLinkandShare(String channel, recepients) async {
    final dynamicLinkParams = DynamicLinkParameters(
      link: Uri.parse(
          "https://www.wowtalkies.com/referral?invitedby=${userAddress.toString()}"),
      uriPrefix: "https://wowtbnb.page.link",
      //   "https://wowtbnb.page.link/referral?invitedby=987654321",
      androidParameters:
          const AndroidParameters(packageName: "com.wowtbnb.web3"),
      //  iosParameters: const IOSParameters(bundleId: "com.example.app.ios"),
    );
    final dynamicLink =
        //      await FirebaseDynamicLinks.instance.buildLink(dynamicLinkParams);
        await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams);

    switch (channel) {
      case "WhatsApp":
        {
          flutterShareMe.shareToWhatsApp(
              msg:
                  'Use my referral link to download the wowTalkies app - ${dynamicLink.shortUrl}');
          // statements;
        }
        break;
      case "WhatsAppS":
        {
          flutterShareMe.shareToWhatsApp(
              msg:
                  '${textEditingController.value.text}\nUse my referral link to download the wowTalkies app - ${dynamicLink.shortUrl}');
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
              message: '${textEditingController.value.text} '
                  '\nUse my referral link to download the wowTalkies app - ${dynamicLink.shortUrl}',
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
              '${textEditingController.value.text}\nUse my referral link to download the wowTalkies app - ${dynamicLink.shortUrl.toString()}',
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
