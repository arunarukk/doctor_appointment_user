import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_appointment/models/Patients_model.dart';
import 'package:doctor_appointment/resources/storage_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods {
  // final FirebaseAuth auth = FirebaseAuth.instanceFor(app: app);

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<Patients> getUserDetails() async {
    User currentUser = _auth.currentUser!;
    DocumentSnapshot snapshot =
        await _fireStore.collection('patients').doc(currentUser.uid).get();

    return Patients.fromSnapshot(snapshot);
  }

  //sign up Patient

  Future<String> signUpPatient({
    required String email,
    required String password,
    required String userName,
    required String phoneNumber,
    required Uint8List file,
  }) async {
    String result = 'Something went wrong';
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          userName.isNotEmpty ||
          phoneNumber.isNotEmpty) {
        // register Patients

        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        print(cred.user!.uid);

        String photoUrl = await StorageMethods()
            .uploadImageToStorage('profilePics', file, false);

        // add patients to database

        Patients patients = Patients(
            userName: userName,
            uid: cred.user!.uid,
            photoUrl: photoUrl,
            email: email,
            phoneNumber: phoneNumber,
            age: '');

        _fireStore
            .collection('patients')
            .doc(cred.user!.uid)
            .set(patients.toJson());
        result = 'Success';
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == 'invalid-email') {
        result = 'The email is badly formatted.';
      }
    } catch (err) {
      result = err.toString();
    }
    return result;
  }
  // logging in user

  Future<String> logInUser({
    required String email,
    required String password,
  }) async {
    String result = 'Something went wrong.';

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        result = 'Success';
      } else {
        result = 'please enter all the fields';
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == 'wrong-password') {
        result = 'Wrong password';
      } else if (err.code == 'user-not-found') {
        result = 'Wrong Email';
      }
    } catch (err) {
      result = err.toString();
    }
    return result;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
