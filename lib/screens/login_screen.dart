import 'package:chat_desk/screens/main_screen.dart';
import 'package:flutter/material.dart';
import '../widgets/login_register_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

class LoginScreen extends StatefulWidget {
  static String route = '/login';
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String bookKey;
  void login(String key) {
    db.collection('keys').doc(key).get().then((value) {
      if (value.exists) {
        Navigator.pushReplacementNamed(context, MainScreen.route);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Unlock Successful"),
          ),
        );
      }
      else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Incorrect Key."),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Hero(
                  tag: "logo",
                  child: Image.asset(
                    "assets/images/chat_desk_logo.png",
                    width: 120,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: SizedBox(
                  width: 500,
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        bookKey = value;
                      });
                    },
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      hintText: "Enter your key",
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.purple),
                      ),
                    ),
                  ),
                ),
              ),
              LoginRegisterButton(
                buttonText: 'Unlock',
                buttonColor: Colors.purple,
                onClick: () {
                  login(bookKey);
                },
              ),
              const SizedBox(height: 30),
              Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
              ),
            ],
          )),
    );
  }
}
