import 'package:bnbapp/auth_cubit/auth_cubit.dart';
import 'package:bnbapp/screens/profile/cubit/profile_cubit.dart';
import 'package:bnbapp/screens/tab/cubit/tab_cubit.dart';
import 'package:bnbapp/utils/colors.dart';
import 'package:bnbapp/widgets/discovery_tab.dart';
import 'package:bnbapp/widgets/profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomTabBar extends StatefulWidget {
  final Color? activeColor;
  final Color? inActiveColor;

  const CustomTabBar(
      {super.key, this.activeColor, this.inActiveColor, this.cubit});

  final TabScreenCubit? cubit;

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  @override
  Widget build(BuildContext context) {
    context.select((TabScreenCubit cubit) => widget.cubit?.tabIndex);
    return Scaffold(
      body: TabBarContainer(cubit: widget.cubit),
      bottomNavigationBar: Container(
        height: MediaQuery.of(context).size.height / 11,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AllColor.linear1, AllColor.linear2],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            color: AllColor.white),
        child: BottomNavigationBar(
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w900),
          unselectedItemColor: widget.inActiveColor,
          backgroundColor: Colors.transparent,
          items: <BottomNavigationBarItem>[
            /*
            BottomNavigationBarItem(
              icon: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Icon(
                    Icons.group,
                    size: 25,
                    color: widget.activeColor,
                  )),
              activeIcon: const Padding(
                  padding: EdgeInsets.all(3.0),
                  child: Icon(
                    Icons.group,
                    size: 35,
                    color: AllColor.black,
                  )),
              label: 'Community',
            ),

             */
            BottomNavigationBarItem(
              icon: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Image.asset(
                      fit: BoxFit.fill,
                      height: MediaQuery.of(context).size.height / 29,
                      "images/discover.png")),
              activeIcon: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Image.asset(
                      fit: BoxFit.fill,
                      height: MediaQuery.of(context).size.height / 25,
                      "images/discover_filled.png")),
              label: 'Discover',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Image.asset(
                      fit: BoxFit.fill,
                      height: MediaQuery.of(context).size.height / 29,
                      "images/person.png")),
              activeIcon: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Image.asset(
                      fit: BoxFit.fill,
                      height: MediaQuery.of(context).size.height / 25,
                      "images/person_filled.png")),
              label: 'Profile',
            ),
          ],
          currentIndex: widget.cubit!.tabIndex,
          selectedItemColor: widget.inActiveColor,
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

  const TabBarContainer({Key? key, this.cubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.select((TabScreenCubit cubits) => cubit?.tabIndex);
    switch (cubit?.tabIndex) {
      /*
      case 0:
        return const Community();

       */
      case 0:
        return const DiscoverTab();
      case 1:
        return BlocProvider(
          create: (context) {
            final AuthCubit authenticationCubit =
                BlocProvider.of<AuthCubit>(context);
            return ProfileCubit(authenticationCubit)..init();
          },
          child: const ProfileWidget(),
        );
      default:
        return Container();
    }
  }
}
