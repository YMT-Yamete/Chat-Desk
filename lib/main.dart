import 'package:chat_desk/screens/generating_key.dart';
import 'package:chat_desk/screens/key_generated_screen.dart';
import 'package:chat_desk/screens/login_screen.dart';
import 'package:chat_desk/screens/main_screen.dart';
import 'package:chat_desk/screens/important_note.dart';
import 'package:chat_desk/screens/start_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseApp defaultApp = await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        floatingActionButtonTheme:
            const FloatingActionButtonThemeData(backgroundColor: Colors.purple),
      ),
      initialRoute: StartScreen.route,
      routes: {
        StartScreen.route: (context) => StartScreen(),
        LoginScreen.route: (context) => LoginScreen(),
        ImportantNote.route: (context) => ImportantNote(),
        GeneratingKey.route: (context) => GeneratingKey(),
        KeyGeneratedScreen.route: (context) => KeyGeneratedScreen(),
        MainScreen.route: (context) => MainScreen(),
      },
    );
  }
}
