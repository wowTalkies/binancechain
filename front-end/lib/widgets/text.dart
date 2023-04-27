import "package:flutter/material.dart";

class CustomText extends StatelessWidget {
  final FontWeight? fontWeight;
  final Color? fontColor;
  final double? fontSize;
  final TextOverflow? overflow;
  final String? text;
  final TextAlign? textAlign;
  final double? height;

  const CustomText(
      {Key? key,
      this.fontWeight,
      this.fontColor,
      this.fontSize,
      this.overflow,
      this.text,
      this.textAlign,
      this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      maxLines: 12,
      text ?? '',
      style: TextStyle(
          height: height,
          fontWeight: fontWeight,
          color: fontColor,
          fontSize: fontSize,
          overflow: overflow),
      textAlign: textAlign,
      overflow: overflow,
    );
  }
}
