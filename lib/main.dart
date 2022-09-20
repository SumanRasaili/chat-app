import 'package:chatapp/screens/authentication_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.pink,
            backgroundColor: Colors.pink,
            colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.pink),
                buttonTheme: ButtonTheme.of(context).copyWith( 
                  buttonColor: Colors.pink,
                  textTheme: ButtonTextTheme.primary,
                  shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20))
                )
                ),
        home: const AuthenticationScreen());
  }
}
