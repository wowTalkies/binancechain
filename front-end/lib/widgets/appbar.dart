import 'package:bnbapp/utils/colors.dart';
import 'package:bnbapp/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final double? appBarHeight;
  final Widget? icon;

  const CustomAppBar({Key? key, this.title, this.appBarHeight, this.icon})
      : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(90.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 12,
      titleSpacing: 3,
      leading: icon ??
          Container(
            width: 0,
          ),
      systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: AllColor.white,
          statusBarBrightness: Brightness.light),
      toolbarHeight: appBarHeight ?? 60,
      backgroundColor: AllColor.white,
      title: Center(
          child: CustomText(
              text: title ?? '',
              fontSize: 20,
              fontColor: AllColor.black,
              fontWeight: FontWeight.w700)),
    );
  }
}
