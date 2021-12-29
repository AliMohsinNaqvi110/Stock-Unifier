import 'package:firebase_auth/firebase_auth.dart';
import 'package:inventory_management/models/TheUser.dart';
import 'package:inventory_management/services/database.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj from firebase user
  TheUser? _userFromFirebaseUser(User user) {

    return User!= null ? TheUser(user.uid) : null;
  }

  //Auth state change stream
  Stream<User?> get user {
    return _auth.authStateChanges();
  }


  //Sign in Anonymously
  Future signInAnon() async {
   try {
     dynamic authResult = await _auth.signInAnonymously();
     User user = authResult.user;
     return _userFromFirebaseUser(user);
   }
   catch(e) {
     return null;
   }
  }

  //register
  Future register(String email, String password) async {
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      //create a new user with the uid
      await DatabaseService(user!.uid).updateUserData("dummy email", "dummy password");
      return _userFromFirebaseUser(user);
    }
    catch(e) {
      return null;
    }
  }

  //sign in
  Future signInWithEmailAndPassword(String email, String password) async {
    try{
      UserCredential authResult = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = authResult.user;
      return _userFromFirebaseUser(user!);
    }
    catch(e) {
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try{
      return _auth.signOut();
    }
    catch(e) {
    }
  }
}