import 'package:bnbapp/screens/faq/model/faq_model.dart';
import 'package:bnbapp/utils/colors.dart';
import 'package:bnbapp/widgets/tabs.dart';
import 'package:flutter/material.dart';

class FAQWidget extends StatelessWidget {
  final Color? textColor;
  final Color? dividerColor;
  final int? itemCount;
  final List<FAQModel?>? question;
  final double? containerHeight;

  const FAQWidget(
      {Key? key,
      this.textColor,
      this.itemCount,
      this.question,
      this.containerHeight,
      this.dividerColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: MediaQuery.of(context).size.height /
              (MediaQuery.of(context).size.height * 0.4)),
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Center(
                child: Tabs(
                  linear: Colors.transparent,
                  height: containerHeight,
                  color: AllColor.bottomSheet,
                  text2: question![index]?.answer.toString(),
                  faq: "yes",
                  assetImage: null,
                  text: question![index]?.question.toString(),
                ),
              ),
            ),
            Divider(
              thickness: 3,
              color: dividerColor,
            )
          ],
        ),
      ),
    );
  }
}
