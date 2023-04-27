import 'package:bnbapp/utils/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomListViewBuilder extends StatelessWidget {
  final int? itemCount;
  final Axis? scrollDirection;
  final List<String>? list;

  const CustomListViewBuilder(
      {Key? key, this.itemCount, this.scrollDirection, this.list})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height / 10,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: scrollDirection!,
        itemCount: itemCount,
        itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: CircleAvatar(
              radius: height / 30,
              backgroundColor: AllColor.linear1,
              foregroundColor: AllColor.linear2,
              child: ClipOval(
                child: CachedNetworkImage(
                    height: height / 16,
                    fit: BoxFit.fill,
                    placeholder: (context, url) => const SizedBox(
                          child: Center(
                            child: CircularProgressIndicator(
                              color: AllColor.white,
                            ),
                          ),
                        ),
                    imageUrl: list?[index] ?? ''),
              ),
            )),
      ),
    );
  }
}
