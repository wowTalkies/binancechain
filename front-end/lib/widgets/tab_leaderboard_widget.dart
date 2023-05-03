import 'package:bnbapp/utils/colors.dart';
import 'package:bnbapp/widgets/text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class TabLeaderBoardWidget extends StatelessWidget {
  const TabLeaderBoardWidget({Key? key}) : super(key: key);

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
                              const CustomText(
                                  text: "Jackie chan",
                                  fontWeight: FontWeight.w700,
                                  fontColor: AllColor.white,
                                  fontSize: 14),
                              const CustomText(
                                  text: "@Jackie",
                                  fontWeight: FontWeight.w400,
                                  fontColor: AllColor.white,
                                  fontSize: 11),
                              SizedBox(
                                height: height / 50,
                              ),
                              const CustomText(
                                  text: "1024",
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
                            backgroundColor: AllColor.linear1,
                            child: ClipOval(
                              child: CachedNetworkImage(
                                height: height / 7.3,
                                width: width / 3.6,
                                fit: BoxFit.fill,
                                placeholder: (context, url) => const SizedBox(
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color: AllColor.white,
                                    ),
                                  ),
                                ),
                                imageUrl:
                                    "https://firebasestorage.googleapis.com/v0/b/bnbhackathon.appspot.com/o/jackie.jpg?alt=media&token=8fe45dfc-6e35-47a1-9bee-c60e4f494e0f",
                              ),
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
                      top: height / 6,
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
                            const CustomText(
                                text: "Jackie chan",
                                fontWeight: FontWeight.w700,
                                fontColor: AllColor.white,
                                fontSize: 14),
                            const CustomText(
                                text: "@Jackie",
                                fontWeight: FontWeight.w400,
                                fontColor: AllColor.white,
                                fontSize: 11),
                            SizedBox(
                              height: height / 30,
                            ),
                            const CustomText(
                                text: "1024",
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
                            backgroundColor: AllColor.linear1,
                            child: ClipOval(
                              child: CachedNetworkImage(
                                height: height / 7.3,
                                width: width / 3.6,
                                fit: BoxFit.fill,
                                placeholder: (context, url) => const SizedBox(
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color: AllColor.white,
                                    ),
                                  ),
                                ),
                                imageUrl:
                                    "https://firebasestorage.googleapis.com/v0/b/bnbhackathon.appspot.com/o/jackie.jpg?alt=media&token=8fe45dfc-6e35-47a1-9bee-c60e4f494e0f",
                              ),
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
                            const CustomText(
                                text: "Jackie chan",
                                fontWeight: FontWeight.w700,
                                fontColor: AllColor.white,
                                fontSize: 14),
                            const CustomText(
                                text: "@Jackie",
                                fontWeight: FontWeight.w400,
                                fontColor: AllColor.white,
                                fontSize: 11),
                            SizedBox(
                              height: height / 60,
                            ),
                            const CustomText(
                                text: "1024",
                                fontWeight: FontWeight.w700,
                                fontColor: AllColor.white,
                                fontSize: 15),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                        left: width / 100,
                        bottom: height / 8.3,
                        child: Center(
                          child: CircleAvatar(
                            maxRadius: height / 14,
                            backgroundColor: AllColor.linear1,
                            child: ClipOval(
                              child: CachedNetworkImage(
                                height: height / 7.3,
                                width: width / 3.6,
                                fit: BoxFit.fill,
                                placeholder: (context, url) => const SizedBox(
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color: AllColor.white,
                                    ),
                                  ),
                                ),
                                imageUrl:
                                    "https://firebasestorage.googleapis.com/v0/b/bnbhackathon.appspot.com/o/jackie.jpg?alt=media&token=8fe45dfc-6e35-47a1-9bee-c60e4f494e0f",
                              ),
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
                          const Padding(
                            padding:
                                EdgeInsets.only(left: 10, top: 10, right: 30),
                            child: CustomText(
                                text: "4",
                                fontWeight: FontWeight.w400,
                                fontColor: AllColor.white,
                                fontSize: 20),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: CircleAvatar(
                              maxRadius: height / 26,
                              backgroundColor: AllColor.linear2,
                              child: ClipOval(
                                child: CachedNetworkImage(
                                  height: height / 11,
                                  width: width / 5.3,
                                  fit: BoxFit.fill,
                                  placeholder: (context, url) => const SizedBox(
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        color: AllColor.white,
                                      ),
                                    ),
                                  ),
                                  imageUrl:
                                      "https://firebasestorage.googleapis.com/v0/b/bnbhackathon.appspot.com/o/jackie.jpg?alt=media&token=8fe45dfc-6e35-47a1-9bee-c60e4f494e0f",
                                ),
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
                                  children: const [
                                    CustomText(
                                        text: "Jackie Chan",
                                        fontWeight: FontWeight.w700,
                                        fontColor: AllColor.white,
                                        fontSize: 13),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    CustomText(
                                        text: "@Jackie",
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
                      const Padding(
                        padding: EdgeInsets.only(right: 10, top: 10),
                        child: CustomText(
                            text: "1024",
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
                          const Padding(
                            padding:
                                EdgeInsets.only(left: 10, top: 10, right: 30),
                            child: CustomText(
                                text: "5",
                                fontWeight: FontWeight.w400,
                                fontColor: AllColor.white,
                                fontSize: 20),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: CircleAvatar(
                              maxRadius: height / 26,
                              backgroundColor: AllColor.linear2,
                              child: ClipOval(
                                child: CachedNetworkImage(
                                  height: height / 11,
                                  width: width / 5.3,
                                  fit: BoxFit.fill,
                                  placeholder: (context, url) => const SizedBox(
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        color: AllColor.white,
                                      ),
                                    ),
                                  ),
                                  imageUrl:
                                      "https://firebasestorage.googleapis.com/v0/b/bnbhackathon.appspot.com/o/jackie.jpg?alt=media&token=8fe45dfc-6e35-47a1-9bee-c60e4f494e0f",
                                ),
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
                                  children: const [
                                    CustomText(
                                        text: "Jackie Chan",
                                        fontWeight: FontWeight.w700,
                                        fontColor: AllColor.white,
                                        fontSize: 13),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    CustomText(
                                        text: "@Jackie",
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
                      const Padding(
                        padding: EdgeInsets.only(right: 10, top: 10),
                        child: CustomText(
                            text: "1024",
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
                          const Padding(
                            padding:
                                EdgeInsets.only(left: 10, top: 10, right: 30),
                            child: CustomText(
                                text: "6",
                                fontWeight: FontWeight.w400,
                                fontColor: AllColor.white,
                                fontSize: 20),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: CircleAvatar(
                              maxRadius: height / 26,
                              backgroundColor: AllColor.linear2,
                              child: ClipOval(
                                child: CachedNetworkImage(
                                  height: height / 11,
                                  width: width / 5.3,
                                  fit: BoxFit.fill,
                                  placeholder: (context, url) => const SizedBox(
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        color: AllColor.white,
                                      ),
                                    ),
                                  ),
                                  imageUrl:
                                      "https://firebasestorage.googleapis.com/v0/b/bnbhackathon.appspot.com/o/jackie.jpg?alt=media&token=8fe45dfc-6e35-47a1-9bee-c60e4f494e0f",
                                ),
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
                                  children: const [
                                    CustomText(
                                        text: "Jackie Chan",
                                        fontWeight: FontWeight.w700,
                                        fontColor: AllColor.white,
                                        fontSize: 13),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    CustomText(
                                        text: "@Jackie",
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
                      const Padding(
                        padding: EdgeInsets.only(right: 10, top: 10),
                        child: CustomText(
                            text: "1024",
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
              ],
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 9,
        ),
      ],
    );
  }
}
