import 'package:bnbapp/utils/colors.dart';
import 'package:bnbapp/widgets/appbar.dart';
import 'package:bnbapp/widgets/faq_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/faq_cubit.dart';
import 'cubit/faq_state.dart';

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
        child: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.rectangle,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [AllColor.linear1, AllColor.linear2],
              ),
            ),
            child: const _LayOut()),
      ),
    );
  }
}

class _LayOut extends StatelessWidget {
  const _LayOut({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FAQCubit>();
    return BlocBuilder(
      bloc: cubit,
      builder: (context, state) => Column(
        children: [
          const CustomAppBar(
            icon: Icon(Icons.arrow_back, color: AllColor.black, size: 30),
            appBarHeight: 70,
            title: "Frequently Asked Questions",
          ),
          Expanded(
              child: ListView(
            children: [
              FAQWidget(
                dividerColor: AllColor.faqDividerColor,
                textColor: AllColor.white,
                itemCount: cubit.faqModel?.length,
                question: cubit.faqModel,
                // text: cubit.maps.values.toString(),
              )
            ],
          ))
        ],
      ),
    );
  }
}
