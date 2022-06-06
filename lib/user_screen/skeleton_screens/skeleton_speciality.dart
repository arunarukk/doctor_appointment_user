import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:skeletons/skeletons.dart';

class SkeletonSpeciality extends StatelessWidget {
  const SkeletonSpeciality({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  
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
                          width: 14.h,
                          height:15.h,
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(10))),
                    ),
                    SkeletonParagraph(
                      style: SkeletonParagraphStyle(
                          lines: 1,
                          spacing: 10,
                          lineStyle: SkeletonLineStyle(
                            randomLength: true,
                            height: 13,
                            borderRadius: BorderRadius.circular(8),
                            minLength:8.h,
                            maxLength:9.h,
                          )),
                    ),
                  ],
                ),
              ))),
    );
  }
}
