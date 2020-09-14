import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<String> get onAuthStateChanged => _firebaseAuth.onAuthStateChanged.map(
        (FirebaseUser user) => user?.uid,
      );

  //AUTHENTICATOR: Sign Up

  Future<String> signUp(String email, String pass, String username) async {
    final authResult = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: pass,
    );

    await updateUserName(username, authResult.user);
    return authResult.user.uid;
  }

  Future updateUserName(String username, FirebaseUser currentUser) async {
    var userUpdateInfo = UserUpdateInfo();
    userUpdateInfo.displayName = username;
    await currentUser.updateProfile(userUpdateInfo);
    await currentUser.reload();
  }

  //AUTHENTICATOR: Sign In

  Future<String> signIn(String email, String pass) async {
    return (await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: pass,
    ))
        .user
        .uid;
  }

  //AUTHENTICATOR: Sign Out
  signOut(BuildContext context) async {
    await _firebaseAuth.signOut().then((_) => Navigator.pushNamedAndRemoveUntil(
        context, "/landing", ModalRoute.withName("/landhome")));
  }
}

//VALIDATOR: Username

class UserNameVal {
  static String validate(value) {
    if (value.length < 3) {
      return "Username atleast 3 characters";
    }
    if (value.contains(" ")) {
      return "Whitespace isn't allowed";
    }
    if (value.length > 10) {
      return "Username must be less than 12 characters";
    }
    return null;
  }
}

//VALIDATOR: Email

class EmailVal {
  static String validate(value) {
    if (value.isEmpty) {
      return "Please type your email";
    }
    return null;
  }
}

//VALIDATOR: Password

class PasswordVal {
  static String validate(value) {
    if (value.isEmpty) {
      return "Please type your password";
    }
    if (value.length < 5) {
      return "Password atleast 3 characters";
    }
    if (value.contains(" ")) {
      return "Whitespace isn't allowed";
    }
    if (value.length > 15) {
      return "Password must be less than 12 characters";
    }
    return null;
  }
}
