import 'package:flutter/material.dart';

class Authform extends StatefulWidget {
  const Authform({Key? key}) : super(key: key);

  @override
  State<Authform> createState() => _AuthformState();
}

class _AuthformState extends State<Authform> {
  final _formKey = GlobalKey<FormState>();
  String _userPassword = '';
  String _userEmail = '';
  String _userName = '';
  void _trySubmit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState!.save();
      print(_userEmail);
      print(_userName);
      print(_userPassword);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
          margin: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    //that makes column to only take its height
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty || !value.contains('@')) {
                            return "Please enter the valid email address";
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) {
                          _userEmail = value!;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Email Address',
                        ),
                      ),
                      TextFormField(
                        onSaved: (value) {
                          _userName = value!;
                        },
                        validator: (value) {
                          if (value!.isEmpty || value.length < 4) {
                            return "Please enter at least 4 characters";
                          } else {
                            return null;
                          }
                        },
                        decoration: const InputDecoration(
                          labelText: 'Username',
                        ),
                      ),
                      TextFormField(
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty || value.length < 7) {
                            return "Password must be 7 characters long";
                          } else {
                            return null;
                          }
                        },
                        decoration: const InputDecoration(
                          labelText: 'Password',
                        ),
                        onSaved: (value) {
                          _userPassword = value!;
                        },
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      ElevatedButton(
                          onPressed: 
                            _trySubmit,
                          
                          child: const Text('Login')),
                      TextButton(
                          onPressed: () {},
                          child: const Text('Create New Account'))
                    ],
                  ),
                )),
          )),
    );
  }
}
