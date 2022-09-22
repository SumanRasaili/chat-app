import 'dart:io';

import 'package:chatapp/widgets/auth/auth_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({Key? key}) : super(key: key);

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;

  void _submitAuthForm(String email, String password, String userName,
      bool isLogin, BuildContext ctx, File image) async {
    UserCredential authResult;

    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

//ref is the root bucket.here child is the folder and user_image is the path where imagae is stored adn the last is extension
      final ref =   FirebaseStorage.instance.ref().child('user_image').child(authResult.user!.uid+'.jpg');
     await ref.putFile(image);


        //we have did thsi to save our new created user to the new collection of user which is not present but we create
        //and we have taken the userid from the user created in authresult's uid and set the fields as uername and email
        await FirebaseFirestore.instance
            .collection('users')
            .doc(authResult.user!.uid)
            .set({'userName': userName, 'email': email, 'password': password});
      }




    } on PlatformException catch (err) {
      var message = 'An Error Occured!,Please Check your credentials!';
      if (err.message != null) {
        message = err.message!;
      }

      //  ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
      //   elevation: 0,
      //     content: Text(err.message!), backgroundColor: Theme.of(ctx).errorColor));
      setState(() {
        _isLoading = false;
      });
    } catch (err) {
      print(err);
      
      if(mounted){
      setState(() {
        _isLoading = false;
      });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Authform(
          _submitAuthForm,
          _isLoading,
        ));
  }
}
