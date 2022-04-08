import 'package:cupertino_radio_choice/cupertino_radio_choice.dart';
import 'package:doctor_appointment/constant_value/constant_colors.dart';
import 'package:doctor_appointment/constant_value/constant_size.dart';
import 'package:doctor_appointment/user_screen/payment_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MakeAppoinment extends StatefulWidget {
  const MakeAppoinment({Key? key}) : super(key: key);

  @override
  State<MakeAppoinment> createState() => _MakeAppoinmentState();
}

class _MakeAppoinmentState extends State<MakeAppoinment> {
  DateTime? _selectedDate;

  String dropdownValue = 'Binil';

  static final Map<String, String> genderMap = {
    'male': 'Male',
    'female': 'Female',
    'other': 'Other',
  };

  String _selectedGender = genderMap.keys.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Make Appoinment',
          style: TextStyle(color: kBlack),
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: kBlack,
            )),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10),
          child: Column(
            children: [
              Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Select date :',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        TextButton.icon(
                          onPressed: () async {
                            final _selectedDateTemp = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now()
                                  .subtract(const Duration(days: 30)),
                              lastDate: DateTime.now(),
                            );
                            if (_selectedDateTemp == null) {
                              return;
                            } else {
                              //print(_selectedDateTemp.toString());
                              setState(() {
                                _selectedDate = _selectedDateTemp;
                              });
                            }
                          },
                          icon: Icon(
                            Icons.calendar_today,
                            color: kBlue,
                          ),
                          label: Text(
                            _selectedDate == null
                                ? DateFormat('dd/MM/yyyy')
                                    .format(DateTime.now())
                                : DateFormat('dd/MM/yyyy')
                                    .format(_selectedDate!)
                            // _selectedDate.toString(),
                            ,
                            style: TextStyle(color: kBlack),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Choose patient :',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        //kHeight10,
                        Container(
                          width: 100,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DropdownButton<String>(
                              value: dropdownValue,
                              icon: const Icon(
                                Icons.arrow_drop_down,
                              ),
                              //elevation: 16,
                              style: TextStyle(color: kBlue),
                              underline: Container(
                                height: 2,
                                width: 80,
                                color: kBlue,
                              ),
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownValue = newValue!;
                                });
                              },
                              items: <String>[
                                'Binil',
                                'Arunabh',
                                'Lukman',
                                'Shafeeq'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    kHeight10,
                    Text(
                      'Patient details',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    kHeight10,
                    Text('Full name',
                        style: TextStyle(
                          color: CupertinoColors.systemBlue,
                          fontSize: 15.0,
                        )),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 15.0,
                        right: 15,
                        top: 5,
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                          fillColor: Color.fromARGB(255, 236, 235, 229),
                          filled: true,
                          hintText: 'Full name',
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 5.0),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    kHeight10,
                    Text('Age',
                        style: TextStyle(
                          color: CupertinoColors.systemBlue,
                          fontSize: 15.0,
                        )),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 15.0,
                        right: 250,
                        top: 5,
                      ),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          fillColor: Color.fromARGB(255, 236, 235, 229),
                          filled: true,
                          hintText: 'Age',
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 5.0),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    kHeight10,
                    const Text('Select Gender',
                        style: TextStyle(
                          color: CupertinoColors.systemBlue,
                          fontSize: 15.0,
                        )),
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: 5.0,
                        top: 5,
                        left: 15,
                      ),
                      child: CupertinoRadioChoice(
                          choices: genderMap,
                          onChange: onGenderSelected,
                          initialKeyValue: _selectedGender),
                    ),
                    kHeight10,
                    const Text('Write your problem',
                        style: TextStyle(
                          color: CupertinoColors.systemBlue,
                          fontSize: 15.0,
                        )),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 15.0,
                        right: 15,
                        top: 5,
                      ),
                      child: TextFormField(
                        minLines: 6,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: const InputDecoration(
                          fillColor: Color.fromARGB(255, 236, 235, 229),
                          filled: true,
                          hintText: 'Discription',
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 5.0),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    kHeight30,
                    Center(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PaymentScreen()));
                        },
                        icon: Icon(Icons.payments_outlined),
                        label: Text('Make Payment'),
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 60, vertical: 10),
                            primary: kBlue,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onGenderSelected(String genderKey) {
    setState(() {
      _selectedGender = genderKey;
    });
  }
}
