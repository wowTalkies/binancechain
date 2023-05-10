import 'dart:io';

import 'package:bnbapp/screens/badge/cubit/quiz_cubit.dart';
import 'package:bnbapp/screens/badge/cubit/quiz_state.dart';
import 'package:bnbapp/utils/colors.dart';
import 'package:bnbapp/widgets/appbar.dart';
import 'package:bnbapp/widgets/custom_circular_progress_indicator.dart';
import 'package:bnbapp/widgets/text.dart';
import 'package:bnbapp/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'button.dart';

class CreateQuiz extends StatelessWidget {
  final QuizCubit? quizCubit;

  const CreateQuiz({Key? key, this.quizCubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: CustomAppBar(
        appBarHeight: 60,
        icon: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const SizedBox(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.arrow_back_rounded,
                    size: 30, color: AllColor.black),
              ),
            ),
          ),
        ),
        title: 'Create Quiz',
      ),
      body: BlocBuilder<QuizCubit, QuizState>(
        bloc: quizCubit,
        builder: (context, state) => Container(
          color: AllColor.white,
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    InkWell(
                      onTap: () async {
                        debugPrint(
                            'the value notifier is ${quizCubit?.valueNotifier.value.path.toString()}');
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  actions: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Column(
                                          children: [
                                            InkWell(
                                              onTap: () async {
                                                var imagePicker = ImagePicker();
                                                var source = ImageSource.camera;
                                                XFile? image =
                                                    await imagePicker.pickImage(
                                                        source: source,
                                                        imageQuality: 50,
                                                        preferredCameraDevice:
                                                            CameraDevice.front);
                                                quizCubit!.fileImage =
                                                    File(image!.path);
                                                quizCubit?.imagePath =
                                                    image.path.toString();
                                                quizCubit?.valueNotifier.value =
                                                    File(image!.path);
                                                debugPrint(
                                                    'the path is ${quizCubit?.fileImage?.path.toString()}');
                                              },
                                              child: Column(
                                                children: const [
                                                  Icon(
                                                    size: 50,
                                                    Icons.camera,
                                                    color: AllColor.white,
                                                  ),
                                                  CustomText(
                                                    fontSize: 20,
                                                    fontColor: AllColor.white,
                                                    text: "Camera",
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Column(
                                          children: [
                                            InkWell(
                                              onTap: () async {
                                                var imagePicker = ImagePicker();
                                                var source =
                                                    ImageSource.gallery;
                                                XFile? image =
                                                    await imagePicker.pickImage(
                                                        source: source,
                                                        imageQuality: 50,
                                                        preferredCameraDevice:
                                                            CameraDevice.front);
                                                quizCubit?.fileImage = File(
                                                    image!.path.toString());
                                                quizCubit?.imagePath =
                                                    image!.path.toString();
                                                quizCubit?.valueNotifier.value =
                                                    File(
                                                        image!.path.toString());
                                                debugPrint(
                                                    'the path is ${quizCubit?.fileImage?.path.toString()}');
                                              },
                                              child: Column(
                                                children: const [
                                                  Icon(
                                                    size: 50,
                                                    Icons.folder,
                                                    color: AllColor.white,
                                                  ),
                                                  CustomText(
                                                    fontSize: 20,
                                                    fontColor: AllColor.white,
                                                    text: "Gallery",
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                  shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8))),
                                  backgroundColor: Colors.transparent,
                                  iconPadding: const EdgeInsets.only(left: 200),
                                  title: const CustomText(
                                    fontColor: AllColor.white,
                                    text: "Choose",
                                  ),
                                ));
                        /*
                        var imagePicker = ImagePicker();
                        var source = ImageSource.gallery;
                        XFile? image = await imagePicker.pickImage(
                            source: source,
                            imageQuality: 50,
                            preferredCameraDevice: CameraDevice.front);
                        imageFile = File(image!.path);
                        debugPrint('the path is ${imageFile?.path.toString()}');

                         */
                      },
                      child: Container(
                        height: height / 4,
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AllColor.bottomSheet,
                                AllColor.bottomSheet
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            color: AllColor.white),
                        child: Column(
                          children: [
                            SizedBox(
                              height: height / 20,
                            ),
                            ValueListenableBuilder(
                              valueListenable: quizCubit!.valueNotifier,
                              builder: (context, value, child) => Center(
                                child: value!.path.isNotEmpty
                                    ? Center(
                                        child: Image.file(
                                          value,
                                          width: 350.0,
                                          height: 100.0,
                                          fit: BoxFit.fill,
                                        ),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Image.asset(
                                          fit: BoxFit.fill,
                                          "images/quiz_image.png",
                                          width: 50,
                                          height: 50,
                                        ),
                                      ),
                              ),
                            ),
                            SizedBox(
                              height: height / 60,
                            ),
                            ValueListenableBuilder(
                              valueListenable: quizCubit!.valueNotifier,
                              builder: (context, value, child) => Center(
                                  child: value!.path.isEmpty
                                      ? const CustomText(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          text: 'Upload cover image',
                                        )
                                      : Container()),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AllColor.bottomSheet,
                              AllColor.bottomSheet
                            ],
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
                              // height: height,
                              decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25)),
                                  gradient: LinearGradient(
                                    colors: [
                                      AllColor.linear1,
                                      AllColor.linear2
                                    ],
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
                                      controller: quizCubit?.tittle,
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
                                    child: InkWell(
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                    content: SizedBox(
                                                      height: height / 5,
                                                      width: width,
                                                      child: ListView.builder(
                                                        // physics: const NeverScrollableScrollPhysics(),
                                                        shrinkWrap: true,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return ListTile(
                                                            onTap: () {
                                                              quizCubit
                                                                      ?.communityName
                                                                      .value =
                                                                  quizCubit!
                                                                      .descriptionList[
                                                                          index]
                                                                      .toString();
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            title: CustomText(
                                                              fontColor:
                                                                  AllColor
                                                                      .black,
                                                              text: quizCubit!
                                                                  .descriptionList[
                                                                      index]
                                                                  .toString(),
                                                            ),
                                                          );
                                                        },
                                                        itemCount: quizCubit!
                                                            .descriptionList
                                                            .length,
                                                      ),
                                                    ),
                                                    shape: const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    8))),
                                                    backgroundColor:
                                                        Colors.white,
                                                    iconPadding:
                                                        const EdgeInsets.only(
                                                            left: 200),
                                                    title: const CustomText(
                                                      fontColor: AllColor.black,
                                                      text: "Choose community",
                                                    ),
                                                  ));
                                        },
                                        child: ValueListenableBuilder(
                                          valueListenable:
                                              quizCubit!.communityName,
                                          builder: (context, value, child) =>
                                              CustomTextField(
                                            enable: false,
                                            height: height / 20,
                                            controller: quizCubit
                                                ?.textEditingController1,
                                            hintText: value.isEmpty
                                                ? 'Choose community'
                                                : value.toString(),
                                            textFieldColor:
                                                AllColor.bottomSheet,
                                            width: width / 1.2,
                                          ),
                                        )),
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
                                    child: Container(
                                      child: CustomTextField(
                                        enable: true,
                                        height: height / 20,
                                        controller: quizCubit?.description,
                                        hintText: 'Enter description',
                                        textFieldColor: AllColor.bottomSheet,
                                        width: width / 1.2,
                                      ),
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
                                      controller: quizCubit?.question,
                                      hintText: 'Enter your question',
                                      textFieldColor: AllColor.bottomSheet,
                                      width: width / 1.2,
                                    ),
                                  ),
                                  SizedBox(
                                    height: height / 40,
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
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: InkWell(
                                                onTap: () {
                                                  showDialog(
                                                      context: context,
                                                      builder:
                                                          (context) =>
                                                              AlertDialog(
                                                                content:
                                                                    CustomTextField(
                                                                  height:
                                                                      height /
                                                                          20,
                                                                  controller:
                                                                      quizCubit
                                                                          ?.option1,
                                                                  hintText:
                                                                      'Type here',
                                                                  textFieldColor:
                                                                      AllColor
                                                                          .bottomSheet,
                                                                  width: width /
                                                                      1.2,
                                                                ),
                                                                actions: [
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Button(
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.pop(context);
                                                                          },
                                                                          height:
                                                                              30,
                                                                          width:
                                                                              150,
                                                                          text:
                                                                              "Enter",
                                                                          textColor: AllColor
                                                                              .white,
                                                                          color1: AllColor
                                                                              .linear1,
                                                                          color2:
                                                                              AllColor.linear1),
                                                                    ],
                                                                  )
                                                                ],
                                                                shape: const RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(8))),
                                                                backgroundColor:
                                                                    Colors
                                                                        .transparent,
                                                                iconPadding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            200),
                                                                title:
                                                                    const CustomText(
                                                                  fontColor:
                                                                      AllColor
                                                                          .white,
                                                                  text:
                                                                      "Enter option1",
                                                                ),
                                                              ));
                                                  //  showSearch(context: context, delegate: );
                                                },
                                                child: Container(
                                                  height: height / 10,
                                                  width: width / 3,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: AllColor
                                                              .bottomSheet),
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .all(
                                                              Radius.circular(
                                                                  8)),
                                                      gradient:
                                                          const LinearGradient(
                                                        colors: [
                                                          Colors.transparent,
                                                          Colors.transparent,
                                                        ],
                                                        begin:
                                                            Alignment.topCenter,
                                                        end: Alignment
                                                            .bottomCenter,
                                                      ),
                                                      color: AllColor.white),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      const CustomText(
                                                        fontColor:
                                                            AllColor.white,
                                                        text: "Add option1",
                                                      ),
                                                      SizedBox(
                                                        height: height / 60,
                                                      ),
                                                      const Icon(Icons.add,
                                                          color:
                                                              AllColor.white),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: InkWell(
                                                onTap: () {
                                                  showDialog(
                                                      context: context,
                                                      builder:
                                                          (context) =>
                                                              AlertDialog(
                                                                content:
                                                                    CustomTextField(
                                                                  height:
                                                                      height /
                                                                          20,
                                                                  controller:
                                                                      quizCubit
                                                                          ?.option2,
                                                                  hintText:
                                                                      'Type here',
                                                                  textFieldColor:
                                                                      AllColor
                                                                          .bottomSheet,
                                                                  width: width /
                                                                      1.2,
                                                                ),
                                                                actions: [
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Button(
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.pop(context);
                                                                          },
                                                                          height:
                                                                              30,
                                                                          width:
                                                                              150,
                                                                          text:
                                                                              "Enter",
                                                                          textColor: AllColor
                                                                              .white,
                                                                          color1: AllColor
                                                                              .linear1,
                                                                          color2:
                                                                              AllColor.linear1),
                                                                    ],
                                                                  )
                                                                ],
                                                                shape: const RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(8))),
                                                                backgroundColor:
                                                                    Colors
                                                                        .transparent,
                                                                iconPadding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            200),
                                                                title:
                                                                    const CustomText(
                                                                  fontColor:
                                                                      AllColor
                                                                          .white,
                                                                  text:
                                                                      "Enter option2",
                                                                ),
                                                              ));
                                                },
                                                child: Container(
                                                  height: height / 10,
                                                  width: width / 3,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: AllColor
                                                              .bottomSheet),
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .all(
                                                              Radius.circular(
                                                                  8)),
                                                      gradient:
                                                          const LinearGradient(
                                                        colors: [
                                                          Colors.transparent,
                                                          Colors.transparent,
                                                        ],
                                                        begin:
                                                            Alignment.topCenter,
                                                        end: Alignment
                                                            .bottomCenter,
                                                      ),
                                                      color: AllColor.white),
                                                  child: Center(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        const CustomText(
                                                          fontColor:
                                                              AllColor.white,
                                                          text: "Add option2",
                                                        ),
                                                        SizedBox(
                                                          height: height / 60,
                                                        ),
                                                        const Icon(Icons.add,
                                                            color:
                                                                AllColor.white),
                                                      ],
                                                    ),
                                                  ),
                                                ),
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
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: InkWell(
                                                onTap: () {
                                                  showDialog(
                                                      context: context,
                                                      builder:
                                                          (context) =>
                                                              AlertDialog(
                                                                content:
                                                                    CustomTextField(
                                                                  height:
                                                                      height /
                                                                          20,
                                                                  controller:
                                                                      quizCubit
                                                                          ?.option3,
                                                                  hintText:
                                                                      'Type here',
                                                                  textFieldColor:
                                                                      AllColor
                                                                          .bottomSheet,
                                                                  width: width /
                                                                      1.2,
                                                                ),
                                                                actions: [
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Button(
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.pop(context);
                                                                          },
                                                                          height:
                                                                              30,
                                                                          width:
                                                                              150,
                                                                          text:
                                                                              "Enter",
                                                                          textColor: AllColor
                                                                              .white,
                                                                          color1: AllColor
                                                                              .linear1,
                                                                          color2:
                                                                              AllColor.linear1),
                                                                    ],
                                                                  )
                                                                ],
                                                                shape: const RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(8))),
                                                                backgroundColor:
                                                                    Colors
                                                                        .transparent,
                                                                iconPadding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            200),
                                                                title:
                                                                    const CustomText(
                                                                  fontColor:
                                                                      AllColor
                                                                          .white,
                                                                  text:
                                                                      "Enter option3",
                                                                ),
                                                              ));
                                                },
                                                child: Container(
                                                  height: height / 10,
                                                  width: width / 3,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: AllColor
                                                              .bottomSheet),
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .all(
                                                              Radius.circular(
                                                                  8)),
                                                      gradient:
                                                          const LinearGradient(
                                                        colors: [
                                                          Colors.transparent,
                                                          Colors.transparent,
                                                        ],
                                                        begin:
                                                            Alignment.topCenter,
                                                        end: Alignment
                                                            .bottomCenter,
                                                      ),
                                                      color: AllColor.white),
                                                  child: Center(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        const CustomText(
                                                          fontColor:
                                                              AllColor.white,
                                                          text: "Add option3",
                                                        ),
                                                        SizedBox(
                                                          height: height / 60,
                                                        ),
                                                        const Icon(Icons.add,
                                                            color:
                                                                AllColor.white),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: InkWell(
                                                onTap: () {
                                                  showDialog(
                                                      context: context,
                                                      builder:
                                                          (context) =>
                                                              AlertDialog(
                                                                content:
                                                                    CustomTextField(
                                                                  height:
                                                                      height /
                                                                          20,
                                                                  controller:
                                                                      quizCubit
                                                                          ?.option4,
                                                                  hintText:
                                                                      'Type here',
                                                                  textFieldColor:
                                                                      AllColor
                                                                          .bottomSheet,
                                                                  width: width /
                                                                      1.2,
                                                                ),
                                                                actions: [
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Button(
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.pop(context);
                                                                          },
                                                                          height:
                                                                              30,
                                                                          width:
                                                                              150,
                                                                          text:
                                                                              "Enter",
                                                                          textColor: AllColor
                                                                              .white,
                                                                          color1: AllColor
                                                                              .linear1,
                                                                          color2:
                                                                              AllColor.linear1),
                                                                    ],
                                                                  )
                                                                ],
                                                                shape: const RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(8))),
                                                                backgroundColor:
                                                                    Colors
                                                                        .transparent,
                                                                iconPadding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            200),
                                                                title:
                                                                    const CustomText(
                                                                  fontColor:
                                                                      AllColor
                                                                          .white,
                                                                  text:
                                                                      "Enter option4",
                                                                ),
                                                              ));
                                                },
                                                child: Container(
                                                  height: height / 10,
                                                  width: width / 3,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: AllColor
                                                              .bottomSheet),
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .all(
                                                              Radius.circular(
                                                                  8)),
                                                      gradient:
                                                          const LinearGradient(
                                                        colors: [
                                                          Colors.transparent,
                                                          Colors.transparent,
                                                        ],
                                                        begin:
                                                            Alignment.topCenter,
                                                        end: Alignment
                                                            .bottomCenter,
                                                      ),
                                                      color: AllColor.white),
                                                  child: Center(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        const CustomText(
                                                          fontColor:
                                                              AllColor.white,
                                                          text: "Add option4",
                                                        ),
                                                        SizedBox(
                                                          height: height / 60,
                                                        ),
                                                        const Icon(Icons.add,
                                                            color:
                                                                AllColor.white),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
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
                                              text: 'Correct answer',
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8,
                                            right: 15,
                                            top: 8,
                                            bottom: 8),
                                        child: CustomTextField(
                                          height: height / 20,
                                          controller: quizCubit?.answer,
                                          hintText: 'Enter correct answer',
                                          textFieldColor: AllColor.bottomSheet,
                                          width: width / 1.2,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      quizCubit?.state
                                              is QuizCreateRequestedState
                                          ? Column(
                                              children: const [
                                                CustomCircularProgressIndicator()
                                              ],
                                            )
                                          : Button(
                                              color1: AllColor.quizButtonColor,
                                              color2: AllColor.quizButtonColor,
                                              textColor: AllColor.white,
                                              width: width / 1.7,
                                              height: height / 25,
                                              onPressed: () {
                                                quizCubit?.createQuiz();
                                              },
                                              text: "Add question",
                                            ),
                                      const SizedBox(
                                        height: 20,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
