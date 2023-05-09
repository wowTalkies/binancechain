import 'package:bnbapp/screens/badge/cubit/quiz_cubit.dart';
import 'package:bnbapp/utils/colors.dart';
import 'package:bnbapp/widgets/taking_quiz._widget.dart';
import 'package:bnbapp/widgets/text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'button.dart';

class TakeQuizWidget extends StatelessWidget {
  final int? itemCount;
  final List<String>? imageUrl;
  final List<String>? quizAnswer;
  final QuizCubit? quizCubit;
  final List<String>? descriptionList;
  final Map<String, List<String>>? maps;
  final List<String>? quizQuestion;
  final List<BigInt>? totalMembers;
  final List<String>? quizNameList;

  const TakeQuizWidget(
      {Key? key,
      this.descriptionList,
      this.totalMembers,
      this.imageUrl,
      this.quizNameList,
      this.itemCount,
      this.quizAnswer,
      this.quizQuestion,
      this.maps,
      this.quizCubit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AllColor.white, AllColor.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            color: AllColor.white),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: itemCount,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: MediaQuery.of(context).size.height /
                  (MediaQuery.of(context).size.height * 0.5)),
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
            child: Container(
              width: MediaQuery.of(context).size.width / 1.1,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AllColor.white, AllColor.white],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  color: AllColor.white),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Container(
                      decoration: const BoxDecoration(
                          color: AllColor.white,
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      height: MediaQuery.of(context).size.height / 4,
                      width: MediaQuery.of(context).size.width / 0.9,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: CachedNetworkImage(
                            fit: BoxFit.fill,
                            placeholder: (context, url) => const SizedBox(
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color: AllColor.white,
                                    ),
                                  ),
                                ),
                            imageUrl: imageUrl![index].toString() ?? ''),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    top: null,
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.1,
                      height: MediaQuery.of(context).size.height / 12,
                      decoration: const BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(8),
                              bottomRight: Radius.circular(8)),
                          gradient: LinearGradient(
                            colors: [AllColor.linear1, AllColor.linear2],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          color: AllColor.white),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 3),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 100,
                                ),
                                SizedBox(
                                  width: 250,
                                  child: CustomText(
                                      text: quizNameList![index].toString(),
                                      fontWeight: FontWeight.w700,
                                      fontColor: AllColor.white,
                                      fontSize: 19),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.height / 4,
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 100,
                                ),
                                SizedBox(
                                  width: 250,
                                  child: CustomText(
                                      text: descriptionList![index].toString(),
                                      fontWeight: FontWeight.w400,
                                      fontColor: AllColor.white,
                                      fontSize: 14),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 0),
                                  child: Button(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                TakingQuizWidget(
                                                    quizCubit: quizCubit,
                                                    maps: maps,
                                                    answerList: maps!.values
                                                        .toList()[index],
                                                    questionList:
                                                        quizQuestion![index]
                                                            .toString(),
                                                    communityName:
                                                        descriptionList![index]
                                                            .toString(),
                                                    quizName:
                                                        quizNameList![index]
                                                            .toString()),
                                          ));
                                    },
                                    text: "Take Quiz",
                                    textSize: 14,
                                    height:
                                        MediaQuery.of(context).size.height / 29,
                                    // width: MediaQuery.of(context).size.width / 3.8,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
