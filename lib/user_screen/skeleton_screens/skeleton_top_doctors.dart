import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class SkeletonTopDoctors extends StatelessWidget {
  const SkeletonTopDoctors({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.height;
    return ListView(
      physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.horizontal,
      children: List.generate(
          4,
          (index) => SkeletonItem(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SkeletonAvatar(
                      style: SkeletonAvatarStyle(
                          shape: BoxShape.rectangle,
                          width: size * .16,
                          height: size * .15,
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(10))),
                    ),
                    SkeletonParagraph(
                      style: SkeletonParagraphStyle(
                          lines: 2,
                          spacing: 3,
                          lineStyle: SkeletonLineStyle(
                            randomLength: true,
                            height: 13,
                            borderRadius: BorderRadius.circular(8),
                            minLength: size / 9,
                            maxLength: size / 8,
                          )),
                    ),
                  ],
                ),
              ))),
    );
  }
}
