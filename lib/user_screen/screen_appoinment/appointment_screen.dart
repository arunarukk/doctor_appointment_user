import 'package:doctor_appointment/constant_value/constant_colors.dart';
import 'package:doctor_appointment/resources/data_controller.dart';
import 'package:doctor_appointment/user_screen/widget/Appoinment/appoinment_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../get_controller/get_controller.dart';

class AppointmentScreen extends StatelessWidget {
  AppointmentScreen({Key? key}) : super(key: key);

  DateTimeRange? dateRange;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            'Appointment',
            style: TextStyle(color: kBlack),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  bottom_scheet(context);
                },
                icon: const Icon(
                  Icons.filter_list_outlined,
                  color: kBlack,
                ))
          ],
          centerTitle: true,
          elevation: 0,
          bottom: TabBar(
              indicatorWeight: 1,
              indicatorSize: TabBarIndicatorSize.label,
              unselectedLabelColor: Colors.grey,
              isScrollable: true,
              labelColor: kWhite,
              labelStyle:
                  const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              indicator: BoxDecoration(
                color: kBlue,
                borderRadius: BorderRadius.circular(50),
              ),
              tabs: [
                Tab(
                  child: Container(
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: kBlue, width: 1)),
                    child: const Align(
                      alignment: Alignment.center,
                      child: Text("Upcoming"),
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: kBlue, width: 1)),
                    child: const Align(
                      alignment: Alignment.center,
                      child: Text("Past"),
                    ),
                  ),
                ),
              ]),
        ),
        body: TabBarView(
          children: [
            AppointmentWidget(
              isUpcoming: true,
            ),
            AppointmentWidget(
              isUpcoming: false,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> bottom_scheet(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 16.h,
          width: 1.h,
          child: GetBuilder<StateController>(
            init: StateController(),
            id: 'filter',
            builder: (filter) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Container(
                          width: 34.h,
                          child: ListTile(
                            title: const Text('Date range'),
                            onTap: () async {
                              await pickDateRange(context);
                            },
                          )),
                      dateRange == null
                          ? Container()
                          : Text(
                              '${filter.selectedStartDate}  - ${filter.selectedEndDate}',
                              style: const TextStyle(color: Colors.black),
                            ),
                    ],
                  ),
                  Text(
                    'Filter for past',
                    style: TextStyle(color: Colors.grey.shade300),
                  )
                ],
              );
            },
          ),
        );
      },
    );
  }

  Future pickDateRange(BuildContext context) async {
    final initialDateRange = DateTimeRange(
      start: DateTime.now(),
      end: DateTime.now().add(const Duration(hours: 24 * 3)),
    );
    final newDateRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime(DateTime.now().year + 1),
      initialDateRange: dateRange ?? initialDateRange,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary: kBlue,
              onPrimary: kWhite,
              surface: kBlue,
              onSurface: kWhite,
            ),

            // Here I Chaged the overline to my Custom TextStyle.
            textTheme: const TextTheme(overline: TextStyle(fontSize: 16)),
            dialogBackgroundColor: kWhite,
          ),
          child: child!,
        );
      },
    );

    if (newDateRange == null) return;
    dateRange = newDateRange;
    statecontrol.dateRange(dateRange);
    // statecontrol.update();
    datacontrol.dateRange = dateRange;
    datacontrol.update(['appointment']);
    if (dateRange != null) {}
  }
}
