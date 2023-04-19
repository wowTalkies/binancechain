import 'package:bnbapp/screens/community/community_screen.dart';
import 'package:bnbapp/screens/discovery/discovery.dart';
import 'package:bnbapp/screens/profile/profile.dart';
import 'package:bnbapp/screens/tab/cubit/tab_cubit.dart';
import 'package:bnbapp/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomTabBar extends StatefulWidget {
  final Color? activeColor;
  final Color? inActiveColor;
  const CustomTabBar({super.key, this.activeColor,this.inActiveColor, this.cubit});
  final TabScreenCubit? cubit;

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body:   TabBarContainer(cubit: widget.cubit),
      bottomNavigationBar: Container(
        decoration:   const BoxDecoration(
            gradient: LinearGradient(
              colors: [AllColor.white,AllColor.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            color: AllColor.white),
        child: BottomNavigationBar(
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w900),
          unselectedItemColor: widget.activeColor,
          backgroundColor: Colors.transparent,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Padding(
                  padding: EdgeInsets.all(3.0),
                  child: Icon(
                    Icons.group,
                    size: 25,
                    color: AllColor.white,
                  )),
              activeIcon: Padding(
                  padding: EdgeInsets.all(3.0),
                  child: Icon(
                    Icons.group,
                    size: 35,
                    color: AllColor.black,
                  )),
              label: 'Community',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                  padding: EdgeInsets.all(3.0),
                  child: Icon(
                    Icons.maps_ugc_outlined,
                    size: 25,
                    color: AllColor.white,
                  )),
              activeIcon: Padding(
                  padding: EdgeInsets.all(3.0),
                  child: Icon(
                    Icons.maps_ugc_outlined,
                    size: 35,
                    color: AllColor.black,
                  )),
              label: 'Discover',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                  padding: EdgeInsets.all(3.0),
                  child: Icon(
                    Icons.person,
                    size: 25,
                    color: AllColor.white,
                  )),
              activeIcon: Padding(
                  padding: EdgeInsets.all(3.0),
                  child: Icon(
                    Icons.person,
                    size: 35,
                    color: AllColor.black,
                  )),
              label: 'Profile',
            ),
          ],
          currentIndex: widget.cubit!.tabIndex,
          selectedItemColor: widget.activeColor,
          iconSize: 20,
          onTap: (int i) {
            widget.cubit!.onTabIndexChanged(i);
          },
        ),
      ),
    );
  }
}

class TabBarContainer extends StatelessWidget {
 final TabScreenCubit? cubit;
  const TabBarContainer({Key? key,this.cubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.select((TabScreenCubit cubit) => cubit.tabIndex);
    switch (cubit?.tabIndex) {
      case 0:
        return const Community();
      case 1:
        return const Discover();
      case 2:
        return const Profile();
      default:
        return Container();
    }
  }
}
