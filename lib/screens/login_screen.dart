import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/controls/auth_controls.dart';
import 'package:tiktok_clone/screens/signIn_main.dart';
import 'package:tiktok_clone/screens/signUp_main.dart';
import 'package:tiktok_clone/utils/color.dart';
import 'package:tiktok_clone/utils/untils.dart';

import '../controls/fireStore_methods.dart';
import '../widgets/button_desgin.dart';
import '../widgets/textField_desgin.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Sign In
  final TextEditingController _emailControllelr = TextEditingController();
  final TextEditingController _passwordControllelr = TextEditingController();

  // Sign In
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordControllelrSU = TextEditingController();
  final TextEditingController _emailControllelrSU = TextEditingController();
  final TextEditingController _bioControllelr = TextEditingController();

  bool isLoading = false;
  bool isCheckSign = true;
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Tik Tik',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        //fontFamily: "Muli",
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 0.2,
                        color: Colors.black.withOpacity(0.4),
                      ),
                    ),
                    Text(
                      'Via Socials Medias',
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.4),
                        fontSize: 20,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 0.2,
                        color: Colors.black.withOpacity(0.4),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                loginWithDiff(),
                const SizedBox(height: 20),
                checkSign(context),
                const SizedBox(height: 50),
                (isCheckSign)
                    ? SignInMain(
                        emailControllelr: _emailControllelr,
                        passwordControllelr: _passwordControllelr,
                      )
                    : SignUpMain(
                        usernameController: _usernameController,
                        emailControllelrSU: _emailControllelrSU,
                        passwordControllelrSU: _passwordControllelrSU,
                        bioControllelr: _bioControllelr),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row loginWithDiff() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              width: 1,
              color: Colors.black.withOpacity(0.1),
            ),
            color: Colors.white,
          ),
          child: Image(
            image: AssetImage('assets/images/facebook.png'),
            height: 30,
          ),
        ),
        const SizedBox(width: 10),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              width: 1,
              color: Colors.black.withOpacity(0.1),
            ),
            color: Colors.white,
          ),
          child: Image(
            image: AssetImage('assets/images/google.png'),
            height: 30,
          ),
        ),
        const SizedBox(width: 10),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              width: 1,
              color: Colors.black.withOpacity(0.1),
            ),
            color: Colors.white,
          ),
          child: Image(
            image: AssetImage('assets/images/apple.png'),
            height: 30,
          ),
        ),
      ],
    );
  }

  Container checkSign(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      height: 60,
      width: MediaQuery.of(context).size.width / 1,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: InkWell(
              borderRadius: BorderRadius.circular(30),
              onTap: () {
                setState(() {
                  if (isCheckSign == false) {
                    isCheckSign = true;
                  }
                });
              },
              child: Container(
                alignment: Alignment.center,
                height: 50,
                decoration: BoxDecoration(
                  color: isCheckSign ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  'Enter account',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              borderRadius: BorderRadius.circular(30),
              onTap: () {
                setState(() {
                  if (isCheckSign == true) {
                    isCheckSign = false;
                  }
                });
              },
              child: Container(
                alignment: Alignment.center,
                height: 50,
                decoration: BoxDecoration(
                  color: !isCheckSign ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  'Register account',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
