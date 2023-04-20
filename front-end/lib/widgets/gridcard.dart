import 'package:bnbapp/utils/colors.dart';
import 'package:bnbapp/widgets/button.dart';
import 'package:bnbapp/widgets/text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class GridCard extends StatelessWidget {
  final int? itemCount;
  final List<String?>? imageUrl;
  const GridCard({Key? key, this.itemCount, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width / 1.1,
        alignment: Alignment.center,
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: itemCount,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: MediaQuery.of(context).size.height /
                  (MediaQuery.of(context).size.height * 0.7)),
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
            child: Container(
              width: MediaQuery.of(context).size.width / 1.1,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AllColor.white, AllColor.white],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  color: AllColor.white),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Container(
                      decoration: const BoxDecoration(
                          color: AllColor.white,
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      height: MediaQuery.of(context).size.height / 4,
                      width: MediaQuery.of(context).size.width / 0.9,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: CachedNetworkImage(
                            fit: BoxFit.fill,
                            placeholder: (context, url) => const SizedBox(
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color: AllColor.white,
                                    ),
                                  ),
                                ),
                            imageUrl: imageUrl?[index] ?? ''),
                      ),
                    ),
                  ),
                  Positioned(
                     child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          CustomText(
                              text: "200",
                              fontWeight: FontWeight.w700,
                              fontColor: Colors.grey,
                              fontSize: 19),
                          Icon(
                            Icons.person,
                            size: 40,
                            color: Colors.grey,
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned.fill(
                    top: null,
                    child: Container(
                        width: MediaQuery.of(context).size.width / 1.1,
                        height: MediaQuery.of(context).size.height / 12,
                        decoration: const BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(8),
                                bottomRight: Radius.circular(8)),
                            gradient: LinearGradient(
                              colors: [AllColor.linear1, AllColor.linear2],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            color: AllColor.white),
                        child: Row(
                          //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 100,
                                ),
                                const CustomText(
                                    text: "Community 1",
                                    fontWeight: FontWeight.w700,
                                    fontColor: AllColor.white,
                                    fontSize: 19),
                                SizedBox(
                                  width: MediaQuery.of(context).size.height / 4,
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 100,
                                ),
                                const CustomText(
                                    text: "Jackie chan community",
                                    fontWeight: FontWeight.w400,
                                    fontColor: AllColor.white,
                                    fontSize: 14),
                              ],
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 6,
                            ),
                            Button(
                              text: "Take Quiz",
                              height: MediaQuery.of(context).size.height / 19,
                              width: MediaQuery.of(context).size.width / 4,
                            ),
                          ],
                        )),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
