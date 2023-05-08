import 'package:bnbapp/screens/community/cubit/cummunity_cubit.dart';
import 'package:bnbapp/screens/community/cubit/cummunity_state.dart';
import 'package:bnbapp/widgets/gridcard.dart';
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
          if (state is CommunityErrorState) {
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
    final cubit = context.read<CommunityCubit>();
    return BlocBuilder(
      bloc: cubit,
      builder: (context, state) => Column(
        children: [
          Expanded(
              child: ListView(
            children: [
              GridCard(
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
