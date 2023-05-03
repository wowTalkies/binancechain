import 'package:bnbapp/widgets/tab_leaderboard_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/leaderboard_cubit.dart';
import 'cubit/leaderboard_state.dart';

class LeaderBoard extends StatelessWidget {
  const LeaderBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LeaderBoardCubit>();
    return Scaffold(
      body: BlocListener(
        bloc: cubit,
        listener: (context, state) {
          if (state is LeaderBoardErrorState) {
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
    final cubit = context.read<LeaderBoardCubit>();
    return BlocBuilder(
      bloc: cubit,
      builder: (context, state) => Column(
        children: [
          Expanded(
              child: ListView(
            children: const [TabLeaderBoardWidget()],
          ))
        ],
      ),
    );
  }
}
