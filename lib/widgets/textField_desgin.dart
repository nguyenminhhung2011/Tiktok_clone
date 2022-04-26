import 'package:flutter/material.dart';

class TextFieldDesgin extends StatelessWidget {
  final String hintText;
  final String labelText;
  final TextEditingController textController;
  final Widget icon;
  const TextFieldDesgin({
    Key? key,
    required this.hintText,
    required this.labelText,
    required this.textController,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: TextFormField(
        controller: textController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          fillColor: Colors.white,
          suffixIcon: icon,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 42,
            vertical: 2,
          ),
          hintText: hintText,
          labelText: labelText,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Color.fromARGB(255, 136, 199, 250),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
