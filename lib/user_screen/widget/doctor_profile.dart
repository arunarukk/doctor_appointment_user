import 'package:doctor_appointment/constant_value/constant_colors.dart';
import 'package:doctor_appointment/constant_value/constant_size.dart';
import 'package:doctor_appointment/resources/data_controller.dart';
import 'package:doctor_appointment/user_screen/widget/Appoinment/make_appoinment.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class DoctorDetailScreen extends StatelessWidget {
  final data;
  const DoctorDetailScreen({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    datacontrol.getRatingAndReview(doctorID: data['uid']);
    final name = data['userName'];
    final uid = data['uid'];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(color: kBlack),
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: kBlack,
            )),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(15),
          width: 100.w,
          height: 100.h,
          child: Column(
            children: [
              Hero(
                tag: 'assets/log_illu/Doctor-color-800px.png',
                child: Material(
                  type: MaterialType.transparency,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Container(
                      alignment: Alignment.topCenter,
                      height: 45.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: kGrey,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            data['photoUrl'],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 14.h,
                      height: 7.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: kBlue, width: 1)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text('Experience',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                data['experience'],
                                style: const TextStyle(fontSize: 16),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              const Text(
                                'yr',
                                style: TextStyle(fontSize: 16),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    const VerticalDivider(
                      thickness: 1,
                      color: kGrey,
                    ),
                    GetBuilder<DataController>(
                      init: DataController(),
                      id: 'rating',
                      builder: (patient) {
                        return Container(
                          width: 14.h,
                          height: 7.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(color: kBlue, width: 1)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text('Patients',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    patient.totalPatient.toString(),
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  const Text(
                                    'Ps',
                                    style: TextStyle(fontSize: 16),
                                  )
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    ),
                    const VerticalDivider(
                      thickness: 1,
                      color: kGrey,
                    ),
                    GetBuilder<DataController>(
                      init: DataController(),
                      id: 'rating',
                      builder: (rating) {
                        if (rating.totalRating.isNaN) {}

                        return Container(
                          width: 13.h,
                          height: 7.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(color: kBlue, width: 1)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text('Rating',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    rating.totalRating.isNaN
                                        ? '0'
                                        : rating.totalRating.toStringAsFixed(1),
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Hero(
                    tag: const Text('Dr name'),
                    child: Material(
                      color: Colors.transparent,
                      child: Text(
                        'Dr ${name.toString().capitalize}',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: .8.h,
                  ),
                  data['qualifications'] == null
                      ? Container()
                      : Text(
                          data['qualifications'].toString().toUpperCase(),
                          style: const TextStyle(fontSize: 14),
                        ),
                  kHeight10,
                  data['speciality']['name'] == null
                      ? Container()
                      : Container(
                          height: 3.h,
                          width: 12.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(color: kRed, width: 1.2)),
                          child: Center(
                            child: Text(
                              data['speciality']['name']
                                  .toString()
                                  .toUpperCase(),
                              style: const TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                  data['address'] == null || data['address'] == ''
                      ? Container()
                      : SizedBox(
                          width: 100.w,
                          height: 6.5.h,
                          child: Row(
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                size: 40,
                                color: kGreen,
                              ),
                              Center(
                                child: SizedBox(
                                  width: 80.w,
                                  child: Text(
                                    data['address'].toString().toUpperCase(),
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 3,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                ],
              ),
              Text(data['about'],
                  overflow: TextOverflow.ellipsis,
                  maxLines: 5,
                  style: const TextStyle(fontSize: 13)),
              SizedBox(
                height: 2.h,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Center(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      MakeAppoinment(docId: uid)));
                        },
                        child: Container(
                          height: 6.h,
                          width: 100.w - 104,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color.fromARGB(255, 18, 67, 214),
                                Color.fromARGB(255, 35, 134, 247),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(50),
                            color: kBlue,
                          ),
                          child: Center(
                            child: Text(
                              'Make an Appointment',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                    color: kWhite,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
