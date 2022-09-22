
import 'package:chatapp/pickers/user_picker_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Authform extends StatefulWidget {
  Authform(this.submitFn,this.isLoading);
  final bool isLoading;
  final void Function(String email, String password, String userName,
      bool isLogin, BuildContext ctx) submitFn;

  @override
  State<Authform> createState() => _AuthformState();
}

class _AuthformState extends State<Authform> {
  final _formKey = GlobalKey<FormState>();
  String _userPassword = '';
  String _userEmail = '';
  String _userName = '';
  var _isLogin = false;


  void _trySubmit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState!.save();
      widget.submitFn(_userEmail.trim(), _userPassword.trim(), _userName.trim(), _isLogin, context);
    }
  }
 _pickImage(){

  final image = ImagePicker().pickImage(source: ImageSource.camera);
  print(image);
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
                      if(!_isLogin)
                     const UserImagePicker(),

                      TextFormField(
                        key: const ValueKey('email'),
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
                      if (!_isLogin)
                        TextFormField(
                          key: const ValueKey('username'),
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
                        key: const ValueKey('password'),
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
                      if(widget.isLoading)
                      const CircularProgressIndicator(),
                      if(!widget.isLoading)
                      ElevatedButton(
                          onPressed: _trySubmit,
                          child: Text(_isLogin ? 'Login' : 'SignUp ')),
                          if(!widget.isLoading)
                      TextButton(
                          onPressed: () {
                            setState(() {
                              _isLogin = !_isLogin;
                            });
                          },
                          child: Text(_isLogin
                              ? 'Create New Account'
                              : 'I already have an Account'))
                    ],
                  ),
                )),
          )),
    );
  }
}
