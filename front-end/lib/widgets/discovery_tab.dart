import 'package:bnbapp/auth_cubit/auth_cubit.dart';
import 'package:bnbapp/screens/badge/cubit/quiz_cubit.dart';
import 'package:bnbapp/screens/badge/quiz.dart';
import 'package:bnbapp/screens/community/community_screen.dart';
import 'package:bnbapp/screens/community/cubit/cummunity_cubit.dart';
import 'package:bnbapp/utils/colors.dart';
import 'package:bnbapp/widgets/appbar.dart';
import 'package:bnbapp/widgets/tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DiscoverTab extends StatelessWidget {
  const DiscoverTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SizedBox(
      child: Column(
        children: [
          const CustomAppBar(
            title: "Discover",
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: Container(
              color: AllColor.bottomSheet,
              child: DefaultTabController(
                  length: 2,
                  child: Scaffold(
                    appBar: TabBar(
                        indicatorColor: AllColor.white,
                        labelPadding:
                            const EdgeInsets.only(right: 10, left: 10),
                        tabs: [
                          Tabs(
                            linear: AllColor.linear1,
                            text: "Community",
                            color: AllColor.white,
                            fontSize: 16,
                            height: height / 22,
                            width: width / 2,
                          ),
                          Tabs(
                            linear: AllColor.linear1,
                            text: "Quiz",
                            color: AllColor.white,
                            fontSize: 16,
                            height: height / 22,
                            width: width / 2,
                          ),
                        ]),
                    body: TabBarView(children: [
                      BlocProvider(
                        create: (context) {
                          final AuthCubit authenticationCubit =
                              BlocProvider.of<AuthCubit>(context);
                          return CommunityCubit(authenticationCubit)..init();
                        },
                        child: const Community(),
                      ),
                      BlocProvider(
                        create: (context) {
                          final AuthCubit authenticationCubit =
                              BlocProvider.of<AuthCubit>(context);
                          return QuizCubit(authenticationCubit)..init();
                        },
                        child: const Quiz(),
                      ),
                    ]),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
