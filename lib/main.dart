import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:infodisplay/input_form.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Firestore Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: InputForm(),
    );
  }
}