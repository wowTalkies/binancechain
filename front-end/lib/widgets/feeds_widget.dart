import 'dart:io';

import 'package:bnbapp/screens/community/cubit/cummunity_cubit.dart';
import 'package:bnbapp/screens/community/cubit/cummunity_state.dart';
import 'package:bnbapp/utils/colors.dart';
import 'package:bnbapp/widgets/custom_circular_progress_indicator.dart';
import 'package:bnbapp/widgets/text.dart';
import 'package:bnbapp/widgets/textfield.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class FeedsWidget extends StatelessWidget {
  final int? itemCount;
  final String? imageUrl;
  final String? communityName;
  final Map<String, List<dynamic>>? feeds;
  final CommunityCubit? cubit;

  const FeedsWidget(
      {Key? key,
      this.itemCount,
      this.imageUrl,
      this.communityName,
      this.feeds,
      this.cubit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return BlocBuilder<CommunityCubit, CommunityState>(
      bloc: cubit,
      builder: (context, state) => WillPopScope(
        onWillPop: () async {
          var count = 0;
          if (cubit?.state is CommunityPostedState) {
            Navigator.popUntil(context, (route) {
              return count++ == 3;
            });
          } else {
            Navigator.pop(context);
          }
          return true;
        },
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            elevation: 15,
            backgroundColor: AllColor.linear1,
            onPressed: () {
              showBottomSheet(
                context: context,
                builder: (context) => Container(
                  height: height / 1.6,
                  width: width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AllColor.black),
                    gradient: const LinearGradient(
                      colors: [AllColor.bottomSheet, AllColor.bottomSheet],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    color: AllColor.white,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ValueListenableBuilder(
                          valueListenable: cubit!.postImageFile,
                          builder: (context, value, child) => value.path
                                  .toString()
                                  .isNotEmpty
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.file(
                                        File(value.path.toString()),
                                        width: 350.0,
                                        // height: 4,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                )
                              : Container(),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: height / 40, left: 15, right: 15),
                          child: Center(
                            child: Container(
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                color: AllColor.white,
                              ),
                              width: width,
                              height: height / 7,
                              child: CustomTextField(
                                prefixWigdget: const Icon(
                                  Icons.abc_outlined,
                                  size: 30,
                                  color: AllColor.blue,
                                ),
                                cursorColor: AllColor.blue,
                                // height: height,
                                controller: cubit?.postMesage,
                                hintText: 'Enter here',
                                textFieldColor: AllColor.bottomSheet,
                                // width: width
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
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
                                      var fileImage = File(image!.path);
                                      var imagePath = image.path.toString();
                                      cubit?.postImageFile.value =
                                          File(image!.path.toString());

                                      /*
                                    quizCubit?.valueNotifier.value =
                                        File(image!.path);

                                    */
                                      debugPrint(
                                          'the path is ${fileImage?.path.toString()}');
                                    },
                                    child: Column(
                                      children: const [
                                        Icon(
                                          size: 50,
                                          Icons.camera,
                                          color: AllColor.black,
                                        ),
                                        CustomText(
                                          fontSize: 20,
                                          fontColor: AllColor.black,
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
                                      var source = ImageSource.gallery;
                                      XFile? image =
                                          await imagePicker.pickImage(
                                              source: source,
                                              imageQuality: 50,
                                              preferredCameraDevice:
                                                  CameraDevice.front);
                                      var fileImage =
                                          File(image!.path.toString());
                                      var imagePath = image!.path.toString();
                                      cubit?.postImageFile.value =
                                          File(image!.path.toString());
                                      /*
                                      quizCubit?.valueNotifier.value =
                                          File(
                                              image!.path.toString());

                                      */
                                      debugPrint(
                                          'the path is ${fileImage?.path.toString()}');
                                    },
                                    child: Column(
                                      children: const [
                                        Icon(
                                          size: 50,
                                          Icons.folder,
                                          color: AllColor.black,
                                        ),
                                        CustomText(
                                          fontSize: 20,
                                          fontColor: AllColor.black,
                                          text: "Gallery",
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            cubit?.state is CommunityPostRequestedState
                                ? Column(
                                    children: const [
                                      CustomCircularProgressIndicator()
                                    ],
                                  )
                                : InkWell(
                                    onTap: () async {
                                      await cubit!.createPost();
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Icon(Icons.send_sharp,
                                          size: 50, color: AllColor.linear2),
                                    ),
                                  ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
            child: const Icon(
              Icons.edit,
              size: 30,
            ),
          ),
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AllColor.linear1, AllColor.linear2],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              color: AllColor.white,
            ),
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              radius: MediaQuery.of(context).size.height / 25,
                              // width: MediaQuery.of(context).size.width / 0.9,
                              child: ClipOval(
                                // borderRadius: BorderRadius.circular(8.0),
                                child: CachedNetworkImage(
                                    height:
                                        MediaQuery.of(context).size.height / 7,
                                    fit: BoxFit.fill,
                                    placeholder: (context, url) =>
                                        const SizedBox(
                                          child: Center(
                                            child: CircularProgressIndicator(
                                              color: AllColor.white,
                                            ),
                                          ),
                                        ),
                                    imageUrl: imageUrl.toString() ?? ''),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: CustomText(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              text: cubit?.communityNameForPost.toString(),
                              fontColor: AllColor.white,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 40,
                        color: AllColor.linear1,
                        child: Row(
                          children: const [
                            Center(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: CustomText(
                                  fontColor: AllColor.white,
                                  fontSize: 16,
                                  text: "All Posts",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      cubit!.userNameFirstLetter!.value.isEmpty
                          ? Container()
                          : SizedBox(
                              //  height: height,
                              width: width,
                              child: ValueListenableBuilder(
                                valueListenable: cubit!.userNameFirstLetter!,
                                builder: (context, value, child) =>
                                    value.isEmpty
                                        ? Container()
                                        : ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount: value.length,
                                            itemBuilder: (context, index) =>
                                                Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8,
                                                  right: 8,
                                                  bottom: 15,
                                                  top: 15),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  gradient:
                                                      const LinearGradient(
                                                    colors: [
                                                      AllColor.white,
                                                      AllColor.white
                                                    ],
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                  ),
                                                  color: AllColor.white,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 15,
                                                                  top: 10),
                                                          child: CircleAvatar(
                                                            backgroundColor:
                                                                AllColor
                                                                    .linear2,
                                                            radius: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height /
                                                                30,
                                                            // width: MediaQuery.of(context).size.width / 0.9,
                                                            child: ClipOval(
                                                              // borderRadius: BorderRadius.circular(8.0),
                                                              child:
                                                                  ValueListenableBuilder(
                                                                valueListenable:
                                                                    cubit!
                                                                        .userNameFirstLetter!,
                                                                builder: (context,
                                                                        value,
                                                                        child) =>
                                                                    value.isEmpty
                                                                        ? const CustomText(
                                                                            text:
                                                                                "",
                                                                          )
                                                                        : CustomText(
                                                                            fontSize:
                                                                                20,
                                                                            fontWeight:
                                                                                FontWeight.w400,
                                                                            text:
                                                                                value.reversed.toList()[index].toString().substring(0, 1).toUpperCase() ?? "",
                                                                            fontColor:
                                                                                AllColor.white,
                                                                          ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            ValueListenableBuilder(
                                                              valueListenable:
                                                                  cubit!
                                                                      .userNameFirstLetter!,
                                                              builder: (context,
                                                                      value,
                                                                      child) =>
                                                                  value.isEmpty
                                                                      ? Container()
                                                                      : Padding(
                                                                          padding: const EdgeInsets.only(
                                                                              left: 3,
                                                                              bottom: 2,
                                                                              top: 15),
                                                                          child:
                                                                              CustomText(
                                                                            fontSize:
                                                                                16,
                                                                            fontWeight:
                                                                                FontWeight.w400,
                                                                            text:
                                                                                value.reversed.toList()[index].toString() ?? "...",
                                                                            fontColor:
                                                                                AllColor.black,
                                                                          ),
                                                                        ),
                                                            ),
                                                            ValueListenableBuilder(
                                                              valueListenable:
                                                                  cubit!.feeds,
                                                              builder: (context,
                                                                      value,
                                                                      child) =>
                                                                  value.isEmpty
                                                                      ? Container()
                                                                      : Padding(
                                                                          padding: const EdgeInsets.only(
                                                                              left: 5,
                                                                              bottom: 2),
                                                                          child:
                                                                              CustomText(
                                                                            fontSize:
                                                                                11,
                                                                            fontWeight:
                                                                                FontWeight.w400,
                                                                            text: value[cubit!.communityNameForPost.toString()]?.reversed.toList()![index][2].toString().replaceRange(
                                                                                4,
                                                                                39,
                                                                                "..."),
                                                                            fontColor:
                                                                                AllColor.black,
                                                                          ),
                                                                        ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        ValueListenableBuilder(
                                                          valueListenable:
                                                              cubit!.feeds,
                                                          builder: (context,
                                                                  value,
                                                                  child) =>
                                                              value.isEmpty
                                                                  ? Container()
                                                                  : Center(
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsets.only(
                                                                            left:
                                                                                0,
                                                                            bottom:
                                                                                15),
                                                                        child:
                                                                            CustomText(
                                                                          text: value[cubit!.communityNameForPost.toString()]
                                                                              ?.reversed
                                                                              .toList()![index][0]
                                                                              .toString(),
                                                                        ),
                                                                      ),
                                                                    ),
                                                        ),
                                                        ValueListenableBuilder(
                                                          valueListenable:
                                                              cubit!.feeds,
                                                          builder: (context,
                                                                  value,
                                                                  child) =>
                                                              value.isEmpty
                                                                  ? Container()
                                                                  : Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          bottom:
                                                                              15),
                                                                      child:
                                                                          Container(
                                                                        decoration:
                                                                            const BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.all(Radius.circular(8)),
                                                                          color:
                                                                              AllColor.white,
                                                                        ),
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              ClipRRect(
                                                                            borderRadius:
                                                                                BorderRadius.circular(8),
                                                                            child: CachedNetworkImage(
                                                                                height: MediaQuery.of(context).size.height / 4,
                                                                                fit: BoxFit.fill,
                                                                                placeholder: (context, url) => const SizedBox(
                                                                                      child: Center(
                                                                                        child: CircularProgressIndicator(
                                                                                          color: AllColor.white,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                imageUrl: value[cubit!.communityNameForPost.toString()]?.reversed.toList()![index][1].toString() ?? ''),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                              )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
