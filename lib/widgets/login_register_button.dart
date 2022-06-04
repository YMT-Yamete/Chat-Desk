import 'package:flutter/material.dart';

class LoginRegisterButton extends StatelessWidget {
  final String buttonText;
  final Color buttonColor;
  final Function onClick;
  const LoginRegisterButton({
    Key? key,
    required this.buttonText,
    required this.buttonColor,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: GestureDetector(
        onTap: () {
          onClick();
        },
        child: Container(
          width: 500,
          decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: const BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                buttonText,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
