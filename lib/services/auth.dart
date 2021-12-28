import 'package:firebase_auth/firebase_auth.dart';
import 'package:inventory_management/models/TheUser.dart';

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
     print(user.uid);
     return _userFromFirebaseUser(user);
   }
   catch(e) {
     print(e.toString());
     return null;
   }
  }

  //sign out
  Future signOut() async {
    try{
      return _auth.signOut();
    }
    catch(e) {
      print(e.toString());
    }
  }


}