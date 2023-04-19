
import 'package:bnbapp/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final Color? cursorColor;
  final String? hintText;
  final bool? obscure;
  final Color? textFieldColor;
  final double? width;
  final double? height;
  final Widget? prefixWigdget;
  const CustomTextField(
      {Key? key,
      required this.controller,
      this.cursorColor,
      required this.hintText,
      required this.textFieldColor,
      this.prefixWigdget,
      required this.width,this.height,this.obscure})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(8),
          shape: BoxShape.rectangle,
          border: Border.all(color: AllColor.black),
          color: AllColor.white),
      child: SizedBox(
       // height: height,
        width: width,
        child: TextField(
          style: const TextStyle(color: AllColor.black),
          controller: controller,
          cursorColor: cursorColor,
         // keyboardType: TextInputType.visiblePassword,
          obscureText: obscure?? false,
          autofocus: true,
          decoration: InputDecoration(
              fillColor: textFieldColor,
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              hintStyle: const TextStyle(color: AllColor.black,),
             prefixIcon:prefixWigdget ?? const SizedBox(),
            hintText: hintText ,
             ),
        ),
      ),
    );
  }
}
