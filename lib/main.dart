import 'package:chat_desk/screens/add_image_screen.dart';
import 'package:chat_desk/screens/generating_key.dart';
import 'package:chat_desk/screens/key_generated_screen.dart';
import 'package:chat_desk/screens/login_screen.dart';
import 'package:chat_desk/screens/main_screen.dart';
import 'package:chat_desk/screens/important_note.dart';
import 'package:chat_desk/screens/start_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

String? currentUserKey;
bool? isLoggedIn = false;

@override
void main() async {
  //initialized firebase
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseApp defaultApp = await Firebase.initializeApp();

  //check if user is logged in or not
  final prefs = await SharedPreferences.getInstance().then((value) {
    if (value.getString('key') != null) {
      isLoggedIn = true;
    }
  });

  //run app
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        floatingActionButtonTheme:
            const FloatingActionButtonThemeData(backgroundColor: Colors.purple),
      ),
      initialRoute: isLoggedIn == true ? MainScreen.route : StartScreen.route,
      routes: {
        StartScreen.route: (context) => StartScreen(),
        LoginScreen.route: (context) => LoginScreen(),
        ImportantNote.route: (context) => ImportantNote(),
        GeneratingKey.route: (context) => GeneratingKey(),
        KeyGeneratedScreen.route: (context) => KeyGeneratedScreen(),
        MainScreen.route: (context) => MainScreen(),
        AddImageScreen.route: (context) => AddImageScreen(),
      },
    );
  }
}
