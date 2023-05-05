import 'package:bnbapp/utils/colors.dart';
import 'package:bnbapp/widgets/custom_circular_progress_indicator.dart';
import 'package:bnbapp/widgets/tab_community_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/tab_community_cubit.dart';
import 'cubit/tab_community_state.dart';

class TabCommunityScreen extends StatelessWidget {
  const TabCommunityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TabCommunityCubit>();
    return Scaffold(
      body: BlocListener(
        bloc: cubit,
        listener: (context, state) {
          if (state is TabCommunityErrorState) {
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
    final height = MediaQuery.of(context).size.height;
    final cubit = context.read<TabCommunityCubit>();
    return BlocBuilder<TabCommunityCubit, TabCommunityState>(
      bloc: cubit,
      builder: (context, state) => Column(
        children: [
          Expanded(
              child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.only(top: height / 50),
                child: cubit?.state is! TabCommunityLoadedState
                    ? Column(
                        children: const [
                          CustomCircularProgressIndicator(),
                        ],
                      )
                    : TabCommunityWidget(
                        textList: cubit.lists,
                        itemCount: cubit.lists.length,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        fontColor: AllColor.white,
                        imageUrl: cubit.imageUrlList,
                        cubit: cubit),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 4,
              )
            ],
          ))
        ],
      ),
    );
  }
}
