import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:skeletons/skeletons.dart';

class SkeletonHome extends StatelessWidget {
  const SkeletonHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                      width: 14.h,
                      height: 16.h,
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
                              minLength: 8.h,
                              maxLength: 9.h,
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
                              minLength: 9.h,
                              maxLength: 10.h,
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
                              minLength: 10.h,
                              maxLength: 11.h,
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
                                  minLength: 12.h,
                                  maxLength: 13.h,
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
                                  minLength: 11.h,
                                  maxLength: 12.h,
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
