import 'package:bnbapp/screens/badge/cubit/discovery_cubit.dart';
import 'package:bnbapp/widgets/appbar.dart';
import 'package:bnbapp/widgets/gridcard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/discovery_state.dart';

class Discover extends StatelessWidget {
  const Discover({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DiscoverCubit>();
    return Scaffold(
      body: BlocListener(
        bloc: cubit,
        listener: (context, state) {
          if (state is DiscoverErrorState) {
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
    final cubit = context.read<DiscoverCubit>();
    return BlocBuilder(
      bloc: cubit,
      builder: (context, state) => Column(
        children: [
          Expanded(
              child: ListView(
            children: [
              const CustomAppBar(title: "Discover Quizzes"),
              GridCard(
                imageUrl: cubit.list,
                itemCount: cubit.list.length,
              )
            ],
          ))
        ],
      ),
    );
  }
}
