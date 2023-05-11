import 'package:bnbapp/screens/community/cubit/cummunity_cubit.dart';
import 'package:bnbapp/screens/community/cubit/cummunity_state.dart';
import 'package:bnbapp/utils/colors.dart';
import 'package:bnbapp/widgets/text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'button.dart';

class GridCard extends StatelessWidget {
  final int? itemCount;
  final List<String>? imageUrl;
  final CommunityCubit? cubit;
  final List<String>? descriptionList;
  final List<BigInt>? totalMembers;
  final List<String>? communityNameList;

  const GridCard(
      {Key? key,
      this.itemCount,
      this.imageUrl,
      this.descriptionList,
      this.totalMembers,
      this.communityNameList,
      this.cubit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommunityCubit, CommunityState>(
      bloc: cubit,
      builder: (context, state) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {},
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          height: MediaQuery.of(context).size.height / 4,
                          width: MediaQuery.of(context).size.width / 0.9,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: InkWell(
                              onTap: () {},
                              child: CachedNetworkImage(
                                  fit: BoxFit.fill,
                                  placeholder: (context, url) => const SizedBox(
                                        child: Center(
                                          child: CircularProgressIndicator(
                                            color: AllColor.white,
                                          ),
                                        ),
                                      ),
                                  imageUrl: imageUrl![index].toString() ?? ''),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              CustomText(
                                  text: totalMembers![index].toString(),
                                  fontWeight: FontWeight.w700,
                                  fontColor: AllColor.white,
                                  fontSize: 19),
                              const Icon(
                                Icons.person,
                                size: 40,
                                color: AllColor.white,
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height /
                                        100,
                                  ),
                                  Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                50,
                                            left: 5),
                                        child: CustomText(
                                            text: communityNameList![index]
                                                .toString(),
                                            fontWeight: FontWeight.w700,
                                            fontColor: AllColor.white,
                                            fontSize: 19),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height /
                                        100,
                                  ),
                                  /*
                                        SizedBox(
                                          width: 300,
                                          child: CustomText(
                                              text: descriptionList![index]
                                                  .toString(),
                                              fontWeight: FontWeight.w400,
                                              fontColor: AllColor.white,
                                              fontSize: 14),
                                        ),

                                         */
                                ],
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 100,
                              ),

                              /*
                                    Button(
                                      text: "Take Quiz",
                                      textSize: 14,
                                      height:
                                          MediaQuery.of(context).size.height / 20,
                                      // width: MediaQuery.of(context).size.width / 3.8,
                                    ),

                                     */
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.height / 4.1,
                        left: MediaQuery.of(context).size.width / 1.3,
                        child: cubit?.state is CommunityJoinCheckState &&
                                cubit?.checkIndex == index
                            ? Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                    color: AllColor.black,
                                    borderRadius: BorderRadius.circular(8),
                                    shape: BoxShape.rectangle),
                                child: const Padding(
                                  padding: EdgeInsets.all(1.0),
                                  child: CircularProgressIndicator(
                                      color: AllColor.white),
                                ))
                            : Button(
                                onPressed: () {
                                  cubit?.checkIndex = index;
                                  debugPrint(
                                      'the name is ${communityNameList![index].toString()}');
                                  cubit!.checkMembership(
                                      communityNameList![index].toString());
                                },
                                height: 30,
                                text: cubit?.joinOrOpen[index].toString() ==
                                        "joined"
                                    ? 'Posts'
                                    : "Join",
                              ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Feeds extends StatelessWidget {
  const Feeds({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AllColor.blue,
    );
  }
}
