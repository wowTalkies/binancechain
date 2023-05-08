import 'package:bnbapp/utils/colors.dart';
import 'package:bnbapp/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:web3dart/credentials.dart';

class TabLeaderBoardWidget extends StatelessWidget {
  final List<String>? userNameList;
  final List<EthereumAddress>? leaderBoard;

  final List<BigInt>? pointsList;

  const TabLeaderBoardWidget(
      {Key? key, this.pointsList, this.userNameList, this.leaderBoard})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: height / 2.8,
            decoration: const BoxDecoration(
              shape: BoxShape.rectangle,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.transparent],
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Stack(
                  children: [
                    Container(
                      width: width / 3.3,
                      height: MediaQuery.of(context).size.height / 3,
                      decoration: const BoxDecoration(
                          shape: BoxShape.rectangle, color: Colors.transparent),
                    ),

                    //////
                    Positioned.fill(
                      top: height / 6,
                      // bottom: 12,
                      child: Center(
                        child: Container(
                          width: width / 3.3,
                          height: height / 6,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12),
                                bottomLeft: Radius.circular(12)),
                            shape: BoxShape.rectangle,
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [AllColor.linear1, AllColor.linear2],
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText(
                                  text: userNameList![1].toString(),
                                  fontWeight: FontWeight.w700,
                                  fontColor: AllColor.white,
                                  fontSize: 14),
                              CustomText(
                                  text: leaderBoard![1]
                                      .toString()
                                      .replaceRange(6, 40, "....."),
                                  fontWeight: FontWeight.w400,
                                  fontColor: AllColor.white,
                                  fontSize: 11),
                              SizedBox(
                                height: height / 50,
                              ),
                              CustomText(
                                  text: pointsList![1].toString(),
                                  fontWeight: FontWeight.w700,
                                  fontColor: AllColor.white,
                                  fontSize: 15),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                        top: height / 50,
                        bottom: height / 8,
                        child: Center(
                          child: CircleAvatar(
                            maxRadius: height / 14,
                            backgroundColor: AllColor.linear2,
                            child: CustomText(
                              fontSize: 40,
                              fontWeight: FontWeight.w400,
                              text: userNameList![1].toString().substring(0, 1),
                              fontColor: AllColor.white,
                            ),
                            // radius: 12,
                          ),
                        )),
                  ],
                ),

                /////
                Stack(
                  children: [
                    Container(
                      width: width / 3.3,
                      height: MediaQuery.of(context).size.height / 2.6,
                      decoration: const BoxDecoration(
                          shape: BoxShape.rectangle, color: Colors.transparent),
                    ),
                    Positioned.fill(
                      top: height / 6.5,
                      child: Container(
                        width: width / 3.3,
                        height: height / 4,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(30),
                              topLeft: Radius.circular(30)),
                          shape: BoxShape.rectangle,
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [AllColor.linear1, AllColor.linear2],
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(
                                text: userNameList![0].toString(),
                                fontWeight: FontWeight.w700,
                                fontColor: AllColor.white,
                                fontSize: 14),
                            CustomText(
                                text: leaderBoard![0]
                                    .toString()
                                    .replaceRange(6, 40, "....."),
                                fontWeight: FontWeight.w400,
                                fontColor: AllColor.white,
                                fontSize: 11),
                            SizedBox(
                              height: height / 30,
                            ),
                            CustomText(
                                text: pointsList![0].toString(),
                                fontWeight: FontWeight.w700,
                                fontColor: AllColor.white,
                                fontSize: 15),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                        bottom: height / 5.7,
                        child: Center(
                          child: CircleAvatar(
                            maxRadius: height / 14,
                            backgroundColor: AllColor.linear2,
                            child: CustomText(
                              fontSize: 40,
                              fontWeight: FontWeight.w400,
                              text: userNameList![0]
                                  .toString()
                                  .substring(0, 1)
                                  .toUpperCase(),
                              fontColor: AllColor.white,
                            ),
                            // radius: 12,
                          ),
                        )),
                    Positioned(
                        left: width / 12,
                        bottom: height / 3.4,
                        child: Center(
                          child: CircleAvatar(
                            maxRadius: height / 30,
                            backgroundColor: Colors.transparent,
                            child: ClipOval(
                                child: Image.asset(
                                    height: height / 5, "images/crown.png")),
                            // radius: 12,
                          ),
                        )),
                  ],
                ),

                /////
                Stack(
                  children: [
                    Container(
                      width: width / 3.3,
                      height: MediaQuery.of(context).size.height / 3,
                      decoration: const BoxDecoration(
                          shape: BoxShape.rectangle, color: Colors.transparent),
                    ),
                    Positioned.fill(
                      top: height / 5,
                      child: Container(
                        height: height / 7,
                        width: width / 3.3,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(12),
                              bottomRight: Radius.circular(12)),
                          shape: BoxShape.rectangle,
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [AllColor.linear1, AllColor.linear2],
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(
                                text: userNameList![2].toString(),
                                fontWeight: FontWeight.w700,
                                fontColor: AllColor.white,
                                fontSize: 14),
                            CustomText(
                                text: leaderBoard![2]
                                    .toString()
                                    .replaceRange(6, 40, "....."),
                                fontWeight: FontWeight.w400,
                                fontColor: AllColor.white,
                                fontSize: 11),
                            SizedBox(
                              height: height / 60,
                            ),
                            CustomText(
                                text: pointsList![2].toString(),
                                fontWeight: FontWeight.w700,
                                fontColor: AllColor.white,
                                fontSize: 15),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                        // left: width / 100,
                        bottom: height / 8.3,
                        child: Center(
                          child: CircleAvatar(
                            maxRadius: height / 14,
                            backgroundColor: AllColor.linear2,
                            child: CustomText(
                              fontSize: 40,
                              fontWeight: FontWeight.w400,
                              text: userNameList![2].toString().substring(0, 1),
                              fontColor: AllColor.white,
                            ),
                            // radius: 12,
                          ),
                        )),
                  ],
                )
              ],
            ),
          ),
        ),

        /////////

        Center(
          child: Container(
            alignment: Alignment.topCenter,
            height: height / 2,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40), topRight: Radius.circular(40)),
              shape: BoxShape.rectangle,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AllColor.linear1,
                  AllColor.linear2,
                ],
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          /*
                          const Padding(
                            padding:
                                EdgeInsets.only(left: 10, top: 10, right: 30),
                            child: CustomText(
                                text: "4",
                                fontWeight: FontWeight.w400,
                                fontColor: AllColor.white,
                                fontSize: 20),
                          ),

                           */
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: CircleAvatar(
                              maxRadius: height / 26,
                              backgroundColor: AllColor.linear2,
                              child: CustomText(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                text:
                                    userNameList![3].toString().substring(0, 1),
                                fontColor: AllColor.white,
                              ),
                              // radius: 12,
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 10),
                              child: SizedBox(
                                height: height / 25,
                                child: Column(
                                  children: [
                                    CustomText(
                                        text: userNameList![3].toString(),
                                        fontWeight: FontWeight.w700,
                                        fontColor: AllColor.white,
                                        fontSize: 13),
                                    const SizedBox(
                                      height: 0,
                                    ),
                                    CustomText(
                                        text: leaderBoard![3]
                                            .toString()
                                            .replaceRange(6, 36, "....."),
                                        fontWeight: FontWeight.w300,
                                        fontColor: AllColor.white,
                                        fontSize: 8),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 10, top: 10),
                        child: CustomText(
                            text: pointsList![3].toString(),
                            fontWeight: FontWeight.w700,
                            fontColor: AllColor.white,
                            fontSize: 12),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  thickness: 2,
                  color: AllColor.linear2,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          /*
                          const Padding(
                            padding:
                                EdgeInsets.only(left: 10, top: 10, right: 30),
                            child: CustomText(
                                text: "5",
                                fontWeight: FontWeight.w400,
                                fontColor: AllColor.white,
                                fontSize: 20),
                          ),

                           */
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: CircleAvatar(
                              maxRadius: height / 26,
                              backgroundColor: AllColor.linear2,
                              child: CustomText(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                text:
                                    userNameList![4].toString().substring(0, 1),
                                fontColor: AllColor.white,
                              ),
                              // radius: 12,
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 10),
                              child: SizedBox(
                                height: height / 25,
                                child: Column(
                                  children: [
                                    CustomText(
                                        text: userNameList![4].toString(),
                                        fontWeight: FontWeight.w700,
                                        fontColor: AllColor.white,
                                        fontSize: 13),
                                    SizedBox(
                                      height: 0,
                                    ),
                                    CustomText(
                                        text: leaderBoard![4]
                                            .toString()
                                            .replaceRange(6, 36, "....."),
                                        fontWeight: FontWeight.w300,
                                        fontColor: AllColor.white,
                                        fontSize: 8),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10, top: 10),
                        child: CustomText(
                            text: pointsList![4].toString(),
                            fontWeight: FontWeight.w700,
                            fontColor: AllColor.white,
                            fontSize: 12),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  thickness: 2,
                  color: AllColor.linear2,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          /*
                          const Padding(
                            padding:
                                EdgeInsets.only(left: 10, top: 10, right: 30),
                            child: CustomText(
                                text: "6",
                                fontWeight: FontWeight.w400,
                                fontColor: AllColor.white,
                                fontSize: 20),
                          ),

                           */
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: CircleAvatar(
                              maxRadius: height / 26,
                              backgroundColor: AllColor.linear2,
                              child: CustomText(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                text:
                                    userNameList![5].toString().substring(0, 1),
                                fontColor: AllColor.white,
                              ),
                              // radius: 12,
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 10),
                              child: SizedBox(
                                height: height / 25,
                                child: Column(
                                  children: [
                                    CustomText(
                                        text: userNameList![5].toString(),
                                        fontWeight: FontWeight.w700,
                                        fontColor: AllColor.white,
                                        fontSize: 13),
                                    const SizedBox(
                                      height: 0,
                                    ),
                                    CustomText(
                                        text: leaderBoard![5]
                                            .toString()
                                            .replaceRange(6, 36, "....."),
                                        fontWeight: FontWeight.w300,
                                        fontColor: AllColor.white,
                                        fontSize: 8),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10, top: 10),
                        child: CustomText(
                            text: pointsList![5].toString(),
                            fontWeight: FontWeight.w700,
                            fontColor: AllColor.white,
                            fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 15,
        ),
      ],
    );
  }
}
