import 'package:bnbapp/utils/colors.dart';
import 'package:bnbapp/widgets/button.dart';
import 'package:bnbapp/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:web3dart/credentials.dart';

class CustomListViewBuilder extends StatelessWidget {
  final int? itemCount;
  final Axis? scrollDirection;
  final List<String>? list;
  final List<String>? textList;
  final List<EthereumAddress>? referralsList;
  final List<String>? referrersList;
  final List<String>? referralsNamesList;

  const CustomListViewBuilder(
      {Key? key,
      this.itemCount,
      this.scrollDirection,
      this.list,
      this.textList,
      this.referralsList,
      this.referrersList,
      this.referralsNamesList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height / 10,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: scrollDirection!,
        itemCount: itemCount,
        itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          content: referrersList != null
                              ? CustomText(
                                  text:
                                      "Address : ${referrersList![1].toString()} \nUser name : ${referrersList![0].toString()}  ",
                                  fontColor: AllColor.white,
                                )
                              : CustomText(
                                  text:
                                      "Address : ${referralsList![index].toString()}  \nUser name : ${referralsNamesList![index].toString()}   ",
                                  fontColor: AllColor.white,
                                ),
                          actions: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Button(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    height: 35,
                                    text: "Close",
                                    textColor: AllColor.white,
                                    color1: AllColor.linear1,
                                    color2: AllColor.linear1),
                              ],
                            )
                          ],
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          backgroundColor: Colors.transparent,
                          iconPadding: const EdgeInsets.only(left: 200),
                          title: const CustomText(
                            fontColor: AllColor.white,
                            text: "User details",
                          ),
                        ));
              },
              child: CircleAvatar(
                radius: height / 30,
                backgroundColor: AllColor.linear2,
                foregroundColor: AllColor.linear2,
                child: CustomText(
                  fontWeight: FontWeight.w600,
                  text: textList![index].toString() ?? "",
                  fontColor: AllColor.white,
                ),
              ),
            )),
      ),
    );
  }
}
