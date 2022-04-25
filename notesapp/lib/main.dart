import 'package:flutter/material.dart';
import 'package:notesapp/app/auth/login.dart';
import 'package:notesapp/app/auth/signup.dart';
import 'package:notesapp/app/auth/success.dart';
import 'package:notesapp/app/home.dart';
import 'package:notesapp/app/notes/add.dart';
import 'package:notesapp/app/notes/edit.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences sharedPreferences;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
        backgroundColor:  Color(0xffFFCE00),
        centerTitle: true,
      )),
      debugShowCheckedModeBanner: false,
      title: "Note App",
      initialRoute:
          sharedPreferences.getString("id") == null ? "login" : "home",
      routes: {
        // ignore: prefer_const_constructors
        "login": (context) => Login(),
        "signup": (context) => SignUp(),
        "home": (context) => Home(),
        "success": (context) => Success(),
        "addnotes": (context) => AddNotes(),
        "editnotes": (context) => EditNotes(),
      },
    );
  }
}
