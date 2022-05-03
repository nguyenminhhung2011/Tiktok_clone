import 'package:flutter/material.dart';

import '../controls/auth_controls.dart';
import '../widgets/button_desgin.dart';
import '../widgets/textField_desgin.dart';

class SignInMain extends StatefulWidget {
  const SignInMain({
    Key? key,
    required TextEditingController emailControllelr,
    required TextEditingController passwordControllelr,
  })  : _emailControllelr = emailControllelr,
        _passwordControllelr = passwordControllelr,
        super(key: key);

  final TextEditingController _emailControllelr;
  final TextEditingController _passwordControllelr;

  @override
  State<SignInMain> createState() => _SignInMainState();
}

class _SignInMainState extends State<SignInMain> {
  bool isLoading = false;
  @override
  void SignIn() async {
    setState(() {
      isLoading = true;
    });
    String res = await AuthControls().LoginUser(
        widget._emailControllelr.text, widget._passwordControllelr.text);
    setState(() {
      isLoading = false;
    });
    if (res != "Success") {
    } else {}
  }

  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFieldDesgin(
          hintText: 'Please input Email',
          labelText: 'Email',
          isPass: false,
          textController: widget._emailControllelr,
          icon: Icon(
            Icons.email,
            color: Color.fromARGB(255, 250, 45, 108),
          ),
        ),
        const SizedBox(height: 25),
        TextFieldDesgin(
          hintText: 'Please input Password',
          labelText: 'Password',
          isPass: true,
          textController: widget._passwordControllelr,
          icon: Icon(Icons.email),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Don\'t have an account? ',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
            Text(
              'Sign Up',
              style: TextStyle(
                color: const Color.fromARGB(255, 32, 211, 234),
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Forgot your password',
              textAlign: TextAlign.start,
              style: TextStyle(
                color: const Color.fromARGB(255, 32, 211, 234),
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.height / 3.5),
        ButtonDesign(
          press: () {
            SignIn();
          },
          title: (!isLoading)
              ? Text(
                  'Continue',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
        ),
      ],
    );
  }
}
