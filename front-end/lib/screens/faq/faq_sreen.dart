import 'package:bnbapp/screens/faq/cubit/faq_cubit.dart';
import 'package:bnbapp/screens/faq/cubit/faq_state.dart';
import 'package:bnbapp/utils/colors.dart';
import 'package:bnbapp/widgets/appbar.dart';
import 'package:bnbapp/widgets/faq_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FAQ extends StatelessWidget {
  const FAQ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FAQCubit>();
    return Scaffold(
      body: BlocListener(
        bloc: cubit,
        listener: (context, state) {
          if (state is FAQErrorState) {
            if (!state.error.contains('404')) {
              const SnackBar(
                content: Text("error"),
              );
            }
          }
        },
        child: const _LayOut(),
      ),
    );
  }
}

class _LayOut extends StatelessWidget {
  const _LayOut({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FAQCubit>();
    return Container(
      decoration: const BoxDecoration(
          gradient:
              LinearGradient(colors: [AllColor.linear1, AllColor.linear2])),
      child: Column(
        children: [
          const CustomAppBar(
            appBarHeight: 70,
            title: "Frequently Asked Questions",
            icon: Icon(Icons.arrow_back, color: AllColor.black, size: 30),
          ),
          Expanded(
            child: ListView(
              children: [
                Column(
                  children: [
                    FAQWidget(
                      containerHeight: 300,
                      dividerColor: AllColor.faqDividerColor,
                      itemCount: cubit.faqModel.length,
                      question: cubit.faqModel,
                      textColor: AllColor.linear1,
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
