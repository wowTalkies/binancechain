import 'package:bnbapp/screens/faq/model/faq_model.dart';
import 'package:bnbapp/utils/colors.dart';
import 'package:bnbapp/widgets/text.dart';
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
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: height,
      width: width,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        // physics: const NeverScrollableScrollPhysics(),
        itemCount: itemCount,
        // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1, childAspectRatio: MediaQuery.of(context).size.height / (MediaQuery.of(context).size.height * 0.5)),
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                  child: ExpansionTile(
                trailing: const Icon(Icons.add, color: AllColor.white),
                collapsedIconColor: AllColor.white,
                title: CustomText(
                  text: question![index]?.question.toString(),
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  fontColor: AllColor.bottomSheet,
                ),
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
                      child: CustomText(
                        text: question![index]?.answer.toString(),
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        fontColor: AllColor.bottomSheet,
                      ),
                    ),
                  ),
                ],
              )
                  /*
                  Tabs(
                    linear: Colors.transparent,
                    height: containerHeight,
                    color: AllColor.bottomSheet,
                    text2: question![index]?.answer.toString(),
                    faq: "yes",
                    assetImage: null,
                    text: question![index]?.question.toString(),
                  ),

                   */
                  ),
              Divider(
                thickness: 3,
                color: dividerColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}
