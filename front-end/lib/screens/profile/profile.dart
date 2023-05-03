import 'package:bnbapp/screens/profile/cubit/profile_cubit.dart';
import 'package:bnbapp/screens/profile/cubit/profile_state.dart';
import 'package:bnbapp/utils/colors.dart';
import 'package:bnbapp/widgets/button.dart';
import 'package:bnbapp/widgets/custom_listview_builder.dart';
import 'package:bnbapp/widgets/tabs.dart';
import 'package:bnbapp/widgets/text.dart';
import 'package:bnbapp/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProfileCubit>();
    return Scaffold(
      body: BlocListener(
        bloc: cubit,
        listener: (context, state) {
          if (state is ProfileErrorState) {
            if (!state.error.contains('404')) {
              const SnackBar(
                content: Text("error"),
              );
            }
          }
        },
        child: const _LayOut(),
      ),
    );
    ;
  }
}

class _LayOut extends StatelessWidget {
  const _LayOut({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final cubit = context.read<ProfileCubit>();
    return BlocBuilder<ProfileCubit, ProfileState>(
        bloc: cubit,
        builder: (context, state) => Column(
              children: [
                Expanded(
                    child: ListView(
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(9, 0, 0, 0),
                      child: CustomText(
                          text: "Badge",
                          fontSize: 13,
                          fontColor: AllColor.black,
                          fontWeight: FontWeight.w700),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Tabs(
                            imageContainerWidth: width / 4.6,
                            imageContainerHeight: height / 26,
                            width: width / 4.5,
                            height: height / 25,
                            assetImage: "images/pink.png",
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Padding(
                              padding: EdgeInsets.fromLTRB(9, 0, 0, 0),
                              child: CustomText(
                                  text: "About",
                                  fontSize: 13,
                                  fontColor: AllColor.black,
                                  fontWeight: FontWeight.w700),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 10, bottom: 5),
                              child: InkWell(
                                onTap: () {
                                  showBottomSheet(
                                    context: context,
                                    builder: (context) => Container(
                                      height: height / 1.8,
                                      width: width,
                                      decoration: BoxDecoration(
                                        border:
                                            Border.all(color: AllColor.black),
                                        borderRadius: BorderRadius.circular(8),
                                        color: AllColor.bottomSheet,
                                      ),
                                      child: Column(
                                        children: [
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                height: height / 5,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: AllColor.black),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  color: AllColor.bottomSheet,
                                                ),
                                                child: CustomTextField(
                                                    height: 40,
                                                    controller: cubit
                                                        .textEditingController,
                                                    hintText: "Enter about",
                                                    textFieldColor:
                                                        AllColor.bottomSheet,
                                                    width: width / 1.2),
                                              ),
                                            ),
                                          ),
                                          Button(
                                            textColor: AllColor.white,
                                            color1: AllColor.linear2,
                                            color2: AllColor.linear2,
                                            text: "Enter",
                                            width: width / 2,
                                            height: height / 17,
                                            onPressed: () async {
                                              await cubit.uploadAbout();
                                              Navigator.pop(context);
                                            },
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                child: const Icon(
                                  Icons.edit,
                                  color: AllColor.black,
                                  size: 30,
                                ),
                              ),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(9, 0, 0, 0),
                              child: ValueListenableBuilder(
                                valueListenable: cubit.about,
                                builder: (context, value, child) => CustomText(
                                    text: value.toString(),
                                    fontSize: 14,
                                    fontColor: AllColor.black,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: height / 90,
                    ),
                    Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.fromLTRB(9, 0, 0, 0),
                          child: CustomText(
                              text: "Referred by",
                              fontSize: 13,
                              fontColor: AllColor.black,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    ValueListenableBuilder(
                      valueListenable: cubit.referredBy,
                      builder: (context, value, child) {
                        return value.isEmpty
                            ? Container()
                            : value[1]
                                ? const CustomListViewBuilder(
                                    list: [
                                      "https://firebasestorage.googleapis.com/v0/b/bnbhackathon.appspot.com/o/jackie.jpg?alt=media&token=8fe45dfc-6e35-47a1-9bee-c60e4f494e0f",
                                    ],
                                    itemCount: 1,
                                    scrollDirection: Axis.horizontal,
                                  )
                                : const Center(
                                    child: CustomText(
                                      text: "No Referrer",
                                      fontSize: 12,
                                      fontColor: AllColor.black,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  );
                      },
                    ),
                    Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.fromLTRB(9, 0, 0, 0),
                          child: CustomText(
                              text: "Referrals",
                              fontSize: 13,
                              fontColor: AllColor.black,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    const CustomListViewBuilder(
                      list: [
                        "https://firebasestorage.googleapis.com/v0/b/bnbhackathon.appspot.com/o/jackie.jpg?alt=media&token=8fe45dfc-6e35-47a1-9bee-c60e4f494e0f",
                        "https://firebasestorage.googleapis.com/v0/b/bnbhackathon.appspot.com/o/miim.jpg?alt=media&token=0ac0d1a3-a7d2-4c34-84c6-216efd85aee2",
                        "https://firebasestorage.googleapis.com/v0/b/bnbhackathon.appspot.com/o/marvel.jpg?alt=media&token=549b7f2f-ac05-4d81-87dd-3345166dd2e0",
                        "https://firebasestorage.googleapis.com/v0/b/bnbhackathon.appspot.com/o/miim.jpg?alt=media&token=0ac0d1a3-a7d2-4c34-84c6-216efd85aee2"
                      ],
                      itemCount: 4,
                      scrollDirection: Axis.horizontal,
                    ),
                    Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.fromLTRB(9, 0, 0, 0),
                          child: CustomText(
                              text: "Activities",
                              fontSize: 13,
                              fontColor: AllColor.black,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(9, 6, 0, 0),
                          child: Button(
                              text: "See More",
                              color2: AllColor.seeMoreButton,
                              color1: AllColor.seeMoreButton,
                              onPressed: () {},
                              width: width / 4,
                              height: height / 25,
                              textColor: AllColor.black),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 4,
                    )
                  ],
                ))
              ],
            ));
  }
}
