import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/controls/auth_controls.dart';
import 'package:tiktok_clone/screens/login_password.dart';
import 'package:tiktok_clone/screens/signUp_screen.dart';
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

class SignUpMain extends StatelessWidget {
  const SignUpMain({
    Key? key,
    required TextEditingController usernameController,
    required TextEditingController emailControllelrSU,
    required TextEditingController passwordControllelrSU,
    required TextEditingController bioControllelr,
  })  : _usernameController = usernameController,
        _emailControllelrSU = emailControllelrSU,
        _passwordControllelrSU = passwordControllelrSU,
        _bioControllelr = bioControllelr,
        super(key: key);

  final TextEditingController _usernameController;
  final TextEditingController _emailControllelrSU;
  final TextEditingController _passwordControllelrSU;
  final TextEditingController _bioControllelr;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 3,
                    color: Color.fromARGB(255, 94, 153, 201),
                  ),
                ),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    'https://images.unsplash.com/photo-1650859111563-2cfcfbbe586b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1974&q=80',
                  ),
                  radius: 45,
                )),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Select your avatar',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
                const SizedBox(height: 10),
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Color.fromARGB(255, 94, 153, 201),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.camera),
                        const SizedBox(width: 5),
                        Text('Pick Image'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),
        TextFieldDesgin(
          hintText: 'Please enter username',
          labelText: 'Username',
          isPass: false,
          textController: _usernameController,
          icon: Icon(Icons.person, color: Colors.grey),
        ),
        const SizedBox(height: 20),
        TextFieldDesgin(
          hintText: 'Please enter email',
          labelText: 'Email',
          isPass: false,
          textController: _emailControllelrSU,
          icon: Icon(Icons.email, color: Colors.grey),
        ),
        const SizedBox(height: 20),
        TextFieldDesgin(
          hintText: 'Please enter password',
          labelText: 'Password',
          isPass: true,
          textController: _passwordControllelrSU,
          icon: Icon(Icons.person, color: Colors.grey),
        ),
        const SizedBox(height: 20),
        TextFieldDesgin(
          hintText: 'Please enter bio',
          labelText: 'Bio',
          isPass: false,
          textController: _bioControllelr,
          icon: Icon(Icons.tiktok, color: Colors.grey),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'By selecting Agree and continue below',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: '',
                      style: TextStyle(fontSize: 15),
                      children: [
                        TextSpan(
                          text: 'I agree to ',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                        TextSpan(
                          text: 'Terms of Service and Privacy Policy',
                          style: TextStyle(
                            color: Color.fromARGB(255, 94, 153, 201),
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        ButtonDesign(
          press: () {},
          title: Text(
            'Continue',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        )
      ],
    );
  }
}

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
