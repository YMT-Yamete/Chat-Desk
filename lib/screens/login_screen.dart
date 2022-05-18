import 'package:flutter/material.dart';
import '../widgets/login_register_button.dart';

class LoginScreen extends StatefulWidget {
  static String route = '/login';
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String bookKey;

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
                  print('login pressed');
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


// ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text("User not found."),
//           ),
//         );
