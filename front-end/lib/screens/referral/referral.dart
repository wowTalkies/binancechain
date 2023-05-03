import 'package:bnbapp/utils/colors.dart';
import 'package:bnbapp/widgets/page.dart';
import 'package:bnbapp/widgets/text.dart';
import 'package:bnbapp/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/referral_cubit.dart';
import 'cubit/refrral_state.dart';

class Referral extends StatelessWidget {
  const Referral({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ReferralCubit>();

    return Scaffold(
      body: BlocListener(
        bloc: cubit,
        listener: (context, state) {
          if (state is ReferralLinkCopiedStateState) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Invite link copied to clipboard")));
          }
          if (state is ReferralErrorState) {
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
    final cubit = context.read<ReferralCubit>();

    return Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              CustomPage(
                text: "it's no Fun without\nFriends",
                fontSize: 25,
                fontWeight: FontWeight.w700,
                color: AllColor.white,
                color2: AllColor.white,
                fontSize2: 16,
                fontWeight2: FontWeight.w400,
                text2: "Bring your friend and earn points",
                text3: "Unlock exciting\nfeatures & top\nthe Leaderboard!",
                points1: cubit.authCubit.points.toString(),
                points2: "points",
                points3: "Collected",
                color4: AllColor.black,
                referral1: "Invite your friends",
                referral2: "Get points on successful Signup",
                referral3: "Multilevel referral",
                referral4: "Unlock experiences with points",
                whatsAppOnPressed: () async {
                  await cubit.createLinkandShare("WhatsApp");
                  //  await cubit.flutterShareMe.shareToWhatsApp();
                },
                instagramOnPressed: () async {
                  await cubit.createLinkandShare("Instagram");
                  //   await cubit.flutterShareMe.shareToInstagram(filePath: "");
                },
                telegramOnPressed: () async {
                  await cubit.createLinkandShare("Telegram");
                  // await cubit.flutterShareMe.shareToTelegram(msg: "Telegram");
                },
                linkOnPressed: () async {
                  await cubit.createLinkandShare("Link");
                  // await cubit.flutterShareMe.shareToWhatsApp();
                },
                fontSize3: 14,
                onPressed: () {
                  showBottomSheet(
                    context: context,
                    builder: (context) => Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 1.5,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          shape: BoxShape.rectangle,
                          color: AllColor.bottomSheet),
                      child: Column(
                        children: [
                          Expanded(
                              child: ListView(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      fit: BoxFit.fill,
                                      alignment: Alignment.topLeft,
                                      "images/wowT.png",
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Icon(
                                        Icons.close,
                                        color: AllColor.black,
                                        size:
                                            MediaQuery.of(context).size.width /
                                                16,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                    child: CustomTextField(
                                      width: MediaQuery.of(context).size.width /
                                          1.4,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              6,
                                      controller: cubit.textEditingController,
                                      hintText: "Write text here",
                                      textFieldColor: AllColor.bottomSheet,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 16,
                              ),
                              // ContactsList(cubit: cubit),
                              const Divider(color: AllColor.black, height: 6),

                              SizedBox(
                                height: MediaQuery.of(context).size.height / 40,
                              ), //
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 7,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: cubit?.contacts.length,
                                  itemBuilder: (context, index) => Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 5, left: 5, bottom: 2),
                                        child: SizedBox(
                                            width: 90,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                12,
                                            child: cubit.contacts[index]
                                                        .photo ==
                                                    null
                                                ? InkWell(
                                                    onTap: () async {
                                                      await cubit.sendMessage(
                                                          '${cubit.textEditingController.value.text}\n${cubit.initialLink}',
                                                          cubit
                                                              .contacts[index]
                                                              .phones[0]
                                                              .number);
                                                    },
                                                    child: const Icon(
                                                        Icons.person))
                                                : InkWell(
                                                    onTap: () async {
                                                      await cubit.sendMessage(
                                                          '${cubit.textEditingController.value.text}\n${cubit.initialLink}',
                                                          cubit
                                                              .contacts[index]
                                                              .phones[0]
                                                              .number);
                                                    },
                                                    child: CircleAvatar(
                                                      radius: 25,
                                                      backgroundImage:
                                                          MemoryImage(cubit
                                                              .contacts[index]
                                                              .photo!),
                                                    ),
                                                  )),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 10, left: 10),
                                        child: CustomText(
                                          text:
                                              cubit.contacts[index].displayName,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 80,
                              ),
                              const Divider(color: AllColor.black, height: 6),
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 40,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 20,
                                  ),
                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(0.0),
                                        child: InkWell(
                                          onTap: () async {
                                            await cubit
                                                .createLinkandShare("Email");
                                          },
                                          child: Image.asset(
                                            fit: BoxFit.contain,
                                            alignment: Alignment.topLeft,
                                            "images/Mail Icon.png",
                                          ),
                                        ),
                                      ),
                                      const CustomText(
                                        fontSize: 11,
                                        text: 'Mail',
                                        fontWeight: FontWeight.w400,
                                        fontColor: AllColor.black,
                                      )
                                    ],
                                  ),
                                  /*
                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 0, 9),
                                        child: InkWell(
                                          onTap: () async {
                                            await cubit.flutterShareMe
                                                .shareToMessenger(msg: "msg");
                                          },
                                          child: Image.asset(
                                            fit: BoxFit.contain,
                                            alignment: Alignment.topLeft,
                                            "images/Messenger Icon.png",
                                          ),
                                        ),
                                      ),
                                      const CustomText(
                                        fontSize: 11,
                                        text: 'Messenger',
                                        fontWeight: FontWeight.w400,
                                        fontColor: AllColor.black,
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 0, 9),
                                        child: InkWell(
                                          onTap: () async {
                                            await cubit.send();
                                          },
                                          child: Image.asset(
                                            fit: BoxFit.contain,
                                            alignment: Alignment.topLeft,
                                            "images/Messages Icon.png",
                                          ),
                                        ),
                                      ),
                                      const CustomText(
                                        fontSize: 11,
                                        text: 'Messenger',
                                        fontWeight: FontWeight.w400,
                                        fontColor: AllColor.black,
                                      )
                                    ],
                                  ),

                                   */
                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 0, 9),
                                        child: InkWell(
                                          onTap: () async {
                                            await cubit
                                                .createLinkandShare("WhatsApp");
                                          },
                                          child: Image.asset(
                                            fit: BoxFit.fill,
                                            alignment: Alignment.topLeft,
                                            "images/Whatsapp Icon.png",
                                          ),
                                        ),
                                      ),
                                      const CustomText(
                                        fontSize: 11,
                                        text: 'Whatsapp',
                                        fontWeight: FontWeight.w400,
                                        fontColor: AllColor.black,
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 20,
                                  ),
                                ],
                              )
                            ],
                          )),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ContactsList extends StatelessWidget {
  final ReferralCubit? cubit;

  const ContactsList({Key? key, this.cubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.builder(
        itemCount: cubit?.contacts.length ?? 0,
        itemBuilder: (context, index) => Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [AllColor.linear1, AllColor.linear2],
            ),
          ),
          child: Column(
            children: [
              CustomText(
                text: cubit?.contacts[index].name.first.toString() ?? '',
              )
            ],
          ),
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            childAspectRatio: MediaQuery.of(context).size.height /
                (MediaQuery.of(context).size.height * 0.7)),
      ),
    );
  }
}
