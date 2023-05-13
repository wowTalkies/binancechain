import 'package:bnbapp/router.dart';
import 'package:bnbapp/widgets/custom_circular_progress_indicator.dart';
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
              cubit.state is! TabReferralLoadedState
                  ? Column(
                      children: const [CustomCircularProgressIndicator()],
                    )
                  : TabReferralWidget(
                      totalPoint: cubit.totalPoint,
                      referralPoint: cubit.referralPoint,
                      itemCount: cubit.referralNameList.length,
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.referral);
                      },
                      buttonText: "Explore Referrals",
                      list: cubit.referralNameList,
                      fullNameList: cubit.referralFullNameList,
                    ),
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
