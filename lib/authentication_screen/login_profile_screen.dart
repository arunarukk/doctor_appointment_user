import 'dart:typed_data';

import 'package:cupertino_radio_choice/cupertino_radio_choice.dart';
import 'package:doctor_appointment/constant_value/constant_colors.dart';
import 'package:doctor_appointment/get_controller/get_controller.dart';
import 'package:doctor_appointment/models/patients_model.dart';
import 'package:doctor_appointment/resources/specialty_mathod.dart';
import 'package:doctor_appointment/resources/storage_methods.dart';
import 'package:doctor_appointment/user_screen/main_screen_home/main_home_screen.dart';
import 'package:doctor_appointment/user_screen/widget/doctor_list_widget/doctor_list_widget.dart';
import 'package:doctor_appointment/utils/utility_method.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class LoginProfileScreen extends StatefulWidget {
  const LoginProfileScreen({Key? key}) : super(key: key);

  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<LoginProfileScreen>
    with SingleTickerProviderStateMixin {
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
      debugPrint('no image $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style:  TextStyle(color: kBlack),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Column(
              children: [
         Container(
           height: 250.0,
          child: Column(
             children: <Widget>[
               Padding(
                 padding: const EdgeInsets.only(top: 20.0),
                 child: Stack(fit: StackFit.loose, children: <Widget>[
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
                                           image:
                                               MemoryImage(photo.image!),
                                           //NetworkImage(image!),
                                           fit: BoxFit.cover,
                                         )
                                       : const DecorationImage(
                                           image:  NetworkImage(
                                               'https://i.stack.imgur.com/l60Hf.png'),
                                           fit: BoxFit.cover,
                                         )));
                         },
                       ),
                     ],
                   ),
                   Padding(
                       padding:
                           const EdgeInsets.only(top: 160.0, right: 100.0),
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
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
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       mainAxisSize: MainAxisSize.max,
                       children: <Widget>[
                         Column(
                           mainAxisAlignment: MainAxisAlignment.start,
                           mainAxisSize: MainAxisSize.min,
                           children: const[
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
                           mainAxisAlignment: MainAxisAlignment.start,
                           mainAxisSize: MainAxisSize.min,
                           children: const[
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
                     padding: const EdgeInsets.only(
                         left: 25.0, right: 25.0, top: 25.0),
                     child: Row(
                       mainAxisSize: MainAxisSize.max,
                       children: <Widget>[
                         Column(
                           mainAxisAlignment: MainAxisAlignment.start,
                           mainAxisSize: MainAxisSize.min,
                           children:  const[
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
                     padding: const EdgeInsets.only(
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
                     padding: const EdgeInsets.only(
                         left: 25.0, right: 25.0, top: 25.0),
                     child: Row(
                       mainAxisSize: MainAxisSize.max,
                       children: <Widget>[
                         Column(
                           mainAxisAlignment: MainAxisAlignment.start,
                           mainAxisSize: MainAxisSize.min,
                           children: const[
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
                           child: TextField(
                             controller: mobileController,
                             decoration: const InputDecoration(
                                 hintText: "888888888"),
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
                       children:const[
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
                         left: 25.0, right: 25.0, top: 0.0),
                     child: Row(
                       mainAxisSize: MainAxisSize.max,
                       mainAxisAlignment: MainAxisAlignment.start,
                       children: <Widget>[
                         Flexible(
                           child: Padding(
                             padding: const EdgeInsets.only(right: 10.0),
                             child: TextField(
                               controller: ageController,
                              ),
                           ),
                           flex: 2,
                         ),
                         ],
                     )),
                 Padding(
                   padding: const EdgeInsets.only(
                     bottom: 5.0,
                     top: 14,
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
        ),
      ),
    );
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
      padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: ElevatedButton(
                child: const Text(
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
              String? token = await FirebaseMessaging.instance.getToken();
                 // print(currentUser.uid);
              String imageUrl = await StorageMethods().uploadImageToStorage(
                  'profilePics',
                  control.image!,
                  false,
                  FirebaseAuth.instance.currentUser!.uid);

              authC.addOtpSignUser(Patients(
                  userName: nameController.text,
                  uid: currentUser.uid,
                  photoUrl: imageUrl,
                  email: emailController.text,
                  phoneNumber: mobileController.text,
                  age: ageController.text,
                  gender: _selectedGender,
                  fcmToken: token!));

              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) =>const MainHomeScreen()),
                  (route) => false);

              setState(() {
                FocusScope.of(context).requestFocus(FocusNode());
              });
                },
              ),
            ),
            flex: 2,
          ),
         ],
      ),
    );
  }
}
