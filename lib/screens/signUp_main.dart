import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone/controls/auth_controls.dart';
import 'package:tiktok_clone/utils/untils.dart';

import '../widgets/button_desgin.dart';
import '../widgets/textField_desgin.dart';

class SignUpMain extends StatefulWidget {
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
  State<SignUpMain> createState() => _SignUpMainState();
}

class _SignUpMainState extends State<SignUpMain> {
  bool isLoading = false;
  Uint8List? _image;
  @override
  void selectedImage() async {
    Uint8List file = await pickImage(ImageSource.gallery);
    setState(() {
      _image = file;
    });
  }

  void signUpUser() async {
    setState(() {
      isLoading = true;
    });
    String res = await AuthControls().SignUp(
        username: widget._usernameController.text,
        email: widget._emailControllelrSU.text,
        password: widget._passwordControllelrSU.text,
        bio: widget._bioControllelr.text,
        image: _image!);

    setState(() {
      isLoading = false;
    });
    if (res == 'Success') {
    } else {
      Get.snackbar(
        'Error Sign Up',
        res,
        backgroundColor: const Color.fromARGB(255, 136, 199, 250),
      );
    }
  }

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
                  color: const Color.fromARGB(255, 94, 153, 201),
                ),
              ),
              child: (_image == null)
                  ? const CircleAvatar(
                      backgroundImage: NetworkImage(
                        'https://images.unsplash.com/photo-1650859111563-2cfcfbbe586b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1974&q=80',
                      ),
                      radius: 45,
                    )
                  : CircleAvatar(
                      radius: 45,
                      backgroundImage: MemoryImage(_image!),
                    ),
            ),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Select your avatar',
                  style: TextStyle(
                    color: Colors.black,
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: const Color.fromARGB(255, 94, 153, 201),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Icon(Icons.camera),
                        SizedBox(width: 5),
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
          textController: widget._usernameController,
          icon: const Icon(Icons.person, color: Colors.grey),
        ),
        const SizedBox(height: 20),
        TextFieldDesgin(
          hintText: 'Please enter email',
          labelText: 'Email',
          isPass: false,
          textController: widget._emailControllelrSU,
          icon: const Icon(Icons.email, color: Colors.grey),
        ),
        const SizedBox(height: 20),
        TextFieldDesgin(
          hintText: 'Please enter password',
          labelText: 'Password',
          isPass: true,
          textController: widget._passwordControllelrSU,
          icon: const Icon(Icons.person, color: Colors.grey),
        ),
        const SizedBox(height: 20),
        TextFieldDesgin(
          hintText: 'Please enter bio',
          labelText: 'Bio',
          isPass: false,
          textController: widget._bioControllelr,
          icon: const Icon(Icons.tiktok, color: Colors.grey),
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
                  const Text(
                    'By selecting Agree and continue below',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  RichText(
                    text: const TextSpan(
                      text: '',
                      style: TextStyle(fontSize: 15),
                      children: [
                        TextSpan(
                          text: 'I agree to ',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        TextSpan(
                          text: 'Terms of Service and Privacy Policy',
                          style: TextStyle(
                            color: Color.fromARGB(255, 94, 153, 201),
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
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
          press: () {
            signUpUser();
          },
          title: (!isLoading)
              ? const Text(
                  'Continue',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
        )
      ],
    );
  }
}
