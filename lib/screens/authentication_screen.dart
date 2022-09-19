import 'package:chatapp/widgets/auth/auth_form.dart';
import 'package:flutter/material.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({ Key? key }) : super(key: key);

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  void _submitAuthForm(String email,String password,String userName,bool isLogin){

    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Authform(_submitAuthForm)
      
    );
  }
}
