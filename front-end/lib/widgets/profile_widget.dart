import 'package:bnbapp/auth_cubit/auth_cubit.dart';
import 'package:bnbapp/screens/leaderboard/cubit/leaderboard_cubit.dart';
import 'package:bnbapp/screens/leaderboard/leaderboard.dart';
import 'package:bnbapp/screens/profile/cubit/profile_cubit.dart';
import 'package:bnbapp/screens/profile/cubit/profile_state.dart';
import 'package:bnbapp/screens/profile/profile.dart';
import 'package:bnbapp/screens/tab_community/tab_community.dart';
import 'package:bnbapp/screens/tab_referral/cubit/tab_referral_cubit.dart';
import 'package:bnbapp/screens/tab_referral/tab_referral.dart';
import 'package:bnbapp/utils/colors.dart';
import 'package:bnbapp/widgets/tabs.dart';
import 'package:bnbapp/widgets/text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../screens/tab_community/cubit/tab_community_cubit.dart';

class ProfileWidget extends StatelessWidget {
  final Function()? copyPressed;
  final List<dynamic>? badgeYearList;
  final List<dynamic>? badgeImageList;

  const ProfileWidget(
      {Key? key, this.copyPressed, this.badgeImageList, this.badgeYearList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProfileCubit>();
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) => Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Stack(
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
                        ),
                      ),
                    ),
                    Positioned.fill(
                      bottom: MediaQuery.of(context).size.height / 1.24,
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.rectangle,
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [AllColor.linear1, AllColor.linear2],
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Image.asset(
                              "images/profile__rect_image.png",
                              //  width: 30,
                              height: MediaQuery.of(context).size.height / 6,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned.fill(
                        top: height / 5.8,
                        bottom: height / 1.4,
                        child: DefaultTabController(
                          length: 4,
                          child: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.rectangle,
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [AllColor.linear1, AllColor.linear2],
                              ),
                            ),
                          ),
                        )),
                    Positioned.fill(
                      top: height / 2.9,
                      // bottom: height / 2,
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          shape: BoxShape.rectangle,
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [AllColor.white, AllColor.white],
                          ),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      top: height / 3.95,
                      // bottom: height / height,
                      child: Center(
                        child: Container(
                          color: Colors.transparent,
                          height: height,
                          child: DefaultTabController(
                            length: 4,
                            child: Scaffold(
                              backgroundColor: Colors.transparent,
                              body: TabBarView(
                                children: [
                                  //Referral(),
                                  BlocProvider(
                                    create: (context) {
                                      final AuthCubit authenticationCubit =
                                          BlocProvider.of<AuthCubit>(context);
                                      return ProfileCubit(authenticationCubit)
                                        ..init();
                                    },
                                    child: const Profile(),
                                  ),
                                  BlocProvider(
                                    create: (context) {
                                      final AuthCubit authenticationCubit =
                                          BlocProvider.of<AuthCubit>(context);
                                      return TabCommunityCubit(
                                          authenticationCubit)
                                        ..init();
                                    },
                                    child: const TabCommunityScreen(),
                                  ),
                                  BlocProvider(
                                    create: (context) {
                                      final AuthCubit authenticationCubit =
                                          BlocProvider.of<AuthCubit>(context);
                                      return LeaderBoardCubit(
                                          authenticationCubit)
                                        ..init();
                                    },
                                    child: const LeaderBoard(),
                                  ),
                                  BlocProvider(
                                    create: (context) {
                                      final AuthCubit authenticationCubit =
                                          BlocProvider.of<AuthCubit>(context);
                                      return TabReferralCubit(
                                          authenticationCubit)
                                        ..init();
                                    },
                                    child: const TabReferral(),
                                  ),
                                ],
                              ),
                              appBar: TabBar(
                                labelPadding: const EdgeInsets.all(2),
                                indicatorColor: AllColor.white,
                                tabs: [
                                  Tabs(
                                    text: "My Profile",
                                    color: AllColor.white,
                                    fontSize: 11,
                                    height: height / 22,
                                    width: width / 2,
                                  ),
                                  Tabs(
                                    text: "Communities",
                                    color: AllColor.white,
                                    fontSize: 11,
                                    height: height / 22,
                                    width: width / 2,
                                  ),
                                  Tabs(
                                    text: "Leaderboard",
                                    color: AllColor.white,
                                    fontSize: 11,
                                    height: height / 22,
                                    width: width / 1.2,
                                  ),
                                  Tabs(
                                    text: "Referrals",
                                    color: AllColor.white,
                                    fontSize: 11,
                                    height: height / 22,
                                    width: width / 2,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned.fill(
                        //top: height / 2,
                        bottom: height / 1.4,
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
                    Positioned.fill(
                        left: width / 5,
                        //top: height / 2,
                        bottom: height / 1.6,
                        child: Center(
                          child: CircleAvatar(
                            maxRadius: height / 28,
                            backgroundColor: AllColor.linear1,
                            child: Center(
                              child: Container(
                                width: width / 4,
                                //height: height,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ValueListenableBuilder(
                                      valueListenable: cubit.points,
                                      builder: (context, value, child) =>
                                          value.toString().isEmpty ||
                                                  value.toString() == "0"
                                              ? const CustomText(
                                                  text: "..",
                                                  fontColor: AllColor.white,
                                                )
                                              : CustomText(
                                                  text: value.toString(),
                                                  fontWeight: FontWeight.w700,
                                                  fontColor: AllColor.white,
                                                  fontSize: 14),
                                    ),
                                    const CustomText(
                                        text: "Points",
                                        fontWeight: FontWeight.w400,
                                        fontColor: AllColor.white,
                                        fontSize: 11),
                                  ],
                                ),
                              ),
                            ),

                            // radius: 12,
                          ),
                        )),
                    Positioned.fill(
                        bottom: height / 1.9,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              /*
                              ValueListenableBuilder(
                                valueListenable:
                                    cubit.authCubit.addressNotifier,
                                builder: (context, value, child) => CustomText(
                                    text: value.toString().isNotEmpty
                                        ? "Wallet Address : ${value.toString().replaceRange(6, 36, ".....")}"
                                        : "Wallet Address : Loading...",
                                    fontWeight: FontWeight.w400,
                                    fontColor: AllColor.white,
                                    fontSize: 12),
                              ),

                               */
                              CustomText(
                                  text: cubit.userId.toString().isNotEmpty
                                      ? "Wallet Address : ${cubit.userId.toString().replaceRange(6, 36, ".....")}"
                                      : "Wallet Address : Loading...",
                                  fontWeight: FontWeight.w400,
                                  fontColor: AllColor.white,
                                  fontSize: 12),
                              const SizedBox(
                                width: 5,
                              ),
                              InkWell(
                                onTap: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              "Wallet Address copied to clipboard")));
                                },
                                child: const Padding(
                                  padding: EdgeInsets.only(bottom: 5),
                                  child: Icon(
                                    Icons.copy_sharp,
                                    size: 20,
                                    color: AllColor.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                        )),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
