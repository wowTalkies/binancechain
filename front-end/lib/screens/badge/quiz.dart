import 'package:bnbapp/utils/colors.dart';
import 'package:bnbapp/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/quiz_cubit.dart';
import 'cubit/quiz_state.dart';

class Quiz extends StatelessWidget {
  const Quiz({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<QuizCubit>();
    return Scaffold(
      body: BlocListener(
        bloc: cubit,
        listener: (context, state) {
          if (state is QuizErrorState) {
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
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final cubit = context.read<QuizCubit>();
    return BlocBuilder(
      bloc: cubit,
      builder: (context, state) => Column(
        children: [
          Expanded(
              child: ListView(
            children: [
              Container(
                height: height,
                color: AllColor.linear2,
                child: const CustomText(
                  fontSize: 200,
                  fontColor: AllColor.white,
                  text: "hello",
                ),
              )
            ],
          ))
        ],
      ),
    );
  }
}
