import 'dart:io';

import 'package:bnbapp/utils/colors.dart';
import 'package:bnbapp/widgets/text.dart';
import 'package:bnbapp/widgets/textfield.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FeedsWidget extends StatelessWidget {
  final int? itemCount;
  final String? imageUrl;
  final String? communityName;
  final Map<String, List<dynamic>>? feeds;

  const FeedsWidget(
      {Key? key, this.itemCount, this.imageUrl, this.communityName, this.feeds})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        elevation: 15,
        backgroundColor: AllColor.linear1,
        onPressed: () {
          showBottomSheet(
            context: context,
            builder: (context) => Container(
              height: height / 1.6,
              width: width,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [AllColor.linear1, AllColor.linear2],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                color: AllColor.white,
              ),
              child: ListView(
                children: [
                  Visibility(
                    visible: 1 == 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            File(
                                '/data/user/0/com.wowtbnb.web3/cache/scaled_mi-2.jpg'),
                            width: 350.0,
                            // height: 4,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(top: height / 40, left: 15, right: 15),
                    child: Center(
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
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
                          controller: TextEditingController(),
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
                                XFile? image = await imagePicker.pickImage(
                                    source: source,
                                    imageQuality: 50,
                                    preferredCameraDevice: CameraDevice.front);
                                var fileImage = File(image!.path);
                                var imagePath = image.path.toString();
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
                                var source = ImageSource.gallery;
                                XFile? image = await imagePicker.pickImage(
                                    source: source,
                                    imageQuality: 50,
                                    preferredCameraDevice: CameraDevice.front);
                                var fileImage = File(image!.path.toString());
                                var imagePath = image!.path.toString();
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
                    ),
                  )
                ],
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
                                height: MediaQuery.of(context).size.height / 7,
                                fit: BoxFit.fill,
                                placeholder: (context, url) => const SizedBox(
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
                          text: communityName.toString(),
                          fontColor: AllColor.white,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 40,
                    color: AllColor.linear1,
                    child: const Center(
                      child: CustomText(
                        fontColor: AllColor.white,
                        fontSize: 16,
                        text: "All Posts",
                      ),
                    ),
                  ),
                  SizedBox(
                      //  height: height,
                      width: width,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: itemCount,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.only(
                              left: 8, right: 8, bottom: 15, top: 15),
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [AllColor.white, AllColor.white],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                              color: AllColor.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15, top: 10),
                                      child: CircleAvatar(
                                        backgroundColor: AllColor.linear2,
                                        radius:
                                            MediaQuery.of(context).size.height /
                                                30,
                                        // width: MediaQuery.of(context).size.width / 0.9,
                                        child: const ClipOval(
                                          // borderRadius: BorderRadius.circular(8.0),
                                          child: CustomText(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w400,
                                            text: 'S',
                                            fontColor: AllColor.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Column(
                                      children: const [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 15, bottom: 2, top: 15),
                                          child: CustomText(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            text: 'list![index].toString()',
                                            fontColor: AllColor.black,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 15, bottom: 2),
                                          child: CustomText(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            text: 'list![index].toString()',
                                            fontColor: AllColor.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Center(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 15, bottom: 15),
                                        child: CustomText(
                                          text:
                                              "the apple is mine but orange also mine and mango also mine",
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 15),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8)),
                                          color: AllColor.white,
                                        ),
                                        child: Center(
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: CachedNetworkImage(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    4,
                                                fit: BoxFit.fill,
                                                placeholder: (context, url) =>
                                                    const SizedBox(
                                                      child: Center(
                                                        child:
                                                            CircularProgressIndicator(
                                                          color: AllColor.white,
                                                        ),
                                                      ),
                                                    ),
                                                imageUrl:
                                                    imageUrl.toString() ?? ''),
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
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
