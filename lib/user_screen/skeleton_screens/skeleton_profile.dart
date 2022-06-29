import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:skeletons/skeletons.dart';

class SkeletonProfile extends StatelessWidget {
  const SkeletonProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 8,
      itemBuilder: (context, index) => Container(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
        decoration: const BoxDecoration(color: Colors.white),
        child: SkeletonItem(
            child: Column(
          children: [
            SizedBox(
              height: 2.h,
            ),
            SkeletonAvatar(
              style: SkeletonAvatarStyle(
                  shape: BoxShape.circle,
                  width: 25.h,
                  height: 25.h,
                  borderRadius:
                      const BorderRadius.horizontal(left: Radius.circular(10))),
            ),
            SizedBox(height: 6.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SkeletonParagraph(
                  style: SkeletonParagraphStyle(
                      lines: 1,
                      spacing: 6,
                      lineStyle: SkeletonLineStyle(
                          randomLength: true,
                          height: 18,
                          borderRadius: BorderRadius.circular(8),
                          minLength: 48.w,
                          maxLength: 49.w)),
                ),
                SkeletonAvatar(
                  style: SkeletonAvatarStyle(
                    shape: BoxShape.circle,
                    width: 4.h,
                    height: 4.h,
                   ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SkeletonParagraph(
              style: SkeletonParagraphStyle(
                  lines: 20,
                  spacing: 20,
                  lineStyle: SkeletonLineStyle(
                    randomLength: true,
                    height: 10,
                    borderRadius: BorderRadius.circular(8),
                    minLength: 20.h,
                    maxLength: 25.h,
                  )),
            ),
          ],
        )),
      ),
    );
  }
}
