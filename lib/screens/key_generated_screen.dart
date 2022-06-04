import 'package:chat_desk/screens/start_screen.dart';
import 'package:chat_desk/widgets/login_register_button.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

class KeyGeneratedScreen extends StatefulWidget {
  static String route = '/key_generate_screen';
  const KeyGeneratedScreen({Key? key}) : super(key: key);

  @override
  State<KeyGeneratedScreen> createState() => _KeyGeneratedScreenState();
}

class _KeyGeneratedScreenState extends State<KeyGeneratedScreen> {
  storeKey(String newKey) {
    db.collection("keys").doc(newKey).set({});
  }
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    String newKey = args['newKey'];
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 15,
                ),
                child: Column(
                  children: [
                    const Text(
                      'Your Key is',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: const Color.fromARGB(255, 26, 26, 26),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 1.0), //(x,y)
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                      child: Text(
                        newKey,
                        style: const TextStyle(
                          fontSize: 40,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const SizedBox(height: 10),
                    const Text(
                      '1. Write down your key on a paper or text editor.',
                      style: TextStyle(
                        fontSize: 18,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      '2. Press "Done" if you have finished writing down.',
                      style: TextStyle(
                        fontSize: 18,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      '3. Your book will be created and you will be able to unlock using the key.',
                      style: TextStyle(
                        fontSize: 18,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 25),
                    LoginRegisterButton(
                      buttonText: 'Done',
                      buttonColor: Colors.purple,
                      onClick: () {
                        storeKey(newKey);
                        Navigator.pushNamed(context, StartScreen.route);
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
