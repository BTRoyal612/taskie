import 'package:taskie/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:taskie/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Create user obj based on FirebaseUser
  taskieUser? _userFromFirebaseUser (User? user) {
    return user != null ? taskieUser(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<taskieUser?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  // Sign in anonymously
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? firebaseUser = result.user;
      return _userFromFirebaseUser(firebaseUser);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  // Sign in with email & password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? firebaseUser = result.user;
      return _userFromFirebaseUser(firebaseUser);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  // Register with email & password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? firebaseUser = result.user;

      // Create a new document for the user with the uid
      await DatabaseService(uid: firebaseUser!.uid).updateUserData('new tasker', email);

      return _userFromFirebaseUser(firebaseUser);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  // Sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch(e) {
      print(e.toString());
      return null;
    }
  }
}