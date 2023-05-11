import 'package:bnbapp/utils/colors.dart';
import 'package:bnbapp/widgets/button.dart';
import 'package:bnbapp/widgets/custom_circular_progress_indicator.dart';
import 'package:bnbapp/widgets/quiz_create.dart';
import 'package:bnbapp/widgets/take_quiz.dart';
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
          if (state is QuizAddedState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text("Quiz added")));
            Navigator.pop(context);
          }
          if (state is QuizNotAddedState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text("Quiz not added")));
            Navigator.pop(context);
          }
          if (state is QuizErrorState) {
            if (!state.error.contains('404')) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.error)));
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
      builder: (context, state) => cubit.state is QuizLoadingState
          ? const Center(child: CustomCircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                    child: ListView(
                  children: [
                    Center(
                      child: ValueListenableBuilder(
                        valueListenable: cubit.points,
                        builder: (context, value, child) => Visibility(
                          visible: int.parse(value.toString()) > 20,
                          child: Button(
                              height: height / 20,
                              width: width / 1.2,
                              text: 'Create quiz',
                              color1: AllColor.linear1,
                              textColor: AllColor.white,
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          CreateQuiz(quizCubit: cubit),
                                    ));
                              },
                              color2: AllColor.linear1),
                        ),
                      ),
                    ),
                    TakeQuizWidget(
                      quizCubit: cubit,
                      maps: cubit.maps,
                      quizAnswer: cubit.answerList,
                      quizQuestion: cubit.questionList,
                      descriptionList: cubit.descriptionList,
                      itemCount: cubit.imageUrlList.length,
                      imageUrl: cubit.imageUrlList,
                      quizNameList: cubit.quizName,
                    )
                  ],
                ))
              ],
            ),
    );
  }
}
