import 'package:bnbapp/router.dart';
import 'package:bnbapp/widgets/tab_referral_Widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/tab_referral_cubit.dart';
import 'cubit/tab_referral_state.dart';

class TabReferral extends StatelessWidget {
  const TabReferral({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TabReferralCubit>();
    return Scaffold(
      body: BlocListener(
        bloc: cubit,
        listener: (context, state) {
          if (state is TabReferralErrorState) {
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
  }
}

class _LayOut extends StatelessWidget {
  const _LayOut({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TabReferralCubit>();
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return BlocBuilder(
      bloc: cubit,
      builder: (context, state) => Column(
        children: [
          Expanded(
              child: ListView(
            children: [
              TabReferralWidget(
                  referralPoint: cubit.referralPoint,
                  itemCount: 6,
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.referral);
                  },
                  buttonText: "Explore Referrals",
                  list: const [
                    "https://firebasestorage.googleapis.com/v0/b/bnbhackathon.appspot.com/o/jackie.jpg?alt=media&token=8fe45dfc-6e35-47a1-9bee-c60e4f494e0f",
                    "https://firebasestorage.googleapis.com/v0/b/bnbhackathon.appspot.com/o/marvel.jpg?alt=media&token=549b7f2f-ac05-4d81-87dd-3345166dd2e0",
                    "https://firebasestorage.googleapis.com/v0/b/bnbhackathon.appspot.com/o/miim.jpg?alt=media&token=0ac0d1a3-a7d2-4c34-84c6-216efd85aee2",
                    "https://firebasestorage.googleapis.com/v0/b/bnbhackathon.appspot.com/o/jackie.jpg?alt=media&token=8fe45dfc-6e35-47a1-9bee-c60e4f494e0f",
                    "https://firebasestorage.googleapis.com/v0/b/bnbhackathon.appspot.com/o/marvel.jpg?alt=media&token=549b7f2f-ac05-4d81-87dd-3345166dd2e0",
                    "https://firebasestorage.googleapis.com/v0/b/bnbhackathon.appspot.com/o/miim.jpg?alt=media&token=0ac0d1a3-a7d2-4c34-84c6-216efd85aee2"
                  ]),
              SizedBox(
                height: height / 7,
              )
            ],
          ))
        ],
      ),
    );
  }
}
