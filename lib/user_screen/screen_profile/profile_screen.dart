import 'dart:typed_data';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:cupertino_radio_choice/cupertino_radio_choice.dart';
import 'package:doctor_appointment/constant_value/constant_colors.dart';
import 'package:doctor_appointment/get_controller/get_controller.dart';
import 'package:doctor_appointment/models/Patients_model.dart';
import 'package:doctor_appointment/resources/auth_method.dart';
import 'package:doctor_appointment/resources/storage_methods.dart';
import 'package:doctor_appointment/user_screen/skeleton_screens/skeleton_profile.dart';
import 'package:doctor_appointment/user_screen/widget/doctor_list_widget/doctor_list_widget.dart';
import 'package:doctor_appointment/utils/utility_method.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../widget/connection_lost.dart';

class ProfileScreen extends StatefulWidget {
  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  bool _status = true;
  final FocusNode myFocusNode = FocusNode();

  final _formKey = GlobalKey<FormState>();

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

  //String _selectedGender = genderMap.keys.first;

  String? image;
  selectImage() async {
    try {
      Uint8List im = await pickImage(ImageSource.gallery);
      control.imageUpdate(im);
      control.update(['photo']);
    } catch (e) {
      print('no image $e');
    }
    //_image = im;
    // setState(() {
    //   _image = im;
    // });
  }

  @override
  void initState() {
    statecontrol.refreshUser();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.height;
    AuthMethods().getUserDetails();
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
          child: StreamBuilder(
              stream: Connectivity().onConnectivityChanged,
              builder: (context, AsyncSnapshot<ConnectivityResult> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting ||
                    snapshot.hasData &&
                        snapshot.data != ConnectivityResult.none) {
                  return Container(
                    //color: Colors.white,
                    child: GetBuilder<StateController>(
                        id: 'profile',
                        builder: (controller) {
                          // if (controller.user == null) {
                          //   return Center(
                          //     child: Text('Something went wrong'),
                          //   );
                          // }
                          // if (controller.user != null) {
                          //   nameController.text = controller.user!.userName;
                          //   emailController.text = controller.user!.email;
                          //   mobileController.text =
                          //       controller.user!.phoneNumber;
                          //   ageController.text =
                          //       controller.user!.age.toString();
                          //   image = controller.user!.photoUrl;
                          // }

                          return StreamBuilder<Patients>(
                              stream: controller.getUserProfileDetails(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return SkeletonProfile();
                                }
                                if (snapshot.data == null) {
                                  return Center(
                                    child: Text('Something went wrong'),
                                  );
                                }

                                if (snapshot.data != null) {
                                  nameController.text = snapshot.data!.userName;
                                  emailController.text = snapshot.data!.email;
                                  mobileController.text =
                                      snapshot.data!.phoneNumber;
                                  ageController.text =
                                      snapshot.data!.age.toString();
                                  image = snapshot.data!.photoUrl;
                                  statecontrol.selectedGender =
                                      snapshot.data!.gender;
                                  print('gen${statecontrol.selectedGender}');
                                }
                                return ListView(
                                  children: [
                                    Form(
                                      key: _formKey,
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 250.0,
                                            //color: Colors.white,
                                            child: Column(
                                              children: <Widget>[
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 20.0),
                                                  child: Stack(
                                                      fit: StackFit.loose,
                                                      children: <Widget>[
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: <Widget>[
                                                            GetBuilder<
                                                                SignController>(
                                                              init:
                                                                  SignController(),
                                                              id: 'photo',
                                                              builder: (photo) {
                                                                return Container(
                                                                    width:
                                                                        200.0,
                                                                    height:
                                                                        200.0,
                                                                    decoration: BoxDecoration(
                                                                        shape: BoxShape.circle,
                                                                        image: photo.image != null
                                                                            ? DecorationImage(
                                                                                image: MemoryImage(photo.image!),
                                                                                //NetworkImage(image!),
                                                                                fit: BoxFit.cover,
                                                                              )
                                                                            : DecorationImage(
                                                                                image: NetworkImage(image ?? 'https://i.stack.imgur.com/l60Hf.png'),
                                                                                fit: BoxFit.cover,
                                                                              )));
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                        Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 160.0,
                                                                    right:
                                                                        100.0),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                InkWell(
                                                                  onTap: () {
                                                                    if (!_status) {
                                                                      selectImage();
                                                                    }

                                                                    //DataController().getMembers();
                                                                  },
                                                                  child:
                                                                      CircleAvatar(
                                                                    backgroundColor:
                                                                        kBlue,
                                                                    radius:
                                                                        25.0,
                                                                    child: Icon(
                                                                      Icons
                                                                          .camera_alt,
                                                                      color: Colors
                                                                          .white,
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
                                              padding:
                                                  EdgeInsets.only(bottom: 25.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: <Widget>[
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 25.0,
                                                          right: 25.0,
                                                          top: 25.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: <Widget>[
                                                          Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: <Widget>[
                                                              Text(
                                                                'Parsonal Information',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        18.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ],
                                                          ),
                                                          Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: <Widget>[
                                                              _status
                                                                  ? _getEditIcon()
                                                                  : Container(),
                                                            ],
                                                          )
                                                        ],
                                                      )),
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 25.0,
                                                          right: 25.0,
                                                          top: 25.0),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: <Widget>[
                                                          Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: <Widget>[
                                                              Text(
                                                                'Name',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        16.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      )),
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 25.0,
                                                          right: 25.0,
                                                          top: 2.0),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: <Widget>[
                                                          Flexible(
                                                            child:
                                                                TextFormField(
                                                              controller:
                                                                  nameController,
                                                              decoration:
                                                                  const InputDecoration(
                                                                hintText:
                                                                    "Name",
                                                              ),
                                                              enabled: !_status,
                                                              autofocus:
                                                                  !_status,
                                                              validator:
                                                                  (value) {
                                                                if (value ==
                                                                        null ||
                                                                    value
                                                                        .isEmpty) {
                                                                  return 'Please enter name';
                                                                }
                                                                return null;
                                                              },
                                                            ),
                                                          ),
                                                        ],
                                                      )),
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 25.0,
                                                          right: 25.0,
                                                          top: 25.0),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: <Widget>[
                                                          Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: <Widget>[
                                                              Text(
                                                                'Email ID',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        16.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      )),
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 25.0,
                                                          right: 25.0,
                                                          top: 2.0),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: <Widget>[
                                                          Flexible(
                                                            child:
                                                                TextFormField(
                                                              controller:
                                                                  emailController,
                                                              decoration:
                                                                  const InputDecoration(
                                                                      hintText:
                                                                          "aaaa@gmail.com"),
                                                              enabled: !_status,
                                                              validator:
                                                                  (value) {
                                                                if (value ==
                                                                        null ||
                                                                    value
                                                                        .isEmpty) {
                                                                  return 'Please enter E-mail';
                                                                } else if (!value
                                                                        .contains(
                                                                            '@') ||
                                                                    !value.endsWith(
                                                                        '.com')) {
                                                                  return 'Please enter a valid E-mail';
                                                                }
                                                                return null;
                                                              },
                                                            ),
                                                          ),
                                                        ],
                                                      )),
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 25.0,
                                                          right: 25.0,
                                                          top: 25.0),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: <Widget>[
                                                          Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: <Widget>[
                                                              Text(
                                                                'Mobile',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        16.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      )),
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 25.0,
                                                          right: 25.0,
                                                          top: 2.0),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: <Widget>[
                                                          Flexible(
                                                            child:
                                                                TextFormField(
                                                              controller:
                                                                  mobileController,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              decoration:
                                                                  const InputDecoration(
                                                                      hintText:
                                                                          "888888888"),
                                                              enabled: !_status,
                                                              validator:
                                                                  (value) {
                                                                String pattern =
                                                                    r'(^(?:[+0]9)?[0-9]{10}$)';
                                                                RegExp regExp =
                                                                    RegExp(
                                                                        pattern);
                                                                if (value ==
                                                                        null ||
                                                                    value
                                                                        .isEmpty) {
                                                                  return 'Please enter phone number';
                                                                } else if (!regExp
                                                                    .hasMatch(
                                                                        value)) {
                                                                  return 'Please enter valid phone number';
                                                                }
                                                                return null;
                                                              },
                                                            ),
                                                          ),
                                                        ],
                                                      )),
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 25.0,
                                                          right: 25.0,
                                                          top: 25.0),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          Expanded(
                                                            child: Container(
                                                              child: Text(
                                                                'Age',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        16.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
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
                                                          left: 25.0,
                                                          right: 25.0,
                                                          top: 2.0),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          Flexible(
                                                            child: Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      right:
                                                                          10.0),
                                                              child:
                                                                  TextFormField(
                                                                controller:
                                                                    ageController,
                                                                keyboardType:
                                                                    TextInputType
                                                                        .number,
                                                                // decoration: const InputDecoration(
                                                                //     hintText: "555555"),
                                                                enabled:
                                                                    !_status,
                                                                validator:
                                                                    (value) {
                                                                  if (value ==
                                                                          null ||
                                                                      value
                                                                          .isEmpty) {
                                                                    return 'Please enter Age';
                                                                  }
                                                                  return null;
                                                                },
                                                              ),
                                                            ),
                                                            flex: 2,
                                                          ),
                                                          // Flexible(
                                                          //   child: TextFormField(
                                                          //     // decoration: const InputDecoration(
                                                          //     //     hintText: "kerala"),
                                                          //     enabled: !_status,
                                                          //   ),
                                                          //   flex: 2,
                                                          // ),
                                                        ],
                                                      )),
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 25.0,
                                                          right: 25.0,
                                                          top: 25.0),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          Expanded(
                                                            child: Container(
                                                              child: Text(
                                                                'Gender',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        16.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ),
                                                            flex: 2,
                                                          ),
                                                        ],
                                                      )),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 25.0,
                                                        right: 25.0,
                                                        top: 25.0),
                                                    child: GetBuilder<
                                                        StateController>(
                                                      init: StateController(),
                                                      id: 'gender',
                                                      builder: (gender) {
                                                        return CupertinoRadioChoice(
                                                            choices: genderMap,
                                                            onChange: gender
                                                                .onGenderSelected,
                                                            initialKeyValue: gender
                                                                .selectedGender);
                                                      },
                                                    ),
                                                  ),
                                                  // Padding(
                                                  //     padding: EdgeInsets.only(
                                                  //         left: 25.0, right: 25.0, top: 25.0),
                                                  //     child: Row(
                                                  //       mainAxisSize: MainAxisSize.max,
                                                  //       children: <Widget>[
                                                  //         Column(
                                                  //           mainAxisAlignment:
                                                  //               MainAxisAlignment.start,
                                                  //           mainAxisSize: MainAxisSize.min,
                                                  //           children: <Widget>[
                                                  //             Text(
                                                  //               'About',
                                                  //               style: TextStyle(
                                                  //                   fontSize: 16.0,
                                                  //                   fontWeight:
                                                  //                       FontWeight.bold),
                                                  //             ),
                                                  //           ],
                                                  //         ),
                                                  //       ],
                                                  //     )),
                                                  // Padding(
                                                  //     padding: EdgeInsets.only(
                                                  //         left: 25.0, right: 25.0, top: 2.0),
                                                  //     child: Row(
                                                  //       mainAxisSize: MainAxisSize.max,
                                                  //       children: <Widget>[
                                                  //         Flexible(
                                                  //           child: TextFormField(
                                                  //             controller: aboutController,
                                                  //             maxLines: 3,
                                                  //             // decoration: const InputDecoration(

                                                  //             //         ),
                                                  //             enabled: !_status,
                                                  //           ),
                                                  //         ),
                                                  //       ],
                                                  // )),
                                                  !_status
                                                      ? _getActionButtons()
                                                      : Container(),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              });
                        }),
                  );
                } else {
                  return ConnectionLost();
                }
              }),
        ));
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
                  if (_formKey.currentState!.validate()) {
                    String imageUrl;
                    if (control.image != null) {
                      imageUrl = await StorageMethods().uploadImageToStorage(
                          'profilePics',
                          control.image!,
                          false,
                          FirebaseAuth.instance.currentUser!.uid);
                    } else {
                      imageUrl = image!;
                    }
                    // print(image.toString());
                    authC.updateUser(
                        age: ageController.text,
                        email: emailController.text,
                        phoneNumber: mobileController.text,
                        userName: nameController.text,
                        photoUrl: imageUrl,
                        gender: statecontrol.selectedGender);

                    setState(() {
                      _status = true;
                      FocusScope.of(context).requestFocus(FocusNode());
                    });
                  }
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
