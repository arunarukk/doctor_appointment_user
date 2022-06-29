import 'dart:typed_data';

import 'package:cupertino_radio_choice/cupertino_radio_choice.dart';
import 'package:doctor_appointment/constant_value/constant_colors.dart';
import 'package:doctor_appointment/constant_value/constant_size.dart';
import 'package:doctor_appointment/get_controller/get_controller.dart';
import 'package:doctor_appointment/resources/data_controller.dart';
import 'package:doctor_appointment/utils/utility_method.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../resources/storage_methods.dart';

class AddMembers extends StatefulWidget {
  final String title;
  final data;
  final uid;

  const AddMembers({Key? key, required this.title, this.data, this.uid})
      : super(key: key);

  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<AddMembers>
    with SingleTickerProviderStateMixin {
  bool _status = true;
  final FocusNode myFocusNode = FocusNode();
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

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
    
      control.memiImage = im;
      control.update();
    } catch (e) {
      debugPrint('no image $e');
    }
   }

  @override
  Widget build(BuildContext context) {
    if (control.memiImage != null) {
      control.memiImage = null;
    }
    if (widget.data != null) {
      nameController.text = widget.data['userName'];
      ageController.text = widget.data['age'];
      phoneController.text = widget.data['phoneNumber'];
    }
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.title,
            style: const TextStyle(color: kBlack),
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
        body: SafeArea(
          child: Container(
            color: Colors.white,
            child: ListView(
              children: <Widget>[
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 250.0,
                        color: Colors.white,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child:
                                  Stack(fit: StackFit.loose, children: <Widget>[
                                GetBuilder<SignController>(
                                  init: SignController(),
                                  builder: (controller) {
                                    return Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        controller.memiImage == null
                                            ? Container(
                                                width: 140.0,
                                                height: 140.0,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    image: widget.data == null
                                                        ? const DecorationImage(
                                                            image: NetworkImage(
                                                                'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'),
                                                            fit: BoxFit.cover,
                                                          )
                                                        : DecorationImage(
                                                            image: NetworkImage(
                                                                widget.data[
                                                                    'photoUrl']),
                                                            fit: BoxFit.cover,
                                                          )))
                                            : Container(
                                                width: 140.0,
                                                height: 140.0,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                    image: MemoryImage(
                                                        control.memiImage!),
                                                    fit: BoxFit.cover,
                                                  ),
                                                )),
                                      ],
                                    );
                                  },
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(
                                        top: 90.0, right: 100.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        InkWell(
                                          onTap: () {
                                            selectImage();
                                          },
                                          child: CircleAvatar(
                                            backgroundColor: kBlue,
                                            radius: 25.0,
                                            child: const Icon(
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
                        color: const Color(0xffFFFFFF),
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 25.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                  padding: const EdgeInsets.only(
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
                                        children: const <Widget>[
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
                                  padding: const EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 25.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: const <Widget>[
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
                                  padding: const EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 2.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      Flexible(
                                        child: TextFormField(
                                          controller: nameController,
                                          decoration: const InputDecoration(
                                            hintText: "Enter Your Name",
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter name';
                                            }
                                            return null;
                                          },
                                         ),
                                      ),
                                    ],
                                  )),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 25.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: const <Widget>[
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
                                  padding: const EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 2.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      Flexible(
                                        child: TextFormField(
                                          controller: phoneController,
                                          decoration: const InputDecoration(
                                              hintText: "Enter Mobile Number"),
                                          //enabled: !_status,
                                          validator: (value) {
                                            String pattern =
                                                r'(^(?:[+0]9)?[0-9]{10}$)';
                                            RegExp regExp = RegExp(pattern);
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter phone number';
                                            } else if (!regExp
                                                .hasMatch(value)) {
                                              return 'Please enter valid phone number';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ],
                                  )),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 25.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: const[
                                      Expanded(
                                        child:  Text(
                                          'Age',
                                          style:  TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        flex: 2,
                                      ),
                                   ],
                                  )),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 2.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.only(right: 10.0),
                                          child: TextFormField(
                                            controller: ageController,
                                            decoration: const InputDecoration(
                                                hintText: "age"),
                                            //enabled: !_status,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please enter Age';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                        flex: 2,
                                      ),
                                    ],
                                  )),

                              kHeight10,
                              const Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 2.0),
                                child: Text('Select Gender',
                                    style: TextStyle(
                                      color: kBlack,
                                      fontSize: 16.0,
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 10.0),
                                child: CupertinoRadioChoice(
                                    choices: genderMap,
                                    onChange: onGenderSelected,
                                    initialKeyValue: _selectedGender),
                              ),
                              kHeight10,
                              kHeight20,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    child: SizedBox(
                                      height: 40,
                                      width: 120,
                                      child: Center(
                                        child: Text(
                                          widget.data == null
                                              ? "Add"
                                              : 'Update',
                                          style: const TextStyle(
                                            color: kWhite,
                                          ),
                                        ),
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      primary: kBlue,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0)),
                                    ),
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        if (widget.data == null) {
                                          if (control.memiImage == null) {
                                            showSnackBar('Image required!',
                                                kRed, context);
                                            return;
                                          }

                                          datacontrol.addMembers(
                                            userName: nameController.text,
                                            phoneNumber: phoneController.text,
                                            photoUrl: control.memiImage!,
                                            age: ageController.text,
                                            gender: _selectedGender,
                                            title: widget.title,
                                          );
                                          showSnackBar(
                                              'Member added successfully',
                                              kGreen,
                                              context);
                                          Navigator.pop(context);
                                        } else {
                                          String photoUrl =
                                              widget.data['photoUrl'];
                                          if (control.memiImage != null) {
                                            photoUrl = await StorageMethods()
                                                .uploadImageToStorage(
                                                    'memberProfile',
                                                    control.memiImage!,
                                                    false,
                                                    widget.uid);
                                          }
                                          datacontrol.updateMember(
                                              userName: nameController.text,
                                              phoneNumber: phoneController.text,
                                              photoUrl: photoUrl,
                                              age: ageController.text,
                                              gender: _selectedGender,
                                              title: widget.title,
                                              memId: widget.uid);
                                          showSnackBar('Updated Successfully',
                                              kGreen, context);
                                          Navigator.pop(context);
                                        }
                                      }
                                    },
                                  ),
                                  kWidth10,
                                  widget.data != null
                                      ? ElevatedButton(
                                          child: const SizedBox(
                                            height: 40,
                                            width: 120,
                                            child: Center(
                                              child: Text(
                                                "Delete",
                                                style: TextStyle(
                                                  color: kWhite,
                                                ),
                                              ),
                                            ),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            primary: kRed,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        20.0)),
                                          ),
                                          onPressed: () {
                                            datacontrol
                                                .deleteMember(widget.uid);
                                            Navigator.pop(context);
                                          },
                                        )
                                      : const SizedBox(),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
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

 
}
