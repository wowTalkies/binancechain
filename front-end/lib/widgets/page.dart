import 'package:bnbapp/utils/colors.dart';
import 'package:bnbapp/widgets/text.dart';
import 'package:flutter/material.dart';

import 'button.dart';

class CustomPage extends StatelessWidget {
  final Color? color;
  final Color? color4;
  final FontWeight? fontWeight;
  final Function()? onPressed;
  final Function()? whatsAppOnPressed;
  final Function()? instagramOnPressed;
  final Function()? telegramOnPressed;
  final Function()? linkOnPressed;
  final double? fontSize;
  final double? fontSize3;
  final String? referral1;
  final String? referral2;
  final String? referral3;
  final String? referral4;
  final String? text2;
  final String? text3;
  final FontWeight? fontWeight2;
  final Color? color2;
  final double? fontSize2;
  final String? text;
  final String? points1;
  final String? points2;
  final String? points3;

  const CustomPage(
      {Key? key,
      this.color,
      this.fontWeight,
      this.fontSize,
      this.text,
      this.color2,
      this.fontSize2,
      this.fontWeight2,
      this.text2,
      this.text3,
      this.points1,
      this.points2,
      this.points3,
      this.color4,
      this.referral1,
      this.referral2,
      this.referral3,
      this.referral4,
      this.fontSize3,
      this.onPressed,
      this.whatsAppOnPressed,
      this.telegramOnPressed,
      this.instagramOnPressed,
      this.linkOnPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            shape: BoxShape.rectangle,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [AllColor.white, AllColor.white],

              // colors: [AllColor.linear1, AllColor.linear2],
            ),
          ),
        ),
        Positioned.fill(
          bottom: MediaQuery.of(context).size.height / 1.45,
          child: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.rectangle,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [AllColor.linear1, AllColor.linear2],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
                      child: Icon(
                        size: MediaQuery.of(context).size.height / 29,
                        Icons.close,
                        color: AllColor.white,
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 15,
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                              child: CustomText(
                                  fontWeight: fontWeight ?? FontWeight.w400,
                                  fontColor: color,
                                  fontSize: fontSize,
                                  text: text),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 56,
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                              child: CustomText(
                                  fontWeight: fontWeight2 ?? FontWeight.w400,
                                  fontColor: color2,
                                  fontSize: fontSize2,
                                  text: text2),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 100,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                          child: Image.asset(
                            fit: BoxFit.fill,
                            "images/mobile.png",
                            width: 100,
                            height: 120,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned.fill(
            bottom: MediaQuery.of(context).size.height / 2.8,
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width / 1.05,
                height: MediaQuery.of(context).size.height / 7.3,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  shape: BoxShape.rectangle,
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [AllColor.linear1, AllColor.linear2],
                  ),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Container(
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            shape: BoxShape.rectangle,
                            color: AllColor.blue),
                        width: MediaQuery.of(context).size.width / 3.5,
                        height: MediaQuery.of(context).size.height / 9,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(
                              text: points1,
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              fontColor: color,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 70,
                            ),
                            CustomText(
                              text: points2,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              fontColor: color,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 500,
                            ),
                            CustomText(
                              text: points3,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              fontColor: color,
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: CustomText(
                        text: text3,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        fontColor: color,
                      ),
                    )
                  ],
                ),
              ),
            )),
        Positioned.fill(
          top: MediaQuery.of(context).size.height / 2.55,
          child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
              child: Column(
                children: [
                  CustomText(
                    text: "How it works!",
                    fontSize: 16,
                    fontWeight: fontWeight2,
                    fontColor: AllColor.black,
                  ),
                ],
              )),
        ),
        Positioned.fill(
          top: MediaQuery.of(context).size.height / 2.2,
          child: Container(
            color: Colors.white,
            height: 15,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
              child: Image.asset(
                alignment: Alignment.topLeft,
                "images/profile_line.png",
                width: 10,
                height: 10,
              ),
            ),
          ),
        ),
        Positioned.fill(
          top: MediaQuery.of(context).size.height / 2.1,
          child: Center(
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: CustomText(
                      fontWeight: fontWeight2 ?? FontWeight.w400,
                      fontColor: color4,
                      fontSize: fontSize3,
                      text: referral1),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 15,
                ),
                CustomText(
                    fontWeight: fontWeight2 ?? FontWeight.w400,
                    fontColor: color4,
                    fontSize: fontSize3,
                    text: referral2),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 12,
                ),
                CustomText(
                    fontWeight: fontWeight2 ?? FontWeight.w400,
                    fontColor: color4,
                    fontSize: fontSize3,
                    text: referral3),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 12,
                ),
                CustomText(
                    fontWeight: fontWeight2 ?? FontWeight.w400,
                    fontColor: color4,
                    fontSize: fontSize3,
                    text: referral4),
              ],
            ),
          ),
        ),
        Positioned.fill(
            left: MediaQuery.of(context).size.width / 15,
            top: MediaQuery.of(context).size.height / 1.45,
            child: Row(
              children: [
                CustomText(
                    fontWeight: fontWeight2 ?? FontWeight.w400,
                    fontColor: color4,
                    fontSize: fontSize3,
                    text: "See All FAQs"),
                const Icon(Icons.question_mark_rounded),
              ],
            )),
        Positioned.fill(
          top: MediaQuery.of(context).size.height / 1.15,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Button(
                      forTextAlign: 10,
                      fontWeight: FontWeight.w400,
                      textColor: AllColor.white,
                      textSize: 17,
                      color1: AllColor.buttonColor,
                      color2: AllColor.buttonColor,
                      onPressed: onPressed!,
                      height: MediaQuery.of(context).size.height / 20,
                      width: MediaQuery.of(context).size.width / 4,
                      text: "Invite",
                    ),
                  ],
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  children: [
                    InkWell(
                      onTap: linkOnPressed,
                      child: Image.asset(
                        alignment: Alignment.topLeft,
                        "images/link.png",
                        width: 40,
                        height: 40,
                      ),
                    ),
                    CustomText(
                        fontWeight: fontWeight2 ?? FontWeight.w400,
                        fontColor: color4,
                        fontSize: fontSize3,
                        text: "Link")
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  children: [
                    InkWell(
                      onTap: instagramOnPressed,
                      child: Image.asset(
                        alignment: Alignment.topLeft,
                        "images/Instagram.png",
                        width: 40,
                        height: 40,
                      ),
                    ),
                    CustomText(
                        fontWeight: fontWeight2 ?? FontWeight.w400,
                        fontColor: color4,
                        fontSize: fontSize3,
                        text: "Instagram")
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  children: [
                    InkWell(
                      onTap: telegramOnPressed,
                      child: Image.asset(
                        alignment: Alignment.topLeft,
                        "images/telegram.png",
                        width: 40,
                        height: 40,
                      ),
                    ),
                    CustomText(
                        fontWeight: fontWeight2 ?? FontWeight.w400,
                        fontColor: color4,
                        fontSize: fontSize3,
                        text: "Telegram")
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  children: [
                    InkWell(
                      onTap: whatsAppOnPressed,
                      child: Image.asset(
                        alignment: Alignment.topLeft,
                        "images/whatsApp.png",
                        width: 40,
                        height: 40,
                      ),
                    ),
                    CustomText(
                        fontWeight: fontWeight2 ?? FontWeight.w400,
                        fontColor: color4,
                        fontSize: fontSize3,
                        text: "WhatsApp")
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
