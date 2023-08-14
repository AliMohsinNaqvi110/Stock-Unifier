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

  // //Sign in Anonymously
  // Future signInAnon() async {
  //  try {
  //    dynamic authResult = await _auth.signInAnonymously();
  //    User user = authResult.user;
  //    return _userFromFirebaseUser(user);
  //  }
  //  catch(e) {
  //    return null;
  //  }
  // }

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
      await DatabaseService(user.uid).createInventory("", "", 0, 0);
      return _userFromFirebaseUser(user);
    } catch (e) {
      return Exception(e.toString());
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
    } catch (e) {
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try {
      return _auth.signOut();
    } catch (e) {}
  }
}
