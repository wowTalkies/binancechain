import 'package:bnbapp/utils/colors.dart';
import 'package:bnbapp/widgets/appbar.dart';
import 'package:bnbapp/widgets/text.dart';
import 'package:bnbapp/widgets/textfield.dart';
import 'package:flutter/material.dart';

class CreateQuiz extends StatelessWidget {
  const CreateQuiz({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: CreateQuizLayOut());
  }
}

class CreateQuizLayOut extends StatelessWidget {
  const CreateQuizLayOut({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    TextEditingController textEditingController0 = TextEditingController();
    TextEditingController textEditingController1 = TextEditingController();
    TextEditingController textEditingController2 = TextEditingController();
    TextEditingController textEditingController3 = TextEditingController();
    TextEditingController textEditingController4 = TextEditingController();
    TextEditingController textEditingController5 = TextEditingController();
    TextEditingController textEditingController6 = TextEditingController();
    TextEditingController textEditingController7 = TextEditingController();

    return Container(
      color: AllColor.white,
      child: Column(
        children: [
          CustomAppBar(
            icon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(Icons.arrow_back_rounded,
                    size: 30, color: AllColor.black),
              ),
            ),
            title: 'Create Quiz',
          ),
          Expanded(
            child: ListView(
              children: [
                Container(
                  height: height / 4,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AllColor.bottomSheet, AllColor.bottomSheet],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      color: AllColor.white),
                  child: Column(
                    children: [
                      SizedBox(
                        height: height / 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          fit: BoxFit.fill,
                          "images/quiz_image.png",
                          width: 40,
                          height: 40,
                        ),
                      ),
                      SizedBox(
                        height: height / 20,
                      ),
                      const CustomText(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        text: 'Upload cover image',
                      )
                    ],
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AllColor.bottomSheet, AllColor.bottomSheet],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      color: AllColor.white),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: width / .9,
                          height: height,
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25)),
                              gradient: LinearGradient(
                                colors: [AllColor.linear1, AllColor.linear2],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                              color: AllColor.white),
                          child: Column(
                            children: [
                              SizedBox(
                                height: height / 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 20,
                                  right: 15,
                                  top: 8,
                                ),
                                child: Row(
                                  children: const [
                                    CustomText(
                                      fontColor: AllColor.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      text: 'Tittle',
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8, right: 15, top: 8, bottom: 8),
                                child: CustomTextField(
                                  height: height / 20,
                                  controller: textEditingController0,
                                  hintText: 'Enter quiz tittle',
                                  textFieldColor: AllColor.bottomSheet,
                                  width: width / 1.2,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 20,
                                  right: 15,
                                  top: 8,
                                ),
                                child: Row(
                                  children: const [
                                    CustomText(
                                      fontColor: AllColor.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      text: 'Quiz community',
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8, right: 15, top: 8, bottom: 8),
                                child: CustomTextField(
                                  height: height / 20,
                                  controller: textEditingController0,
                                  hintText: 'Choose community',
                                  textFieldColor: AllColor.bottomSheet,
                                  width: width / 1.2,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 20,
                                  right: 15,
                                  top: 8,
                                ),
                                child: Row(
                                  children: const [
                                    CustomText(
                                      fontColor: AllColor.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      text: 'Description',
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8, right: 15, top: 8, bottom: 8),
                                child: CustomTextField(
                                  height: height / 20,
                                  controller: textEditingController0,
                                  hintText: 'Enter description',
                                  textFieldColor: AllColor.bottomSheet,
                                  width: width / 1.2,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 20,
                                  right: 15,
                                  top: 8,
                                ),
                                child: Row(
                                  children: const [
                                    CustomText(
                                      fontColor: AllColor.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      text: 'Enter question',
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8, right: 15, top: 8, bottom: 8),
                                child: CustomTextField(
                                  height: height / 20,
                                  controller: textEditingController0,
                                  hintText: 'Enter your question',
                                  textFieldColor: AllColor.bottomSheet,
                                  width: width / 1.2,
                                ),
                              ),
                              SizedBox(
                                height: height / 15,
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: height / 10,
                                            width: width / 3,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color:
                                                        AllColor.bottomSheet),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(8)),
                                                gradient: const LinearGradient(
                                                  colors: [
                                                    Colors.transparent,
                                                    Colors.transparent,
                                                  ],
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                ),
                                                color: AllColor.white),
                                            child: const Icon(Icons.add,
                                                color: AllColor.white),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: height / 10,
                                            width: width / 3,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color:
                                                        AllColor.bottomSheet),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(8)),
                                                gradient: const LinearGradient(
                                                  colors: [
                                                    Colors.transparent,
                                                    Colors.transparent,
                                                  ],
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                ),
                                                color: AllColor.white),
                                            child: const Icon(Icons.add,
                                                color: AllColor.white),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: height / 10,
                                            width: width / 3,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color:
                                                        AllColor.bottomSheet),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(8)),
                                                gradient: const LinearGradient(
                                                  colors: [
                                                    Colors.transparent,
                                                    Colors.transparent,
                                                  ],
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                ),
                                                color: AllColor.white),
                                            child: const Icon(Icons.add,
                                                color: AllColor.white),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: height / 10,
                                            width: width / 3,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color:
                                                        AllColor.bottomSheet),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(8)),
                                                gradient: const LinearGradient(
                                                  colors: [
                                                    Colors.transparent,
                                                    Colors.transparent,
                                                  ],
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                ),
                                                color: AllColor.white),
                                            child: const Icon(Icons.add,
                                                color: AllColor.white),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
