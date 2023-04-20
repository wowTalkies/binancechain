import 'package:bnbapp/utils/colors.dart';
import 'package:bnbapp/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  const CustomAppBar({Key? key, this.title}) : super(key: key);
  @override
  Size get preferredSize => const Size.fromHeight(90.0);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: AllColor.white,
          statusBarBrightness: Brightness.light),
      toolbarHeight: 60,
      backgroundColor: AllColor.white,
      title: Center(
          child: CustomText(
              text: title ?? '',
              fontSize: 24,
              fontColor: AllColor.black,
              fontWeight: FontWeight.w700)),
    );
  }
}
