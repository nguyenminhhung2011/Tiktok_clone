import 'package:flutter/material.dart';
import 'package:tiktok_clone/screens/login_password.dart';
import 'package:tiktok_clone/screens/signUp_screen.dart';
import 'package:tiktok_clone/utils/color.dart';

import '../widgets/button_desgin.dart';
import '../widgets/textField_desgin.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailControllelr = TextEditingController();
  final TextEditingController _passwordControllelr = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _emailControllelr.dispose();
    _passwordControllelr.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 2,
              child: Image(
                image: AssetImage(
                  'images/background2.png',
                ),
                fit: BoxFit.cover,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10, left: 10),
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.02),
                    offset: Offset(2, 2),
                  )
                ],
                image: DecorationImage(
                  image: AssetImage('images/tiktok.png'),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Hi!',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black26,
                        Colors.white10,
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      children: [
                        TextFieldDesgin(
                          hintText: 'Please enter your Email',
                          labelText: 'Email',
                          isPass: false,
                          textController: _emailControllelr,
                          icon: Icon(Icons.email),
                        ),
                        const SizedBox(height: 20),
                        ButtonDesign(
                          tittle: 'Continue',
                          press: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginPasswordScreen(
                                  email: _emailControllelr.text,
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'or',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                        const SizedBox(height: 10),
                        ButtonWithIcon(
                          color: Color.fromARGB(255, 164, 195, 221),
                          tittle: 'Continue with facebook',
                          press: () {},
                          icon: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 12),
                            child: Image(
                              image: AssetImage('images/facebook.png'),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        ButtonWithIcon(
                          color: Color.fromARGB(255, 164, 195, 221),
                          tittle: 'Continue with google',
                          press: () {},
                          icon: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 12),
                            child: Image(
                              image: AssetImage('images/google.png'),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        ButtonWithIcon(
                          color: Color.fromARGB(255, 164, 195, 221),
                          tittle: 'Continue with Apple',
                          press: () {},
                          icon: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 12),
                            child: Image(
                              image: AssetImage('images/apple.png'),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            const SizedBox(width: 40),
                            Text(
                              'Don\'t have an account? ',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SignUpScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                'register',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 136, 199, 250),
                                  fontSize: 15,
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(width: 40),
                            InkWell(
                              onTap: () {},
                              child: Text(
                                'Forgot your password',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: Color.fromARGB(255, 136, 199, 250),
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
