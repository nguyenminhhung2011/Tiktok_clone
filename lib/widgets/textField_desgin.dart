import 'package:flutter/material.dart';

class TextFieldDesgin extends StatefulWidget {
  final String hintText;
  final String labelText;
  final TextEditingController textController;
  final Widget icon;
  final bool isPass;
  const TextFieldDesgin({
    Key? key,
    required this.hintText,
    required this.labelText,
    required this.isPass,
    required this.textController,
    required this.icon,
  }) : super(key: key);

  @override
  State<TextFieldDesgin> createState() => _TextFieldDesginState();
}

class _TextFieldDesginState extends State<TextFieldDesgin> {
  bool isLook = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: TextFormField(
        controller: widget.textController,
        keyboardType: TextInputType.emailAddress,
        obscureText: (widget.isPass) ? isLook : false,
        decoration: InputDecoration(
          fillColor: Colors.white,
          suffixIcon: (widget.isPass)
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      isLook = !isLook;
                    });
                  },
                  icon: (isLook)
                      ? Icon(Icons.visibility)
                      : Icon(Icons.visibility_off),
                )
              : widget.icon,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 42,
            vertical: 2,
          ),
          hintText: widget.hintText,
          labelText: widget.labelText,
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
