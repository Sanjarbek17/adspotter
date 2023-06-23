// Auth provider
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  // firebase auth instance
  final FirebaseAuth _auth;

  AuthProvider(this._auth);

  // is login
  bool isLogin = false;

  // is login function
  Future<bool> isLoginFunction() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLogin = prefs.getBool('isLogin') ?? false;
    return isLogin;
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    // check if email exists in shared preferences

    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email.trim(), password: password.trim());
      print(result);
      User? user = result.user;
      isLogin = true;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      print('login');
      prefs.setBool('isLogin', isLogin);
      notifyListeners();
      return user;
    } catch (e) {
      print('errors');
      print(e);
      return null;
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword(String email, String password, String username) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email.trim(), password: password.trim());
      User? user = result.user;
      // update username
      await user!.updateDisplayName(username);
      return 'done';
    } catch (e) {
      return e;
    }
  }

  // sign out
  Future signOut() async {
    try {
      await _auth.signOut();
      isLogin = false;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('isLogin', isLogin);
    } catch (e) {
      // write code that something went wrong
    }
  }

  // getter current user
  User get currentUser {
    return _auth.currentUser!;
  }
}
