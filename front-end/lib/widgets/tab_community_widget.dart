import 'package:bnbapp/screens/tab_community/cubit/tab_community_cubit.dart';
import 'package:bnbapp/utils/colors.dart';
import 'package:bnbapp/widgets/text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class TabCommunityWidget extends StatelessWidget {
  final List<String>? imageUrl;
  final List<String>? textList;
  final String? text;
  final Color? fontColor;
  final double? fontSize;
  final int? itemCount;
  final TabCommunityCubit? cubit;
  final FontWeight? fontWeight;

  const TabCommunityWidget(
      {Key? key,
      this.imageUrl,
      this.fontColor,
      this.textList,
      this.text,
      this.fontWeight,
      this.fontSize,
      this.itemCount,
      this.cubit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return GridView.builder(
      itemCount: itemCount,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 20,
          crossAxisCount: 1,
          childAspectRatio: MediaQuery.of(context).size.height /
              (MediaQuery.of(context).size.height * 0.3)),
      itemBuilder: (context, index) => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.fromLTRB(height / 45, 0, 0, 0),
              child: Container(
                width: MediaQuery.of(context).size.width / 1.15,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  shape: BoxShape.rectangle,
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [AllColor.linear1, AllColor.linear2],
                  ),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: MediaQuery.of(context).size.height / 15,
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
                              imageUrl: imageUrl?[index] ?? ''),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 15,
                    ),
                    Center(
                      child: CustomText(
                        text: textList![index] ?? '',
                        fontColor: fontColor,
                        fontSize: fontSize,
                        fontWeight: fontWeight,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
