import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_appointment/constant_value/constant_colors.dart';
import 'package:doctor_appointment/resources/data_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final TextEditingController searchController = TextEditingController();

class SearchBar extends StatelessWidget {
  SearchBar({Key? key}) : super(key: key);

  QuerySnapshot? snapshot;

  @override
  Widget build(BuildContext context) {
    searchController.clear();

    return Padding(
        padding: const EdgeInsets.only(
          top: 10.0,
          bottom: 10,
          left: 35,
          right: 35,
        ),
        child: GetBuilder<DataController>(
          init: DataController(),
          builder: (dataControl) {
            return TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.search_outlined),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.0),
                  borderSide: BorderSide(color: kBlue),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.0),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
              ),
              onChanged: (newvalue) async {
                if (newvalue.isEmpty || newvalue == null) {
                  dataControl.querySelection(false);
                } else {
                  dataControl.querySelection(true);
                }
                dataControl.queryData(newvalue);
                dataControl.update(['search']);
              },
            );
          },
        ));
  }
}
