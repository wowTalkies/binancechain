
import 'package:bnbapp/utils/colors.dart';
import 'package:bnbapp/widgets/text.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final double? width;
  final double? textSize;
  final String? text;
  final String? image;
final Function()? onPressed;
  const Button({Key? key,this.width,this.text,this.onPressed,this.textSize,this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xffFFFFFF),Color(0xffFFFFFF), ],
          )),
      child: SizedBox(width: width,
        child: ElevatedButton(
            style: const ButtonStyle(shadowColor:MaterialStatePropertyAll(
              Colors.transparent,
            ),
                backgroundColor: MaterialStatePropertyAll(
                  Colors.transparent,
                ),
                foregroundColor: MaterialStatePropertyAll(
                  Colors.transparent,
                )),
            onPressed:onPressed,
            child:   Row(
              children: [
                image != null ?Image.asset(image??'',width: 30,height: 30,):Container(),const SizedBox(width:5),
                CustomText(text: text,fontColor: AllColor.black,fontSize:textSize ,),
              ],
            )),
      ),
    );
  }
}
