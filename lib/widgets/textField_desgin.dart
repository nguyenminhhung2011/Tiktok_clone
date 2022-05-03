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
    return TextFormField(
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
      controller: widget.textController,
      keyboardType: TextInputType.emailAddress,
      obscureText: (widget.isPass) ? isLook : false,
      decoration: InputDecoration(
        iconColor: Color.fromARGB(255, 32, 211, 234),
        labelStyle: TextStyle(
          // color: (widget.textController.text == "")
          //     ? Colors.grey
          //     : Colors.grey,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        floatingLabelStyle: TextStyle(
          color: (widget.textController.text == "") ? Colors.grey : Colors.grey,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        hintStyle: TextStyle(
          color: Colors.grey.withOpacity(0.6),
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        suffixIcon: (widget.isPass)
            ? Padding(
                padding: const EdgeInsets.only(right: 10),
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      isLook = !isLook;
                    });
                  },
                  icon: (isLook)
                      ? Icon(Icons.visibility,
                          color: Colors.grey.withOpacity(0.3))
                      : Icon(Icons.visibility_off,
                          color: Colors.grey.withOpacity(0.3)),
                ),
              )
            : Padding(
                padding: const EdgeInsets.only(right: 17),
                child: widget.icon,
              ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 42,
          vertical: 2,
        ),
        hintText: widget.hintText,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: const Color.fromARGB(255, 32, 211, 234),
            width: 2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: Colors.grey.withOpacity(0.3),
            width: 2,
          ),
        ),
      ),
    );
  }
}
