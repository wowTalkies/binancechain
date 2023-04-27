import 'package:bnbapp/utils/colors.dart';
import 'package:bnbapp/widgets/text.dart';
import 'package:flutter/material.dart';

class Tabs extends StatelessWidget {
  final String? text;
  final Color? color;
  final double? fontSize;
  final double? width;
  final double? height;
  final String? assetImage;
  final Color? linear;
  final double? imageWidth;
  final double? imageHeight;
  final double? imageContainerWidth;
  final BoxFit? fit;
  final String? text2;
  final String? faq;
  final double? imageContainerHeight;

  const Tabs({
    Key? key,
    this.color,
    this.text,
    this.fontSize,
    this.height,
    this.width,
    this.linear,
    this.assetImage,
    this.imageHeight,
    this.imageWidth,
    this.fit,
    this.imageContainerWidth,
    this.imageContainerHeight,
    this.faq,
    this.text2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            shape: BoxShape.rectangle,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [linear ?? AllColor.linear1, linear ?? AllColor.linear2],
            ),
          ),
          child: assetImage == null && faq == null
              ? Center(
                  child: CustomText(
                    text: text ?? '',
                    fontSize: fontSize,
                    fontColor: color,
                  ),
                )
              : faq != null && assetImage == null
                  ? Column(
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
                            child: CustomText(
                              text: text ?? '',
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              fontColor: color,
                            ),
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
                            child: CustomText(
                              text: text2 ?? '',
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              fontColor: color,
                            ),
                          ),
                        ),
                      ],
                    )
                  : Center(
                      child: Container(
                        decoration: const BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: AllColor.white,
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        height: imageContainerHeight,
                        width: imageContainerWidth,
                        child: Image.asset(
                          assetImage.toString(),
                          fit: fit,
                          width: imageWidth,
                          height: imageHeight,
                        ),
                      ),
                    )),
    );
  }
}
