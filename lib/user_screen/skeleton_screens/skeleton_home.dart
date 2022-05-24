import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class SkeletonHome extends StatelessWidget {
  const SkeletonHome({Key? key}) : super(key: key);

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
            Row(
              children: [
                SkeletonAvatar(
                  style: SkeletonAvatarStyle(
                      shape: BoxShape.rectangle,
                      width: size * .14,
                      height: size * .16,
                      borderRadius:
                          BorderRadius.horizontal(left: Radius.circular(10))),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SkeletonParagraph(
                        style: SkeletonParagraphStyle(
                            lines: 1,
                            spacing: 25,
                            lineStyle: SkeletonLineStyle(
                              randomLength: true,
                              height: 10,
                              borderRadius: BorderRadius.circular(8),
                              minLength: size / 9,
                              maxLength: size / 8,
                            )),
                      ),
                      SkeletonParagraph(
                        style: SkeletonParagraphStyle(
                            lines: 1,
                            spacing: 25,
                            lineStyle: SkeletonLineStyle(
                              randomLength: true,
                              height: 15,
                              borderRadius: BorderRadius.circular(8),
                              minLength: size / 10,
                              maxLength: size / 9,
                            )),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      SkeletonParagraph(
                        style: SkeletonParagraphStyle(
                            lines: 1,
                            spacing: 25,
                            lineStyle: SkeletonLineStyle(
                              randomLength: true,
                              height: 10,
                              borderRadius: BorderRadius.circular(8),
                              minLength: size / 11,
                              maxLength: size / 10,
                            )),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SkeletonParagraph(
                            style: SkeletonParagraphStyle(
                                lines: 1,
                                spacing: 25,
                                lineStyle: SkeletonLineStyle(
                                  randomLength: true,
                                  height: 22,
                                  borderRadius: BorderRadius.circular(8),
                                  minLength: size / 7,
                                  maxLength: size / 6,
                                )),
                          ),
                          SkeletonParagraph(
                            style: SkeletonParagraphStyle(
                                lines: 1,
                                spacing: 25,
                                lineStyle: SkeletonLineStyle(
                                  randomLength: true,
                                  height: 22,
                                  borderRadius: BorderRadius.circular(8),
                                  minLength: size / 12,
                                  maxLength: size / 11,
                                )),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
            // SizedBox(height: 12),
            // SkeletonParagraph(
            //   style: SkeletonParagraphStyle(
            //       lines: 3,
            //       spacing: 6,
            //       lineStyle: SkeletonLineStyle(
            //         randomLength: true,
            //         height: 10,
            //         borderRadius: BorderRadius.circular(8),
            //         minLength: MediaQuery.of(context).size.width / 2,
            //       )),
            // ),
            // SizedBox(height: 12),
            // SkeletonAvatar(
            //   style: SkeletonAvatarStyle(
            //     width: double.infinity,
            //     minHeight: MediaQuery.of(context).size.height / 8,
            //     maxHeight: MediaQuery.of(context).size.height / 3,
            //   ),
            // ),
            // SizedBox(height: 8),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Row(
            //       children: [
            //         SkeletonAvatar(
            //             style: SkeletonAvatarStyle(width: 20, height: 20)),
            //         SizedBox(width: 8),
            //         SkeletonAvatar(
            //             style: SkeletonAvatarStyle(width: 20, height: 20)),
            //         SizedBox(width: 8),
            //         SkeletonAvatar(
            //             style: SkeletonAvatarStyle(width: 20, height: 20)),
            //       ],
            //     ),
            //     SkeletonLine(
            //       style: SkeletonLineStyle(
            //           height: 16,
            //           width: 64,
            //           borderRadius: BorderRadius.circular(8)),
            //     )
            //   ],
            // )
          ],
        )),
      ),
    );
  }
}
