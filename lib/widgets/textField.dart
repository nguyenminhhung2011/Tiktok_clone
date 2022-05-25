import 'package:flutter/material.dart';

class TextField_desgin extends StatefulWidget {
  final String hintText;
  final bool isPassword;
  final TextEditingController textEdittingCotroller;
  final TextInputType textInputType;
  const TextField_desgin({
    Key? key,
    required this.hintText,
    required this.isPassword,
    required this.textEdittingCotroller,
    required this.textInputType,
  }) : super(key: key);

  @override
  State<TextField_desgin> createState() => _TextField_desginState();
}

class _TextField_desginState extends State<TextField_desgin> {
  @override
  bool _isOcused = true;

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 40,
      ),
      child: TextFormField(
        keyboardType: widget.textInputType,
        controller: widget.textEdittingCotroller,
        style: TextStyle(fontSize: 16),
        decoration: InputDecoration(
          hintText: widget.hintText,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            gapPadding: 10,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            gapPadding: 10,
          ),
          contentPadding: const EdgeInsets.all(20),
          filled: true,
          suffixIcon: widget.isPassword
              ? IconButton(
                  padding: const EdgeInsets.fromLTRB(0, 12, 12, 12),
                  onPressed: () {
                    setState(
                      () {
                        _isOcused = !_isOcused;
                      },
                    );
                  },
                  icon: Icon(
                    _isOcused ? Icons.visibility : Icons.visibility_off,
                  ),
                  color: _isOcused
                      ? Colors.blue
                      : Color.fromARGB(255, 214, 212, 211),
                )
              : null,
        ),
        obscureText: (widget.isPassword) ? _isOcused : false,
      ),
    );
  }
}
