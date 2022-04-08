import 'package:doctor_appointment/constant_value/constant_colors.dart';
import 'package:doctor_appointment/user_screen/widget/Appoinment/appoinment_widget.dart';
import 'package:flutter/material.dart';

class AppointmentScreen extends StatelessWidget {
  AppointmentScreen({Key? key}) : super(key: key);

  // final TabController _tabController = TabController(vsync: this,length: 2);

  @override
  Widget build(BuildContext context) {
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
                  showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        height: 400,
                        //color: kWhite,
                        // decoration: BoxDecoration(
                        //   color: kBlack,
                        //   borderRadius:
                        //       BorderRadius.vertical(top: Radius.circular(30)),
                        // ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [],
                          ),
                        ),
                      );
                    },
                  );
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
              //indicatorSize: TabBarIndicatorSize.tab,
              unselectedLabelColor: Colors.grey,
              isScrollable: true,
              labelColor: Colors.black,
              labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              indicator: BoxDecoration(
                color: kBlue,
                borderRadius: BorderRadius.circular(10),
                //border: Border.all(),
              ),
              tabs: [
                Tab(
                  text: 'Upcoming',
                  height: 30,
                ),
                Tab(
                  text: 'Past',
                  height: 30,
                ),
              ]),
        ),
        body: TabBarView(
          //controller: _tabController,
          children: [
            AppointmentWidget(),
            AppointmentWidget(),
          ],
        ),
      ),
    );
  }
}
