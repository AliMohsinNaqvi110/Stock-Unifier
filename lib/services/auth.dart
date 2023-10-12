import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:inventory_management/models/TheUser.dart';
import 'package:inventory_management/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj from firebase user
  TheUser? _userFromFirebaseUser(User user) {
    return User != null ? TheUser(user.uid) : null;
  }

  //Auth state change stream to listen for auth changes
  Stream<User?> get user {
    return _auth.authStateChanges();
  }
  //register
  Future register(
      String userName, String email, String password, String userRole) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      user!.updateDisplayName(userName);
      //create a new user with the uid
      await DatabaseService(user.uid).addUserData(
          userName: userName,
          email: email,
          password: password,
          userRole: userRole,
          distributorUid: null);
      // we create empty inventory to display in dashboard
      await DatabaseService(user.uid).createInventory();
      return _userFromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      var message = '';
      switch (e.code) {
        case 'email-already-in-use':
          message = "This email is already registered with another account";
          break;
        case "invalid-email":
          message = "You have entered an invalid email";
          break;
        case "operation-not-allowed":
          message =
          "There seems to be a problem signing up, please try again at a different time";
          break;
        case "weak-password":
          message = "This password is too weak";
          break;
      }
      return message;
    } catch (e) {
      log('''
    caught exception\n
    $e
  ''');
      rethrow;
    }
  }

  // //Create Vendor
  // Future registerVendor(String vendorName, String email, String password,
  //     String distributorUid, int balance, int dues) async {
  //   try {
  //     UserCredential result = await _auth.createUserWithEmailAndPassword(
  //         email: email, password: password);
  //     //create a new vendor with the distributor's uid
  //     await DatabaseService(distributorUid).createVendor(
  //         distributorUid: distributorUid,
  //         vendorName: vendorName,
  //         email: email,
  //         balance: balance,
  //         dues: dues);
  //     await DatabaseService(result.user!.uid).addUserData(
  //         userName: vendorName,
  //         email: email,
  //         password: password,
  //         userRole: "Vendor",
  //         distributorUid: distributorUid);
  //   } catch (e) {
  //     return null;
  //   }
  // }

  //sign in
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = authResult.user;
      return _userFromFirebaseUser(user!);
    } on FirebaseAuthException catch (e) {
      var message = '';
      switch (e.code) {
        case 'invalid-email':
          message = "You have entered an invalid email";
          break;
        case "user-disabled":
          message = "It appears your account has been disabled";
          break;
        case "user-not-found":
          message = "You don't have an account yet, sign-up first";
          break;
        case "wrong-password":
          message = "You have entered incorrect password";
          break;
      }
      return message;
    } catch (e) {
      log('''
    caught exception\n
    $e
  ''');
      rethrow;
    }
  }

  //sign out
  Future signOut() async {
    try {
      return _auth.signOut();
    } catch (e) {}
  }
}
