import 'package:bnbapp/screens/badge/cubit/quiz_cubit.dart';
import 'package:bnbapp/screens/badge/cubit/quiz_state.dart';
import 'package:bnbapp/utils/colors.dart';
import 'package:bnbapp/widgets/custom_circular_progress_indicator.dart';
import 'package:bnbapp/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TakingQuizWidget extends StatelessWidget {
  final String? quizName;
  final String? communityName;
  final QuizCubit? quizCubit;
  final List<String>? answerList;
  final String? questionList;
  final Map<String, List<String>>? maps;

  const TakingQuizWidget(
      {Key? key,
      this.quizName,
      this.answerList,
      this.questionList,
      this.communityName,
      this.maps,
      this.quizCubit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return BlocBuilder<QuizCubit, QuizState>(
      bloc: quizCubit,
      builder: (context, state) => Scaffold(
        body: Container(
          width: width,
          height: height,
          color: AllColor.bottomSheet,
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
                          child: InkWell(
                            onTap: () {
                              quizCubit?.back();
                              Navigator.pop(context);
                            },
                            child: Icon(
                              size: MediaQuery.of(context).size.height / 29,
                              Icons.close,
                              color: AllColor.black,
                            ),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: CustomText(
                        text: quizName.toString(),
                        fontSize: 20,
                        fontColor: AllColor.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: CustomText(
                        text: communityName.toString(),
                        fontSize: 16,
                        fontColor: AllColor.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      endIndent: 20,
                      indent: 20,
                      thickness: 2,
                      color: AllColor.linear2,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: height / 1.4,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          shape: BoxShape.rectangle,
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [AllColor.linear1, AllColor.linear2],
                          ),
                        ),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: const [
                                Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: CustomText(
                                    text: 'Question',
                                    fontSize: 20,
                                    fontColor: AllColor.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: SizedBox(
                                    width: width / 1.2,
                                    child: CustomText(
                                      text: questionList.toString(),
                                      fontSize: 15,
                                      fontColor: AllColor.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Column(
                              children: [
                                InkWell(
                                  onTap: quizCubit!.trueOrFalse == false
                                      ? null
                                      : () async {
                                          await quizCubit?.answerEvaluate(
                                              answerList![0].toString(),
                                              quizName.toString(),
                                              0);
                                          debugPrint(
                                              'the index is ${quizCubit?.index.toString()}');
                                          // Navigator.pop(context);
                                        },
                                  child: Container(
                                    width: width / 1.2,
                                    height: height / 20,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(8)),
                                      shape: BoxShape.rectangle,
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          quizCubit?.state
                                                      is QuizWrongAnswerState &&
                                                  quizCubit?.index == 0
                                              ? Colors.red
                                              : quizCubit?.state
                                                          is QuizAnsweredState &&
                                                      quizCubit?.index == 0
                                                  ? Colors.green
                                                  : AllColor.bottomSheet,
                                          quizCubit?.state
                                                      is QuizWrongAnswerState &&
                                                  quizCubit?.index == 0
                                              ? Colors.red
                                              : quizCubit?.state
                                                          is QuizAnsweredState &&
                                                      quizCubit?.index == 0
                                                  ? Colors.green
                                                  : AllColor.bottomSheet
                                        ],
                                      ),
                                    ),
                                    child: Center(
                                      child: (quizCubit?.state
                                                  is QuizAnswerClickedState &&
                                              quizCubit?.index == 0)
                                          ? const CustomCircularProgressIndicator()
                                          : CustomText(
                                              text: answerList![0].toString(),
                                              fontSize: 15,
                                              fontColor: AllColor.black,
                                              fontWeight: FontWeight.w700,
                                            ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Column(
                              children: [
                                InkWell(
                                  onTap: quizCubit!.trueOrFalse == false
                                      ? null
                                      : () async {
                                          await quizCubit?.answerEvaluate(
                                              answerList![1].toString(),
                                              quizName.toString(),
                                              1);

                                          //  Navigator.pop(context);
                                        },
                                  child: Container(
                                    width: width / 1.2,
                                    height: height / 20,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(8)),
                                      shape: BoxShape.rectangle,
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          quizCubit?.state
                                                      is QuizWrongAnswerState &&
                                                  quizCubit?.index == 1
                                              ? Colors.red
                                              : quizCubit?.state
                                                          is QuizAnsweredState &&
                                                      quizCubit?.index == 1
                                                  ? Colors.green
                                                  : AllColor.bottomSheet,
                                          quizCubit?.state
                                                      is QuizWrongAnswerState &&
                                                  quizCubit?.index == 1
                                              ? Colors.red
                                              : quizCubit?.state
                                                          is QuizAnsweredState &&
                                                      quizCubit?.index == 1
                                                  ? Colors.green
                                                  : AllColor.bottomSheet
                                        ],
                                      ),
                                    ),
                                    child: Center(
                                      child: (quizCubit?.state
                                                  is QuizAnswerClickedState &&
                                              quizCubit?.index == 1)
                                          ? const CustomCircularProgressIndicator()
                                          : CustomText(
                                              text: answerList![1].toString(),
                                              fontSize: 15,
                                              fontColor: AllColor.black,
                                              fontWeight: FontWeight.w700,
                                            ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Column(
                              children: [
                                InkWell(
                                  onTap: quizCubit!.trueOrFalse == false
                                      ? null
                                      : () async {
                                          await quizCubit?.answerEvaluate(
                                              answerList![2].toString(),
                                              quizName.toString(),
                                              2);
                                        },
                                  child: Container(
                                    width: width / 1.2,
                                    height: height / 20,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(8)),
                                      shape: BoxShape.rectangle,
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          quizCubit?.state
                                                      is QuizWrongAnswerState &&
                                                  quizCubit?.index == 2
                                              ? Colors.red
                                              : quizCubit?.state
                                                          is QuizAnsweredState &&
                                                      quizCubit?.index == 2
                                                  ? Colors.green
                                                  : AllColor.bottomSheet,
                                          quizCubit?.state
                                                      is QuizWrongAnswerState &&
                                                  quizCubit?.index == 2
                                              ? Colors.red
                                              : quizCubit?.state
                                                          is QuizAnsweredState &&
                                                      quizCubit?.index == 2
                                                  ? Colors.green
                                                  : AllColor.bottomSheet
                                        ],
                                      ),
                                    ),
                                    child: Center(
                                      child: (quizCubit?.state
                                                  is QuizAnswerClickedState &&
                                              quizCubit?.index == 2)
                                          ? const CustomCircularProgressIndicator()
                                          : CustomText(
                                              text: answerList![2].toString(),
                                              fontSize: 15,
                                              fontColor: AllColor.black,
                                              fontWeight: FontWeight.w700,
                                            ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Column(
                              children: [
                                InkWell(
                                  onTap: quizCubit!.trueOrFalse == false
                                      ? null
                                      : () async {
                                          debugPrint(
                                              'hello siva ${quizCubit!.trueOrFalse!} ');
                                          await quizCubit?.answerEvaluate(
                                              answerList![3].toString(),
                                              quizName.toString(),
                                              3);
                                        },
                                  child: Container(
                                    width: width / 1.2,
                                    height: height / 20,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(8)),
                                      shape: BoxShape.rectangle,
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          quizCubit?.state
                                                      is QuizWrongAnswerState &&
                                                  quizCubit?.index == 3
                                              ? Colors.red
                                              : quizCubit?.state
                                                          is QuizAnsweredState &&
                                                      quizCubit?.index == 3
                                                  ? Colors.green
                                                  : AllColor.bottomSheet,
                                          quizCubit?.state
                                                      is QuizWrongAnswerState &&
                                                  quizCubit?.index == 3
                                              ? Colors.red
                                              : quizCubit?.state
                                                          is QuizAnsweredState &&
                                                      quizCubit?.index == 3
                                                  ? Colors.green
                                                  : AllColor.bottomSheet
                                        ],
                                      ),
                                    ),
                                    child: Center(
                                      child: (quizCubit?.state
                                                  is QuizAnswerClickedState &&
                                              quizCubit?.index == 3)
                                          ? const CustomCircularProgressIndicator()
                                          : CustomText(
                                              text: answerList![3].toString(),
                                              fontSize: 15,
                                              fontColor: AllColor.black,
                                              fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: height / 7,
                            ),
                            /*
                            Button(
                              color1: AllColor.quizButtonColor,
                              color2: AllColor.quizButtonColor,
                              textColor: AllColor.white,
                              width: width / 1.7,
                              height: height / 25,
                              onPressed: () {},
                              text: "Next",
                            )

                             */
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
