import 'package:bnbapp/utils/colors.dart';
import 'package:bnbapp/widgets/button.dart';
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
          if (state is QuizAnsweredState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text("")));
          }
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
              Center(
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
                            builder: (context) => CreateQuiz(),
                          ));
                    },
                    color2: AllColor.linear1),
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
