import 'package:bnbapp/screens/profile/cubit/profile_cubit.dart';
import 'package:bnbapp/screens/profile/cubit/profile_state.dart';
import 'package:bnbapp/utils/colors.dart';
import 'package:bnbapp/widgets/button.dart';
import 'package:bnbapp/widgets/custom_circular_progress_indicator.dart';
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
          if (state is ProfileCopyStateState) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Wallet Address copied to clipboard")));
          }
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
                    child: cubit.state is! ProfileLoadedState
                        ? Column(
                            children: const [
                              Center(child: CustomCircularProgressIndicator())
                            ],
                          )
                        : ListView(
                            children: [
                              const Padding(
                                padding: EdgeInsets.fromLTRB(9, 0, 0, 0),
                                child: CustomText(
                                    text: "Badge",
                                    fontSize: 13,
                                    fontColor: AllColor.black,
                                    fontWeight: FontWeight.w700),
                              ),
                              cubit.badgeYearList.isEmpty
                                  ? const Center(
                                      child: CustomText(
                                        text: "No badges",
                                        fontSize: 11,
                                        fontColor: AllColor.black,
                                      ),
                                    )
                                  : GridView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 4,
                                      ),
                                      itemCount: cubit.badgeYearList.length,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) => Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Tabs(
                                          badgeImageList: cubit
                                              .badgeImageList[index]
                                              .toString(),
                                          badgeYearList: cubit
                                              .badgeYearList[index]
                                              .toString(),
                                          color: AllColor.linear2,
                                          //text: cubit.badgeList[0].toString(),
                                          imageContainerWidth: width / 4.6,
                                          imageContainerHeight: height / 26,
                                          width: width / 2,
                                          height: height / 25,
                                          assetImage: "images/pink.png",
                                        ),
                                      ),
                                    ),
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(9, 0, 0, 0),
                                        child: CustomText(
                                            text: "About",
                                            fontSize: 13,
                                            fontColor: AllColor.black,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 10, bottom: 5),
                                        child: InkWell(
                                          onTap: () {
                                            //cubit.textEditingController.value.text = cubit.about.value.toString(),
                                            showBottomSheet(
                                              context: context,
                                              builder: (context) => Container(
                                                height: height / 1.8,
                                                width: width,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: AllColor.black),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  color: AllColor.bottomSheet,
                                                ),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 5,
                                                                  right: 5,
                                                                  bottom: 3),
                                                          child: InkWell(
                                                            onTap: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: const Icon(
                                                              Icons.close_sharp,
                                                              color: AllColor
                                                                  .linear2,
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    Center(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Container(
                                                          height: height / 5,
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                                color: AllColor
                                                                    .black),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                            color: AllColor
                                                                .bottomSheet,
                                                          ),
                                                          child: CustomTextField(
                                                              height: 4000,
                                                              controller: cubit
                                                                  .textEditingController,
                                                              hintText:
                                                                  "Enter about",
                                                              textFieldColor:
                                                                  AllColor
                                                                      .bottomSheet,
                                                              width:
                                                                  width / 1.2),
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
                                                        await cubit
                                                            .uploadAbout();
                                                        Navigator.pop(context);
                                                      },
                                                    )
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle,
                                              boxShadow: [
                                                BoxShadow(
                                                    blurStyle: BlurStyle.outer,
                                                    blurRadius: 3,
                                                    color: Colors.black,
                                                    spreadRadius: 1)
                                              ],
                                            ),
                                            child: const CircleAvatar(
                                              backgroundColor:
                                                  AllColor.bottomSheet,
                                              radius: 13,
                                              child: Icon(
                                                size: 20, Icons.edit,
                                                color: AllColor.black,
                                                // size: 12,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            9, 0, 0, 0),
                                        child: ValueListenableBuilder(
                                          valueListenable: cubit.about,
                                          builder: (context, value, child) => value
                                                  .isEmpty
                                              ? const SizedBox(
                                                  height: 10,
                                                  width: 10,
                                                  child:
                                                      CustomCircularProgressIndicator())
                                              : CustomText(
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
                              cubit.referredBy.value.toString().isEmpty
                                  ? const Center(
                                      child: CustomText(
                                        text: "No Referrer",
                                        fontSize: 12,
                                        fontColor: AllColor.black,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )
                                  : ValueListenableBuilder(
                                      valueListenable: cubit.referredBy,
                                      builder: (context, value, child) {
                                        return value.isEmpty
                                            ? const Center(
                                                child: CustomText(
                                                  text: "No Referrer",
                                                  fontSize: 12,
                                                  fontColor: AllColor.black,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              )
                                            : value[1] &&
                                                    cubit.state
                                                        is ProfileLoadedState
                                                ? CustomListViewBuilder(
                                                    referrersList: cubit
                                                        .referrerNameAndAddress,
                                                    textList:
                                                        cubit.referrerName,
                                                    itemCount: 1,
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                  )
                                                : const Center(
                                                    child: CustomText(
                                                      text: "No Referrer",
                                                      fontSize: 12,
                                                      fontColor: AllColor.black,
                                                      fontWeight:
                                                          FontWeight.w400,
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
                              (cubit.state is! ProfileLoadedState ||
                                      cubit.referrals.toString().isEmpty ||
                                      cubit.referralNameList == null)
                                  ? const Center(
                                      child: CustomText(
                                        text: "No Referrals",
                                        fontSize: 12,
                                        fontColor: AllColor.black,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )
                                  : CustomListViewBuilder(
                                      referralsNamesList:
                                          cubit.referralFullNameList,
                                      referralsList: cubit.referrals,
                                      textList: cubit.referralNameList,
                                      itemCount: cubit.referralNameList.length,
                                      scrollDirection: Axis.horizontal,
                                    ),
                              /*
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

                     */
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 4,
                              )
                            ],
                          ))
              ],
            ));
  }
}
