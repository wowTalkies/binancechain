import 'package:bnbapp/screens/community/cubit/cummunity_cubit.dart';
import 'package:bnbapp/screens/community/cubit/cummunity_state.dart';
import 'package:bnbapp/utils/colors.dart';
import 'package:bnbapp/widgets/button.dart';
import 'package:bnbapp/widgets/custom_circular_progress_indicator.dart';
import 'package:bnbapp/widgets/feeds_widget.dart';
import 'package:bnbapp/widgets/gridcard.dart';
import 'package:bnbapp/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Community extends StatelessWidget {
  const Community({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CommunityCubit>();
    return Scaffold(
      body: BlocListener(
        bloc: cubit,
        listener: (context, state) {
          if (state is CommunityNotJointedState ||
              state is CommunityJoinRequestedState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              duration: Duration(seconds: 2),
              action: SnackBarAction(label: 'Hide', onPressed: () {}),
              content: Text(
                'Loading...',
              ),
            ));
            showDialog(
                context: context,
                builder: (context) {
                  return ValueListenableBuilder(
                    valueListenable: cubit.points,
                    builder: (context, value, child) =>
                        int.parse(value.toString()) > 10
                            ? AlertDialog(
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8))),
                                backgroundColor: AllColor.bottomSheet,
                                iconPadding: const EdgeInsets.only(left: 200),
                                title: const CustomText(
                                  fontColor: AllColor.black,
                                  text: "Join the community to see posts",
                                ),
                                content: cubit.state
                                        is CommunityJoinRequestedState
                                    ? const SizedBox(
                                        height: 30,
                                        width: 10,
                                        child: Center(
                                            child:
                                                CustomCircularProgressIndicator()))
                                    : Button(
                                        text: 'Click to join community',
                                        textColor: AllColor.white,
                                        color1: AllColor.linear1,
                                        color2: AllColor.linear2,
                                        height: 40,
                                        onPressed: () async {
                                          Navigator.pop(context);
                                          await cubit.addMembers();
                                        }),
                              )
                            : AlertDialog(
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8))),
                                backgroundColor: AllColor.bottomSheet,
                                iconPadding: const EdgeInsets.only(left: 200),
                                title: Column(
                                  children: const [
                                    CustomText(
                                      fontColor: AllColor.black,
                                      text:
                                          "You don't have enough points to join the community. Please attend quiz or refer your friend to earn points. You need 10 points to join the community.",
                                    ),
                                  ],
                                ),
                              ),
                  );
                });
          }
          if (state is CommunityJointedState) {
            // Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(
                'Opening posts',
              ),
            ));
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Scaffold(
                    body: FeedsWidget(
                        cubit: cubit,
                        communityName: "Jc community",
                        itemCount: 7,
                        imageUrl:
                            "https://firebasestorage.googleapis.com/v0/b/bnbhackathon.appspot.com/o/miim.jpg?alt=media&token=0ac0d1a3-a7d2-4c34-84c6-216efd85aee2"),
                  ),
                ));
          }

          if (state is CommunityPostRequestedState) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(
                'Uploading',
              ),
            ));
          }
          if (state is CommunityPostRequestedState) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              duration: Duration(seconds: 10),
              content: Text(
                'Uploading',
              ),
            ));
          }
          if (state is CommunityPostedState) {
            // Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(
                'Uploaded',
              ),
            ));
          }
          if (state is CommunityErrorState) {
            if (!state.error.contains('404')) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                  state.error,
                ),
                // duration: const Duration(seconds: 2),
              ));
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
    final cubit = context.read<CommunityCubit>();
    return BlocBuilder<CommunityCubit, CommunityState>(
      bloc: cubit,
      builder: (context, state) => cubit.state is CommunityLoadingState
          ? const Center(child: CustomCircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                    child: ListView(
                  children: [
                    GridCard(
                      cubit: cubit,
                      itemCount: cubit.imageUrl.length,
                      communityNameList: cubit.lists,
                      descriptionList: cubit.descriptionList,
                      imageUrl: cubit.imageUrl,
                      totalMembers: cubit.totalMembers,
                    )
                  ],
                ))
              ],
            ),
    );
    ;
  }
}
