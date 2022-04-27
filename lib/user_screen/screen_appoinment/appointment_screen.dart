import 'package:doctor_appointment/constant_value/constant_colors.dart';
import 'package:doctor_appointment/resources/data_controller.dart';
import 'package:doctor_appointment/user_screen/widget/Appoinment/appoinment_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../get_controller/get_controller.dart';

class AppointmentScreen extends StatelessWidget {
  AppointmentScreen({Key? key}) : super(key: key);

  // final TabController _tabController = TabController(vsync: this,length: 2);
  DateTimeRange? dateRange;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.height;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Appoinment',
            style: TextStyle(color: kBlack),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  bottom_scheet(context);
                  print('filter');
                },
                icon: Icon(
                  Icons.filter_list_outlined,
                  color: kBlack,
                ))
          ],
          centerTitle: true,
          elevation: 0,
          bottom: TabBar(
              indicatorWeight: 1,
              //indicatorColor: Colors.black,
              indicatorSize: TabBarIndicatorSize.label,
              unselectedLabelColor: Colors.grey,
              isScrollable: true,
              labelColor: kWhite,
              labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              indicator: BoxDecoration(
                color: kBlue,
                borderRadius: BorderRadius.circular(50),
                //border: Border.all(),
              ),
              tabs: [
                Tab(
                  child: Container(
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: kBlue, width: 1)),
                    child: Align(
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
                    child: Align(
                      alignment: Alignment.center,
                      child: Text("Past"),
                    ),
                  ),
                ),
              ]),
        ),
        body: TabBarView(
          //controller: _tabController,
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
    final size = MediaQuery.of(context).size.height;
    return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: size * .2,
          width: size * .1,

          // color: kBlue,
          // decoration: BoxDecoration(
          //   color: kBlack,
          //   borderRadius:
          //       BorderRadius.vertical(top: Radius.circular(30)),
          // ),
          child: GetBuilder<StateController>(
            init: StateController(),
            id: 'filter',
            builder: (filter) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // mainAxisSize: MainAxisSize.min,
                // crossAxisAlignment: CrossAxisAlignment.center,

                children: [
                  Row(
                    children: [
                      Container(
                          width: size * .34,
                          // color: kBlack,
                          child: ListTile(
                            title: Text('Date range'),
                            onTap: () async {
                              await pickDateRange(context);
                              //  print(dateRange!.start);
                            },
                          )),
                      dateRange == null
                          ? Container()
                          : Text(
                              '${filter.selectedStartDate}  - ${filter.selectedEndDate}',
                              style: TextStyle(color: Colors.black),
                              // _selectedDate.toString(),
                            ),
                    ],
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
      end: DateTime.now().add(Duration(hours: 24 * 3)),
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
            textTheme: TextTheme(overline: TextStyle(fontSize: 16)),
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

    // setState(() {});

    //print(newDateRange.start);
    //print(dateRange);
    // print(_selectedStartDate);
    if (dateRange != null) {}
  }
}

// class DateRange extends StatefulWidget {
//   const DateRange({Key? key}) : super(key: key);

//   @override
//   State<DateRange> createState() => _DateRangeState();
// }

// class _DateRangeState extends State<DateRange> {
//   void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
//     String _selectedDate = '';
//     String _dateCount = '';
//     String _range = '';
//     String _rangeCount = '';

//     setState(() {
//       if (args.value is PickerDateRange) {
//         _range = '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} -'
//             // ignore: lines_longer_than_80_chars
//             ' ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
//       } else if (args.value is DateTime) {
//         _selectedDate = args.value.toString();
//       } else if (args.value is List<DateTime>) {
//         _dateCount = args.value.length.toString();
//       } else {
//         _rangeCount = args.value.length.toString();
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SfDateRangePicker(
//       onSelectionChanged: _onSelectionChanged,
//       selectionMode: DateRangePickerSelectionMode.range,
//       initialSelectedRange: PickerDateRange(
//           DateTime.now().subtract(const Duration(days: 4)),
//           DateTime.now().add(const Duration(days: 3))),
//     );
//   }
// }
