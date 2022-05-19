import 'package:chat_desk/screens/generating_key.dart';
import 'package:flutter/material.dart';
import '../widgets/login_register_button.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ImportantNote extends StatefulWidget {
  static String route = "/important_note";
  ImportantNote({Key? key}) : super(key: key);

  @override
  State<ImportantNote> createState() => _ImportantNoteState();
}

class _ImportantNoteState extends State<ImportantNote> {
  bool checkedValue = false;

  // Alert with single button.
  _onAlertButtonPressed(context) {
    Alert(
      context: context,
      type: AlertType.warning,
      title: "WARNING",
      desc: "Please read the important note first.",
      style: const AlertStyle(
        titleStyle: TextStyle(color: Colors.white),
        descStyle: TextStyle(color: Colors.white),
      ),
      buttons: [
        DialogButton(
            child: const Text(
              "OK",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            width: 120,
            color: Colors.purple),
      ],
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 15,
                ),
                child: Column(
                  children: const [
                    Text(
                      'IMPORTANT',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      '1. In the next page, new secret key will be generated for you.',
                      style: TextStyle(
                        fontSize: 18,
                        letterSpacing: 1,
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      '2. You can unlock your book by using that key.',
                      style: TextStyle(
                        fontSize: 18,
                        letterSpacing: 1,
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      '3. It is IMPORTANT to write down the key once you receive it.',
                      style: TextStyle(
                        fontSize: 18,
                        letterSpacing: 1,
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      '4. If you lose your key, even we can\'t help you recover it.',
                      style: TextStyle(
                        fontSize: 18,
                        letterSpacing: 1,
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      '5. Never share your key with anyone unless you are willing to share your book.',
                      style: TextStyle(
                        fontSize: 18,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CheckboxListTile(
                    title: const Text("I have read the note above."),
                    value: checkedValue,
                    activeColor: Colors.purple,
                    onChanged: (newValue) {
                      setState(() {
                        checkedValue = newValue!;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                  LoginRegisterButton(
                    buttonText: 'Next',
                    buttonColor: Colors.purple,
                    onClick: () {
                      if (checkedValue) {
                        Navigator.pushNamed(context, GeneratingKey.route);
                      } else {
                        _onAlertButtonPressed(context);
                      }
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
