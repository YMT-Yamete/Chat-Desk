import 'package:chat_desk/screens/add_image_screen.dart';
import 'package:chat_desk/screens/generating_key.dart';
import 'package:chat_desk/screens/key_generated_screen.dart';
import 'package:chat_desk/screens/login_screen.dart';
import 'package:chat_desk/screens/main_screen.dart';
import 'package:chat_desk/screens/important_note.dart';
import 'package:chat_desk/screens/start_screen.dart';
import 'package:chat_desk/screens/view_image_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

String? currentUserKey;
bool? isLoggedIn = false;

@override
void main() async {
  //initialized firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  //check if user is logged in or not
  await SharedPreferences.getInstance().then((value) {
    if (value.getString('key') != null) {
      isLoggedIn = true;
    }
  });

  //run app
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
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
        StartScreen.route: (context) => const StartScreen(),
        LoginScreen.route: (context) => const LoginScreen(),
        ImportantNote.route: (context) => const ImportantNote(),
        GeneratingKey.route: (context) => const GeneratingKey(),
        KeyGeneratedScreen.route: (context) => const KeyGeneratedScreen(),
        MainScreen.route: (context) => const MainScreen(),
        AddImageScreen.route: (context) => const AddImageScreen(),
        ViewImage.route: (context) => const ViewImage(),
      },
    );
  }
}
