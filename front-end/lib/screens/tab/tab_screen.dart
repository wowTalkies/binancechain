import 'package:bnbapp/screens/tab/cubit/tab_cubit.dart';
import 'package:bnbapp/utils/colors.dart';
import 'package:bnbapp/widgets/tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/tab_state.dart';

class TabScreen extends StatelessWidget {
  const TabScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TabScreenCubit>();
    return Scaffold(
      body: BlocListener(
        bloc: cubit,
        listener: (context, state) {
          if (state is TabScreenErrorState) {
            if (!state.error.contains('404')) {
              const SnackBar(
                content: Text("error"),
              );
            }
          }
        },
        child: const Tab(),
      ),
    );
  }
}

class Tab extends StatefulWidget {
  const Tab({Key? key}) : super(key: key);

  @override
  State<Tab> createState() => _TabState();
}

class _TabState extends State<Tab> {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TabScreenCubit>();
    return BlocBuilder<TabScreenCubit, TabScreenState>(
        bloc: cubit,
        builder: (context, state) => Container(color:AllColor.white,
              child:  CustomTabBar(inActiveColor: AllColor.white,activeColor: AllColor.black,cubit: cubit),
            ));
  }
}
