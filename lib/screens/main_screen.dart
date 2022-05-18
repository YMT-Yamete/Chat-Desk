import 'package:chat_desk/screens/start_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MainScreen extends StatelessWidget {
  static String route = 'main_screen';
  MainScreen({Key? key}) : super(key: key);

  final FirebaseAuth auth = FirebaseAuth.instance;
  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: _signOut,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        appBar: AppBar(
          title: const Text('My Photos'),
          centerTitle: true,
        ),
      ),
    );
  }
}
