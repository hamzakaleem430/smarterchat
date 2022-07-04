import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smarterchat/models/user.dart';
import 'package:image_picker/image_picker.dart';

enum LoginResponse {
  LogInSuccessful,
  IncorrectPassword,
  InvalidEmail,
  UserDisabled,
  UserNotFound,
  UnkownError,
  EmailNotVerified
}
enum SignUpResponse {
  SignUpSuccessful,
  EmailAlreadyInUse,
  InvalidEmail,
  OperationNotAllowed,
  WeakPassword,
  UnkownError
}
enum VerifyEmailResponse { SentEmailSuccessfully, UnkownError }
enum SignOutResponse { SignOutSuccessful, UnkownError }

class AuthServices {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  FirebaseStorage _storage = FirebaseStorage.instance;
  Future<AppUser> getUser(String id) async {
    return AppUser.fromJson(
        (await _firebaseFirestore.collection('users').doc(id).get()).data()!);
  }

  Future<LoginResponse> login(
      {required String email, required String password}) async {
    try {
      var user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (user.user!.emailVerified) {
        await fetchUserData();
        return LoginResponse.LogInSuccessful;
      } else {
        return LoginResponse.EmailNotVerified;
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "invalid-email":
          return LoginResponse.InvalidEmail;
        case "user-disabled":
          return LoginResponse.UserDisabled;
        case "user-not-found":
          return LoginResponse.UserNotFound;
        case "wrong-password":
          return LoginResponse.IncorrectPassword;
      }
    }
    return LoginResponse.UnkownError;
  }

  Future<SignUpResponse> signUp(
      {required String email,
      required String password,
      required String fullName}) async {
    try {
      Map<String, dynamic> _userData = {
        "email": email,
        "fullName": fullName,
        "profilePicUrl": null,
        "role": "user",
        "level": 0,
        "address": ''
      };
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((user) async {
        _userData['id'] = user.user!.uid;
        await _firebaseFirestore
            .collection('users')
            .doc(user.user!.uid)
            .set(_userData);
        _auth.currentUser!.sendEmailVerification().then((value) {
          _auth.signOut();
        });
      });
      return SignUpResponse.SignUpSuccessful;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "email-already-in-use":
          return SignUpResponse.EmailAlreadyInUse;
        case "invalid-email":
          return SignUpResponse.InvalidEmail;
        case "operation-not-allowed":
          return SignUpResponse.OperationNotAllowed;
        case "weak-password":
          return SignUpResponse.WeakPassword;
      }
    }
    return SignUpResponse.UnkownError;
  }

  isLoggedIn() {
    if (_auth.currentUser == null) {
      return false;
    } else if (!(_auth.currentUser!.emailVerified)) {
      _auth.signOut();
      return false;
    } else {
      return true;
    }
  }

  Future<VerifyEmailResponse> sendVerificationEmail() async {
    try {
      await _auth.currentUser!.sendEmailVerification();
      _auth.signOut();
      return VerifyEmailResponse.SentEmailSuccessfully;
    } catch (e) {
      return VerifyEmailResponse.UnkownError;
    }
  }

  Future<AppUser> fetchUserData() async {
    var doc = await _firebaseFirestore
        .collection("users")
        .doc(_auth.currentUser!.uid)
        .get();

    await SharedPreferences.getInstance().then((prefs) {
      prefs.setString('userData', jsonEncode(doc.data()));
    });
    return AppUser.fromJson(doc.data()!);
  }

  changeProfilePicture() {
    try {
      // ignore: invalid_use_of_visible_for_testing_member
      ImagePicker.platform.pickImage(source: ImageSource.gallery).then((value) {
        if (value != null)
          _storage
              .ref()
              .child(_auth.currentUser!.uid)
              .putFile(
                File(value.path),
              )
              .then((p0) async {
            await _firebaseFirestore
                .collection('users')
                .doc(_auth.currentUser!.uid)
                .update({'profilePicUrl': await p0.ref.getDownloadURL()});
          });
      });
    } catch (error) {
      Fluttertoast.showToast(msg: 'Unkown Error.Please Try Again Later.');
    }
  }

  updateUserData(Map<String, dynamic> data) async {
    try {
      await _firebaseFirestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .update(data);
    } catch (e) {
      Fluttertoast.showToast(msg: "Unkown Error. Please Try Again.");
    }
  }

  Future<AppUser> getCurrentUser() async {
    var prefs = await SharedPreferences.getInstance();
    String userData = prefs.getString('userData')!;
    print(userData);
    AppUser currentUser = AppUser.fromJson(jsonDecode(userData));
    return currentUser;
  }

  Future<SignOutResponse> signOut() async {
    try {
      _auth.signOut();
      return SignOutResponse.SignOutSuccessful;
    } catch (e) {
      return SignOutResponse.UnkownError;
    }
  }
}
