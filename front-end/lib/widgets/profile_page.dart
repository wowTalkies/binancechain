import 'package:bnbapp/utils/colors.dart';
import 'package:bnbapp/widgets/button.dart';
import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height / 5,
          decoration: const BoxDecoration(
            shape: BoxShape.rectangle,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [AllColor.linear1, AllColor.linear2],
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset(
                "images/profile__rect_image.png",
                //  width: 30,
                height: MediaQuery.of(context).size.height / 7,
              ),
            ],
          ),
        ),
        Positioned.fill(
            top: 60,
            child: DefaultTabController(
              length: 4,
              child: TabBar(
                tabs: [
                  Button(
                    text: "profile",
                    onPressed: () {},
                  ),
                  Button(
                    text: "profile",
                    onPressed: () {},
                  ),
                  Button(
                    text: "profile",
                    onPressed: () {},
                  ),
                  Button(
                    text: "profile",
                    onPressed: () {},
                  ),
                ],
              ),
            ))
      ],
    );
  }
}
