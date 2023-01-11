import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:strike_task/constants/global_context.dart';
import 'package:strike_task/providers/user_provider.dart';

import '../../controller/screen_controller.dart';
class AuthService{
  FirebaseAuth _auth;
  BuildContext context;
  AuthService(this._auth, this.context);
  FirebaseAuth getAuth(){
    return _auth;
  }
  Future<String?>signUp({required String name,required String email,required String password})async
  {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("The password provided is too weak.")));
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("The account already exists for that email.")));
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
      return "invalid";
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())));
      return "invalid";
    }

    return "valid";
  }
  Future<String?>signIn({required String email,required String password})async{
    try {
      final credential = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password
      );
    } on FirebaseAuthException catch (e) {
      debugPrint(e.toString());
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("email not found.")));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Wrong password.")));
      } else if(e.code=="invalid-email") {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("email address is badly formatted")));
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
      return "invalid";
    }catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
      return "invalid";
    }
    return "valid";
  }
  Future<void> signOut() async {
    await _auth.signOut();
  }
}