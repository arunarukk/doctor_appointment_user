import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class SkeletonProfile extends StatelessWidget {
  const SkeletonProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.height;
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemCount: 8,
      itemBuilder: (context, index) => Container(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
        decoration: BoxDecoration(color: Colors.white),
        child: SkeletonItem(
            child: Column(
          children: [
            SizedBox(
              height: size * .02,
            ),
            SkeletonAvatar(
              style: SkeletonAvatarStyle(
                  shape: BoxShape.circle,
                  width: size * .25,
                  height: size * .25,
                  borderRadius:
                      BorderRadius.horizontal(left: Radius.circular(10))),
            ),
            SizedBox(height: size * .06),
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
                          minLength: size * .2,
                          maxLength: size * .3)),
                ),
                SkeletonAvatar(
                  style: SkeletonAvatarStyle(
                    shape: BoxShape.circle,
                    width: size * .04,
                    height: size * .04,
                    // minHeight: size * .01,
                    // maxHeight: size * .02,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            SkeletonParagraph(
              style: SkeletonParagraphStyle(
                  lines: 20,
                  spacing: 20,
                  lineStyle: SkeletonLineStyle(
                      randomLength: true,
                      height: 10,
                      borderRadius: BorderRadius.circular(8),
                      minLength: size * .2,
                      maxLength: size * .3)),
            ),
          ],
        )),
      ),
    );
  }
}
