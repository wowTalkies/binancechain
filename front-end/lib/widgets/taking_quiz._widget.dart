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
        body: quizCubit?.state is TakeQuizRequestedState
            ? const Center(
                child: CustomCircularProgressIndicator(),
              )
            : Container(
                width: width,
                height: height,
                color: AllColor.bottomSheet,
                child: ListView.builder(
                  itemCount:
                      quizCubit?.hardMap[communityName.toString()]?.keys.length,
                  itemBuilder: (context, index) => Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: CustomText(
                          text: quizCubit?.quizTittle!.var3[index].toString(),
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
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: CustomText(
                                      text:
                                          'Question ${(index + 1).toString()}',
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
                                        text: quizCubit
                                            ?.hardMap[communityName.toString()]
                                            ?.keys
                                            .toList()[index]
                                            .toString(),
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
                                    onTap: quizCubit!.boolList![index] == true
                                        ? null
                                        : () async {
                                            await quizCubit?.answerEvaluate(
                                                quizCubit
                                                    ?.hardMap[communityName
                                                        .toString()]
                                                    ?.values
                                                    .toList()[index][0]
                                                    .toString(),
                                                quizCubit
                                                    ?.quizTittle!.var3[index]
                                                    .toString(),
                                                0,
                                                index);
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
                                            (quizCubit?.state
                                                        is QuizWrongAnswerState &&
                                                    quizCubit?.index == 0 &&
                                                    quizCubit?.listIndex ==
                                                        index)
                                                ? Colors.red
                                                : (quizCubit?.state
                                                            is QuizAnsweredState &&
                                                        quizCubit?.index == 0 &&
                                                        quizCubit?.listIndex ==
                                                            index)
                                                    ? Colors.green
                                                    : quizCubit!.boolList![
                                                                index] ==
                                                            true
                                                        ? Colors.grey
                                                        : AllColor.bottomSheet,
                                            (quizCubit?.state
                                                        is QuizWrongAnswerState &&
                                                    quizCubit?.index == 0 &&
                                                    quizCubit?.listIndex ==
                                                        index)
                                                ? Colors.red
                                                : (quizCubit?.state
                                                            is QuizAnsweredState &&
                                                        quizCubit?.index == 0 &&
                                                        quizCubit?.listIndex ==
                                                            index)
                                                    ? Colors.green
                                                    : quizCubit!.boolList![
                                                                index] ==
                                                            true
                                                        ? Colors.grey
                                                        : AllColor.bottomSheet
                                          ],
                                        ),
                                      ),
                                      child: Center(
                                        child: (quizCubit?.state
                                                    is QuizAnswerClickedState &&
                                                quizCubit?.index == 0 &&
                                                quizCubit?.listIndex == index)
                                            ? const CustomCircularProgressIndicator()
                                            : CustomText(
                                                text: quizCubit
                                                    ?.hardMap[communityName
                                                        .toString()]
                                                    ?.values
                                                    .toList()[index][0]
                                                    .toString(),
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
                                    onTap: quizCubit!.boolList![index] == true
                                        ? null
                                        : () async {
                                            await quizCubit?.answerEvaluate(
                                                quizCubit
                                                    ?.hardMap[communityName
                                                        .toString()]
                                                    ?.values
                                                    .toList()[index][1]
                                                    .toString(),
                                                quizCubit
                                                    ?.quizTittle!.var3[index]
                                                    .toString(),
                                                1,
                                                index);

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
                                            (quizCubit?.state
                                                        is QuizWrongAnswerState &&
                                                    quizCubit?.index == 1 &&
                                                    quizCubit?.listIndex ==
                                                        index)
                                                ? Colors.red
                                                : (quizCubit?.state
                                                            is QuizAnsweredState &&
                                                        quizCubit?.index == 1 &&
                                                        quizCubit?.listIndex ==
                                                            index)
                                                    ? Colors.green
                                                    : quizCubit!.boolList![
                                                                index] ==
                                                            true
                                                        ? Colors.grey
                                                        : AllColor.bottomSheet,
                                            (quizCubit?.state
                                                        is QuizWrongAnswerState &&
                                                    quizCubit?.index == 1 &&
                                                    quizCubit?.listIndex ==
                                                        index)
                                                ? Colors.red
                                                : (quizCubit?.state
                                                            is QuizAnsweredState &&
                                                        quizCubit?.index == 1 &&
                                                        quizCubit?.listIndex ==
                                                            index)
                                                    ? Colors.green
                                                    : quizCubit!.boolList![
                                                                index] ==
                                                            true
                                                        ? Colors.grey
                                                        : AllColor.bottomSheet
                                          ],
                                        ),
                                      ),
                                      child: Center(
                                        child: (quizCubit?.state
                                                    is QuizAnswerClickedState &&
                                                quizCubit?.index == 1 &&
                                                quizCubit?.listIndex == index)
                                            ? const CustomCircularProgressIndicator()
                                            : CustomText(
                                                text: quizCubit
                                                    ?.hardMap[communityName
                                                        .toString()]
                                                    ?.values
                                                    .toList()[index][1]
                                                    .toString(),
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
                                    onTap: quizCubit!.boolList![index] == true
                                        ? null
                                        : () async {
                                            await quizCubit?.answerEvaluate(
                                                quizCubit
                                                    ?.hardMap[communityName
                                                        .toString()]
                                                    ?.values
                                                    .toList()[index][2]
                                                    .toString(),
                                                quizCubit
                                                    ?.quizTittle!.var3[index]
                                                    .toString(),
                                                2,
                                                index);
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
                                            (quizCubit?.state
                                                        is QuizWrongAnswerState &&
                                                    quizCubit?.index == 2 &&
                                                    quizCubit?.listIndex ==
                                                        index)
                                                ? Colors.red
                                                : (quizCubit?.state
                                                            is QuizAnsweredState &&
                                                        quizCubit?.index == 2 &&
                                                        quizCubit?.listIndex ==
                                                            index)
                                                    ? Colors.green
                                                    : quizCubit!.boolList![
                                                                index] ==
                                                            true
                                                        ? Colors.grey
                                                        : AllColor.bottomSheet,
                                            (quizCubit?.state
                                                        is QuizWrongAnswerState &&
                                                    quizCubit?.index == 2 &&
                                                    quizCubit?.listIndex ==
                                                        index)
                                                ? Colors.red
                                                : (quizCubit?.state
                                                            is QuizAnsweredState &&
                                                        quizCubit?.index == 2 &&
                                                        quizCubit?.listIndex ==
                                                            index)
                                                    ? Colors.green
                                                    : quizCubit!.boolList![
                                                                index] ==
                                                            true
                                                        ? Colors.grey
                                                        : AllColor.bottomSheet
                                          ],
                                        ),
                                      ),
                                      child: Center(
                                        child: (quizCubit?.state
                                                    is QuizAnswerClickedState &&
                                                quizCubit?.index == 2 &&
                                                quizCubit?.listIndex == index)
                                            ? const CustomCircularProgressIndicator()
                                            : CustomText(
                                                text: quizCubit
                                                    ?.hardMap[communityName
                                                        .toString()]
                                                    ?.values
                                                    .toList()[index][2]
                                                    .toString(),
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
                                    onTap: quizCubit!.boolList![index] == true
                                        ? null
                                        : () async {
                                            debugPrint(
                                                'hello siva ${quizCubit!.trueOrFalse!} ');
                                            await quizCubit?.answerEvaluate(
                                                quizCubit
                                                    ?.hardMap[communityName
                                                        .toString()]
                                                    ?.values
                                                    .toList()[index][3]
                                                    .toString(),
                                                quizCubit
                                                    ?.quizTittle!.var3[index]
                                                    .toString(),
                                                3,
                                                index);
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
                                            (quizCubit?.state
                                                        is QuizWrongAnswerState &&
                                                    quizCubit?.index == 3 &&
                                                    quizCubit?.listIndex ==
                                                        index)
                                                ? Colors.red
                                                : (quizCubit?.state
                                                            is QuizAnsweredState &&
                                                        quizCubit?.index == 3 &&
                                                        quizCubit?.listIndex ==
                                                            index)
                                                    ? Colors.green
                                                    : quizCubit!.boolList![
                                                                index] ==
                                                            true
                                                        ? Colors.grey
                                                        : AllColor.bottomSheet,
                                            (quizCubit?.state
                                                        is QuizWrongAnswerState &&
                                                    quizCubit?.index == 3 &&
                                                    quizCubit?.listIndex ==
                                                        index)
                                                ? Colors.red
                                                : (quizCubit?.state
                                                            is QuizAnsweredState &&
                                                        quizCubit?.index == 3 &&
                                                        quizCubit?.listIndex ==
                                                            index)
                                                    ? Colors.green
                                                    : quizCubit!.boolList![
                                                                index] ==
                                                            true
                                                        ? Colors.grey
                                                        : AllColor.bottomSheet
                                          ],
                                        ),
                                      ),
                                      child: Center(
                                        child: (quizCubit?.state
                                                    is QuizAnswerClickedState &&
                                                quizCubit?.index == 3 &&
                                                quizCubit?.listIndex == index)
                                            ? const CustomCircularProgressIndicator()
                                            : CustomText(
                                                text: quizCubit
                                                    ?.hardMap[communityName
                                                        .toString()]
                                                    ?.values
                                                    .toList()[index][3]
                                                    .toString(),
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
                              CustomText(
                                text: quizCubit!.boolList![index] == true
                                    ? 'Already Submitted'
                                    : "",
                                fontColor: AllColor.white,
                              )
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
                      )
                    ],
                  ),
                )

                /*
          Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [

                      ],
                    ),
                  ),
                ],
          ),

          */
                ),
      ),
    );
  }
}
