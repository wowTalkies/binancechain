import 'package:bnbapp/utils/colors.dart';
import 'package:bnbapp/widgets/text.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final double? width;
  final double? textSize;
  final String? text;
  final double? height;
  final double? forTextAlign;
  final Color? color1;
  final Color? color2;
  final Color? textColor;
  final String? image;
  final FontWeight? fontWeight;
  final Function()? onPressed;

  const Button(
      {Key? key,
      this.width,
      this.text,
      this.onPressed,
      this.textSize,
      this.image,
      this.height,
      this.color1,
      this.color2,
      this.textColor,
      this.fontWeight,
      this.forTextAlign})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              color1 ?? const Color(0xffFFFFFF),
              color2 ?? const Color(0xffFFFFFF),
            ],
          )),
      child: SizedBox(
        width: width,
        height: height,
        child: ElevatedButton(
          style: const ButtonStyle(
              shadowColor: MaterialStatePropertyAll(
                Colors.transparent,
              ),
              backgroundColor: MaterialStatePropertyAll(
                Colors.transparent,
              ),
              foregroundColor: MaterialStatePropertyAll(
                Colors.transparent,
              )),
          onPressed: onPressed,
          child: CustomText(
            fontWeight: fontWeight,
            text: text,
            fontColor: textColor ?? AllColor.black,
            fontSize: textSize,
          ),
          /*
            Row(
              children: [
                /*
                image != null
                    ? Image.asset(
                        image ?? '',
                        width: 30,
                        height: 30,
                      )
                    : Container(
                        width: forTextAlign,
                      ),
                const SizedBox(width: 3),

                 */
                CustomText(
                  fontWeight: fontWeight,
                  text: text,
                  fontColor: textColor ?? AllColor.black,
                  fontSize: textSize,
                ),
              ],
            )

             */
        ),
      ),
    );
  }
}
