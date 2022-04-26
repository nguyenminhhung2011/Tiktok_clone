import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone/controls/auth_methods.dart';
import 'package:tiktok_clone/utils/untils.dart';

import '../widgets/button_desgin.dart';
import '../widgets/textField_desgin.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _emailControllelr = TextEditingController();
  final TextEditingController _passwordControllelr = TextEditingController();
  final TextEditingController _bioControllelr = TextEditingController();
  Uint8List? _image;
  bool isLoading = false;
  @override
  void dispose() {
    super.dispose();
    _userController.dispose();
    _emailControllelr.dispose();
    _passwordControllelr.dispose();
    _bioControllelr.dispose();
  }

  void selectedImage() async {
    Uint8List _file = await pickImage(ImageSource.gallery);
    setState(() {
      _image = _file;
    });
  }

  void SignUpUser() async {
    setState(() {
      isLoading = true;
    });
    String res = await AuthMethods().SignUp(
      username: _userController.text,
      email: _emailControllelr.text,
      password: _passwordControllelr.text,
      bio: _bioControllelr.text,
      image: _image!,
    );
    setState(() {
      isLoading = false;
    });
    //print(res);
    if (res != "Success") {
      showSnackBar(res.toString(), context);
    } else {}
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
                  'images/background3.png',
                ),
                fit: BoxFit.cover,
              ),
            ),
            Container(
              width: 50,
              height: 50,
              margin: const EdgeInsets.only(left: 10, top: 10),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Sign Up',
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
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Row(
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
                                child: (_image == null)
                                    ? CircleAvatar(
                                        backgroundImage: NetworkImage(
                                          'https://images.unsplash.com/photo-1650859111563-2cfcfbbe586b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1974&q=80',
                                        ),
                                        radius: 45,
                                      )
                                    : CircleAvatar(
                                        backgroundImage: MemoryImage(_image!),
                                        radius: 45,
                                      ),
                              ),
                              const SizedBox(width: 15),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Select your avatar',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  InkWell(
                                    onTap: () {
                                      selectedImage();
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color:
                                            Color.fromARGB(255, 94, 153, 201),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
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
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(width: 40),
                            Text(
                              'Please fill in the following information',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        TextFieldDesgin(
                          hintText: 'Please enter username',
                          labelText: 'Username',
                          isPass: false,
                          textController: _userController,
                          icon: Icon(Icons.person),
                        ),
                        const SizedBox(height: 20),
                        TextFieldDesgin(
                          hintText: 'Please enter email',
                          labelText: 'Email',
                          isPass: false,
                          textController: _emailControllelr,
                          icon: Icon(Icons.email),
                        ),
                        const SizedBox(height: 20),
                        TextFieldDesgin(
                          hintText: 'Please enter password',
                          labelText: 'Password',
                          isPass: true,
                          textController: _passwordControllelr,
                          icon: Icon(Icons.person),
                        ),
                        const SizedBox(height: 20),
                        TextFieldDesgin(
                          hintText: 'Please enter bio',
                          labelText: 'Bio',
                          isPass: false,
                          textController: _bioControllelr,
                          icon: Icon(Icons.tiktok),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
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
                                      fontSize: 15,
                                    ),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      text: '',
                                      style: TextStyle(fontSize: 15),
                                      children: [
                                        TextSpan(
                                          text: 'I agree to ',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        TextSpan(
                                          text:
                                              'Terms of Service and Privacy Policy',
                                          style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 94, 153, 201),
                                            fontWeight: FontWeight.bold,
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
                          title: (isLoading)
                              ? Center(
                                  child: CircularProgressIndicator(
                                      color: Colors.white))
                              : Text(
                                  'Agree and continue',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                  ),
                                ),
                          press: () {
                            SignUpUser();
                          },
                        ),
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
