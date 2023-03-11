// ignore_for_file: avoid_print

import 'dart:async';

import 'package:FarmIOT/backend/db.dart';
import 'package:FarmIOT/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  // initialize firebase auth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // customize user data that will be returned based on UserModel
  UserModel? _userFromFirebaseUser(User? user) {
    return user != null ? UserModel(uid: user.uid) : null;
  }

  // create a stream based on the user model data gotten above to monitor
  // auth state changes
  Stream<UserModel?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  // create account functionality
  Future createAccount(
      String email, String password, String firstName, String lastName) async {
    try {
      // store user credentails as it contains all user details
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      /// get current user from userCredential above
      User user = userCredential.user!;

      Database db = Database(uid: user.uid);

      // create user data in forestore
      db.addUserData(email, firstName, lastName);

      // create sensor data in firestore
      db.addSensorData();

      // instead of returning entire user credentials, return just the field
      // specified in UserModel accessed from this function
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // login functionality
  Future logIn(String email, String password) async {
    try {
      // store user credentails as it contains all user details
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      // get current user from userCredential above
      User user = userCredential.user!;

      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // logout functionality
  Future logout() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }

  // send password reset email functionality
  Future passwordReset(String email) async {
    try {
      // send password reset link
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // send email verification link
  Future verifyEmail() async {
    try {
      // get surrent user
      User currentUser = _auth.currentUser!;

      // send email verification link
      return await currentUser.sendEmailVerification();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // change password functionality
  Future changePassword(
      {String? email, String? oldPassword, String? newPassword}) async {
    // get surrent user
    User currentUser = _auth.currentUser!;

    /* 
    Get old user credential with email and old password
    This will be used to perform the re-authentication
    */
    final authCredential =
        EmailAuthProvider.credential(email: email!, password: oldPassword!);

    try {
      /* 
      Reauthenticate with current users email and password before updating
      their password and ensure you store the userCredentail details in a 
      variable 

      Anything that involves authentication or re-authentication, ensure you 
      store the result of the function handling either authentication or 
      reauthentication in a variable of type UserCredential
      */

      UserCredential userCredential =
          await currentUser.reauthenticateWithCredential(authCredential);

      // User reauthenticated successfully, change the password
      await currentUser.updatePassword(newPassword!);

      // get current user from user crentials
      User user = userCredential.user!;

      // return that user through the custom model
      return _userFromFirebaseUser(user);

      /*
      Note that, everything I did in this function is to prevent null from
      being returned
       */
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
