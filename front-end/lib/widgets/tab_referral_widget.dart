import 'package:bnbapp/utils/colors.dart';
import 'package:bnbapp/widgets/text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'button.dart';

class TabReferralWidget extends StatelessWidget {
  final String? buttonText;
  final Function()? onPressed;
  final List<String>? list;
  final int? itemCount;

  const TabReferralWidget(
      {Key? key, this.onPressed, this.buttonText, this.list, this.itemCount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: height / 10,
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(8),
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [AllColor.linear1, AllColor.linear2],
                  )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(left: 10, top: 5),
                        child: CustomText(
                            text: "Referral \nPoints",
                            fontSize: 16,
                            fontColor: AllColor.white,
                            fontWeight: FontWeight.w700),
                      ),
                      CustomText(
                          text: "0",
                          fontSize: 20,
                          fontColor: AllColor.white,
                          fontWeight: FontWeight.w700),
                    ],
                  ),
                  Column(
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(left: 10, top: 5),
                        child: CustomText(
                            text: "  Total \nInvites",
                            fontSize: 16,
                            fontColor: AllColor.white,
                            fontWeight: FontWeight.w700),
                      ),
                      CustomText(
                          text: "0",
                          fontSize: 20,
                          fontColor: AllColor.white,
                          fontWeight: FontWeight.w700),
                    ],
                  ),
                  Column(
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(left: 10, top: 5, right: 10),
                        child: CustomText(
                            text: "   Total\nAccepted",
                            fontSize: 16,
                            fontColor: AllColor.white,
                            fontWeight: FontWeight.w700),
                      ),
                      CustomText(
                          text: "0",
                          fontSize: 20,
                          fontColor: AllColor.white,
                          fontWeight: FontWeight.w700),
                    ],
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 10),
            child: Button(
              textColor: AllColor.white,
              width: width / 2.5,
              height: height / 20,
              text: buttonText,
              fontWeight: FontWeight.w400,
              color1: AllColor.linear2,
              color2: AllColor.linear2,
              onPressed: onPressed,
            ),
          ),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: itemCount,
            shrinkWrap: true,
            itemBuilder: (context, index) => Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: MediaQuery.of(context).size.height / 30,
                        // width: MediaQuery.of(context).size.width / 0.9,
                        child: ClipOval(
                          // borderRadius: BorderRadius.circular(8.0),
                          child: CachedNetworkImage(
                              height: MediaQuery.of(context).size.height / 7,
                              fit: BoxFit.fill,
                              placeholder: (context, url) => const SizedBox(
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        color: AllColor.white,
                                      ),
                                    ),
                                  ),
                              imageUrl: list?[index] ?? ''),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width / 30,
                    ),
                    Column(
                      children: const [
                        CustomText(
                            text: "Jackie chan",
                            fontSize: 20,
                            fontColor: AllColor.black,
                            fontWeight: FontWeight.w700),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: width / 7, right: 20),
                      child: Container(
                        width: width / 4,
                        height: height / 30,
                        decoration: BoxDecoration(
                            color: AllColor.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12)),
                            border: Border.all(color: AllColor.linear1)),
                        child: const Center(
                          child: CustomText(
                              text: "Accepted",
                              fontSize: 14,
                              fontColor: AllColor.linear1,
                              fontWeight: FontWeight.w300),
                        ),
                      ),
                    )
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Divider(
                    thickness: 1,
                    color: AllColor.linear2,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
