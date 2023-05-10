import 'package:bnbapp/screens/community/cubit/cummunity_cubit.dart';
import 'package:bnbapp/screens/community/cubit/cummunity_state.dart';
import 'package:bnbapp/utils/colors.dart';
import 'package:bnbapp/widgets/button.dart';
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
          if (state is CommunityJointedState) {
            const AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              backgroundColor: Colors.transparent,
              iconPadding: EdgeInsets.only(left: 200),
              title: CustomText(
                text: "Already joined",
              ),
            );
          }
          if (state is CommunityNotJointedState) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                backgroundColor: AllColor.bottomSheet,
                iconPadding: const EdgeInsets.only(left: 200),
                title: const CustomText(
                  fontColor: AllColor.black,
                  text: "Join the community to see posts",
                ),
                content: Button(
                    text: 'Click to join community',
                    textColor: AllColor.white,
                    color1: AllColor.linear1,
                    color2: AllColor.linear2,
                    height: 40,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Scaffold(
                              body: FeedsWidget(
                                  communityName: "Jc community",
                                  itemCount: 7,
                                  imageUrl:
                                      "https://firebasestorage.googleapis.com/v0/b/bnbhackathon.appspot.com/o/miim.jpg?alt=media&token=0ac0d1a3-a7d2-4c34-84c6-216efd85aee2"),
                            ),
                          ));
                      //  await cubit.addMembers();
                    }),
              ),
            );
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
    return BlocBuilder(
      bloc: cubit,
      builder: (context, state) => Column(
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
