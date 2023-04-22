import 'package:bnbapp/utils/colors.dart';
import 'package:bnbapp/widgets/page.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _LayOut(),
    );
    // final cubit = context.read<ProfileCubit>();
    /*
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

     */
  }
}

class _LayOut extends StatelessWidget {
  const _LayOut({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: const [
              CustomPage(
                text: "it's no Fun without\nFriends",
                fontSize: 25,
                fontWeight: FontWeight.w700,
                color: AllColor.white,
                color2: AllColor.white,
                fontSize2: 16,
                fontWeight2: FontWeight.w400,
                text2: "Bring your friend and earn points",
                text3: "Unlock exciting\nfeatures & top\nthe Leaderboard!",
                points1: "0",
                points2: "points",
                points3: "Collected",
                color4: AllColor.black,
                referral1: "Invite your friends",
                referral2: "Get points on successful Signup",
                referral3: "Multilevel referral",
                referral4: "Unlock experiences with points",
                fontSize3: 14,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
