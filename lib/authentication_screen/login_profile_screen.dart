import 'dart:typed_data';

import 'package:cupertino_radio_choice/cupertino_radio_choice.dart';
import 'package:doctor_appointment/constant_value/constant_colors.dart';
import 'package:doctor_appointment/get_controller/get_controller.dart';
import 'package:doctor_appointment/models/Patients_model.dart';
import 'package:doctor_appointment/resources/specialty_mathod.dart';
import 'package:doctor_appointment/resources/storage_methods.dart';
import 'package:doctor_appointment/user_screen/widget/doctor_list_widget/doctor_list_widget.dart';
import 'package:doctor_appointment/utils/utility_method.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class LoginProfileScreen extends StatefulWidget {
  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<LoginProfileScreen>
    with SingleTickerProviderStateMixin {
  bool _status = true;
  final FocusNode myFocusNode = FocusNode();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController aboutController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  final control = Get.put(SignController());

  static final Map<String, String> genderMap = {
    'male': 'Male',
    'female': 'Female',
    'other': 'Other',
  };

  String _selectedGender = genderMap.keys.first;

  String? image;
  selectImage() async {
    try {
      Uint8List im = await pickImage(ImageSource.gallery);
      control.imageUpdate(im);
      control.update(['photoNew']);
    } catch (e) {
      print('no image $e');
    }
    //_image = im;
    // setState(() {
    //   _image = im;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Profile',
            style: TextStyle(color: kBlack),
          ),
          centerTitle: true,
          elevation: 0,
          // leading: IconButton(
          //     onPressed: () {
          //       Navigator.pop(context);
          //     },
          //     icon: Icon(
          //       Icons.arrow_back,
          //       color: kBlack,
          //     )),
          automaticallyImplyLeading: false,
        ),
        body: SafeArea(
          child: Container(
            //color: Colors.white,
            child: GetBuilder<StateController>(builder: (controller) {
              // if (controller.user != null) {
              //   nameController.text = controller.user!.userName;
              //   emailController.text = controller.user!.email;
              //   mobileController.text = controller.user!.phoneNumber;
              //   ageController.text = controller.user!.age.toString();
              //   image = controller.user!.photoUrl;
              // }

              return ListView(
                children: [
                  Column(
                    children: [
                      Container(
                        height: 250.0,
                        //color: Colors.white,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 20.0),
                              child:
                                  Stack(fit: StackFit.loose, children: <Widget>[
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    GetBuilder<SignController>(
                                      init: SignController(),
                                      id: 'photoNew',
                                      builder: (photo) {
                                        return Container(
                                            width: 200.0,
                                            height: 200.0,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: photo.image != null
                                                    ? DecorationImage(
                                                        image: MemoryImage(
                                                            photo.image!),
                                                        //NetworkImage(image!),
                                                        fit: BoxFit.cover,
                                                      )
                                                    : DecorationImage(
                                                        image: NetworkImage(
                                                            'https://i.stack.imgur.com/l60Hf.png'),
                                                        fit: BoxFit.cover,
                                                      )));
                                      },
                                    ),
                                  ],
                                ),
                                Padding(
                                    padding: EdgeInsets.only(
                                        top: 160.0, right: 100.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            selectImage();
                                            // DataController().getMembers();
                                          },
                                          child: CircleAvatar(
                                            backgroundColor: kBlue,
                                            radius: 25.0,
                                            child: Icon(
                                              Icons.camera_alt,
                                              color: Colors.white,
                                            ),
                                          ),
                                        )
                                      ],
                                    )),
                              ]),
                            )
                          ],
                        ),
                      ),
                      Container(
                        color: Color(0xffFFFFFF),
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 25.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 25.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Text(
                                            'Parsonal Information',
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 25.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Text(
                                            'Name',
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 2.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      Flexible(
                                        child: TextField(
                                          controller: nameController,
                                          decoration: const InputDecoration(
                                            hintText: "Name",
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 25.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Text(
                                            'Email ID',
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 2.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      Flexible(
                                        child: TextField(
                                          controller: emailController,
                                          decoration: const InputDecoration(
                                              hintText: "aaaa@gmail.com"),
                                        ),
                                      ),
                                    ],
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 25.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Text(
                                            'Mobile',
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 2.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      Flexible(
                                        child: TextField(
                                          controller: mobileController,
                                          decoration: const InputDecoration(
                                              hintText: "888888888"),
                                        ),
                                      ),
                                    ],
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 25.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Expanded(
                                        child: Container(
                                          child: Text(
                                            'Age',
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        flex: 2,
                                      ),
                                      // Expanded(
                                      //   child: Container(
                                      //     child: Text(
                                      //       'State',
                                      //       style: TextStyle(
                                      //           fontSize: 16.0,
                                      //           fontWeight:
                                      //               FontWeight.bold),
                                      //     ),
                                      //   ),
                                      //   flex: 2,
                                      // ),
                                    ],
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 2.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Flexible(
                                        child: Padding(
                                          padding: EdgeInsets.only(right: 10.0),
                                          child: TextField(
                                            controller: ageController,
                                            // decoration: const InputDecoration(
                                            //     hintText: "555555"),
                                          ),
                                        ),
                                        flex: 2,
                                      ),
                                      // Flexible(
                                      //   child: TextField(
                                      //     // decoration: const InputDecoration(
                                      //     //     hintText: "kerala"),
                                      //
                                      //   ),
                                      //   flex: 2,
                                      // ),
                                    ],
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
                              _getActionButtons(),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              );
            }),
          ),
        ));
  }

  void onGenderSelected(String genderKey) {
    setState(() {
      _selectedGender = genderKey;
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }

  Widget _getActionButtons() {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Container(
                  child: ElevatedButton(
                child: Text(
                  "Save",
                  style: TextStyle(
                    color: kWhite,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                ),
                onPressed: () async {
                  print(currentUser.uid);
                  String imageUrl = await StorageMethods().uploadImageToStorage(
                      'profilePics', control.image!, false);

                  authC.addOtpSignUser(Patients(
                      userName: nameController.text,
                      uid: currentUser.uid,
                      photoUrl: imageUrl,
                      email: emailController.text,
                      phoneNumber: mobileController.text,
                      age: ageController.text,
                      gender: _selectedGender));

                  setState(() {
                    // _status = true;
                    FocusScope.of(context).requestFocus(FocusNode());
                  });
                },
              )),
            ),
            flex: 2,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Container(
                  child: ElevatedButton(
                child: Text(
                  "Cancel",
                  style: TextStyle(
                    color: kWhite,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                ),
                onPressed: () {
                  setState(() {
                    _status = true;
                    FocusScope.of(context).requestFocus(FocusNode());
                  });
                },
              )),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }

  Widget _getEditIcon() {
    return GestureDetector(
      child: CircleAvatar(
        backgroundColor: kBlue,
        radius: 14.0,
        child: Icon(
          Icons.edit,
          color: Colors.white,
          size: 16.0,
        ),
      ),
      onTap: () {
        setState(() {
          _status = false;
        });
      },
    );
  }
}
