import 'dart:math';

import 'package:doctor_appointment/constant_value/constant_colors.dart';
import 'package:doctor_appointment/get_controller/get_controller.dart';
import 'package:doctor_appointment/resources/data_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class RatingWidget extends StatelessWidget {
  final docID;
  RatingWidget({Key? key, this.docID}) : super(key: key);

  final _ratingPageController = PageController();
  final control = Get.put(StateController());

  double _rating = 0;
  final TextEditingController _reviewController = TextEditingController();

  // var _isMoreDetailActive = false;

  @override
  Widget build(BuildContext context) {
    control.startPosition = 200.0;
    control.selectedChipIndex = -1;
    control.isMoreDetail = false;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Container(
            height: max(300, 3.h),
            child: PageView(
              controller: _ratingPageController,
              physics: NeverScrollableScrollPhysics(),
              children: [
                _buildThanksNote(),
                _causeOfRating(),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.red,
              child: MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                  // print(_rating);
                  // print(_reviewController.text);
                  // print(docID);
                  datacontrol.addRatingAndReview(
                      docID: docID,
                      rating: _rating,
                      review: _reviewController.text);
                 
                },
                child: Text('Done'),
                textColor: kWhite,
              ),
            ),
          ),
          Positioned(
            right: 0,
            child: MaterialButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Skip'),
            ),
          ),
          GetBuilder<StateController>(
            init: StateController(),
            builder: (controller) {
              return AnimatedPositioned(
                top: controller.startPosition,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    5,
                    (index) => IconButton(
                      onPressed: () {
                        _ratingPageController.nextPage(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeIn);
                        controller.starAnimation(20.0);
                        _rating = index + 1;
                      },
                      icon: index < _rating
                          ? Icon(
                              Icons.star,
                              size: 32,
                            )
                          : Icon(
                              Icons.star_border,
                              size: 32,
                            ),
                      color: Colors.red,
                    ),
                  ),
                ),
                duration: Duration(milliseconds: 300),
              );
            },
          ),
        ],
      ),
    );
  }

  _buildThanksNote() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text(
          'thanks for ',
          style: TextStyle(
            fontSize: 24,
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        Text('We\'d love to get your feedback'),
        Text('How was your Appointment today?'),
      ],
    );
  }

  _causeOfRating() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Visibility(
          visible: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('What could be Better?'),
              GetBuilder<StateController>(
                init: StateController(),
                builder: (controller) {
                  return Wrap(
                    spacing: 8.0,
                    alignment: WrapAlignment.center,
                    children: List.generate(
                      6,
                      (index) => InkWell(
                        onTap: () {
                          print('click');
                          controller.selectedIndex(index);
                        },
                        child: Chip(
                          backgroundColor: controller.selectedChipIndex == index
                              ? Colors.red
                              : Colors.grey[300],
                          label: Text('TEXT${index + 1}'),
                        ),
                      ),
                    ),
                  );
                },
              ),
              InkWell(
                  onTap: () {
                    control.isMoreDetailActive(true);
                  },
                  child: Text(
                    'Want to tell us more?',
                    style: TextStyle(decoration: TextDecoration.underline),
                  )),
            ],
          ),
          replacement: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Tell us more'),
              // Chip(
              //   label: Text('Text ${control.selectedChipIndex + 1}'),
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  controller: _reviewController,
                  decoration: InputDecoration(
                      hintText: 'Write your review here...',
                      hintStyle: TextStyle(
                        color: Colors.grey[400],
                      ),
                      border: InputBorder.none),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
