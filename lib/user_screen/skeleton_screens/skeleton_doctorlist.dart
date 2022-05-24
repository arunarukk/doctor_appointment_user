import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class SkeletonDoctorList extends StatelessWidget {
  const SkeletonDoctorList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.height;
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 4.0,
          mainAxisSpacing: 4.0,
          mainAxisExtent: size * .21,
        ),
        //controller: scrollController,
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
        itemBuilder: (ctx, index) {
          return SkeletonItem(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SkeletonAvatar(
                  style: SkeletonAvatarStyle(
                      shape: BoxShape.rectangle,
                      width: size * .16,
                      height: size * .14,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(10))),
                ),
                SkeletonParagraph(
                  style: SkeletonParagraphStyle(
                      lines: 2,
                      spacing: 3,
                      lineStyle: SkeletonLineStyle(
                        randomLength: true,
                        height: 8,
                        borderRadius: BorderRadius.circular(8),
                        minLength: size / 10,
                        maxLength: size / 9,
                      )),
                ),
              ],
            ),
          ));
        });
  }
}
