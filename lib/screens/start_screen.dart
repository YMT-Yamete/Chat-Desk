import 'package:chat_desk/screens/login_screen.dart';
import 'package:chat_desk/screens/important_note.dart';
import 'package:flutter/material.dart';
import 'package:flutter_responsive/flutter_responsive.dart';
import '../widgets/animated_title.dart';
import '../widgets/login_register_button.dart';

class StartScreen extends StatelessWidget {
  static String route = "/";
  const StartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(150),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xffA77BCA),
                      offset: Offset(0.0, 1.0), //(x,y)
                      blurRadius: 1.0,
                    ),
                  ],
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 150, 0, 0),
                    child: ResponsiveRow(
                      alignment: const Alignment(0, 0),
                      children: [
                        Hero(
                          tag: "logo",
                          child: Image.asset(
                            "assets/images/chat_desk_logo.png",
                            width: 80,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const AnimatedTitle(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  const SizedBox(height: 100),
                  LoginRegisterButton(
                      buttonText: 'Unlock',
                      buttonColor: Colors.purple,
                      onClick: () {
                        Navigator.pushNamed(context, LoginScreen.route);
                      }),
                  const SizedBox(height: 10),
                  LoginRegisterButton(
                      buttonText: 'Generate new key',
                      buttonColor: Colors.purple,
                      onClick: () {
                        Navigator.pushNamed(context, ImportantNote.route);
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
