import 'package:chat_desk/screens/key_generated_screen.dart';
import 'package:chat_desk/widgets/login_register_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:random_password_generator/random_password_generator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final passwordGenerator = RandomPasswordGenerator();
FirebaseFirestore db = FirebaseFirestore.instance;

class GeneratingKey extends StatefulWidget {
  static String route = '/generating_key';
  const GeneratingKey({Key? key}) : super(key: key);

  @override
  State<GeneratingKey> createState() => _GeneratingKeyState();
}

class _GeneratingKeyState extends State<GeneratingKey> {
  late String newKey;
  bool generated = false;

  generateKey() async {
    newKey = passwordGenerator.randomPassword(
        letters: true, numbers: true, uppercase: true, passwordLength: 12);
    //if key already exists, generate another
    try {
      db.collection('keys').doc(newKey).get().then((value) async {
        if (value.exists) {
          setState(() {
            generated = false;
          });
          generateKey();
        } else {
          await Future.delayed(const Duration(seconds: 3), () {
            setState(() {
              generated = true;
            });
          });
        }
      });
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      generateKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!generated) {
      return SafeArea(
        child: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                "Generating Key...",
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
              SizedBox(height: 28),
              SpinKitFoldingCube(
                color: Colors.white,
                size: 60.0,
              ),
            ],
          ),
        ),
      );
    } else {
      return SafeArea(
        child: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Key Generated",
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
              const SizedBox(height: 28),
              LoginRegisterButton(
                  buttonText: "Next",
                  buttonColor: Colors.purple,
                  onClick: () {
                    Navigator.pushNamed(context, KeyGeneratedScreen.route,
                        arguments: {
                          'newKey': newKey,
                        });
                  }),
            ],
          ),
        ),
      );
    }
  }
}
