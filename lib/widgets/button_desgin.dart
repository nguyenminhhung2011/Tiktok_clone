import 'package:flutter/material.dart';

class ButtonDesign extends StatelessWidget {
  final String tittle;
  final Function() press;
  const ButtonDesign({
    Key? key,
    required this.tittle,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: 40),
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Color.fromARGB(255, 136, 199, 250),
        ),
        child: Text(
          tittle,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}

class ButtonWithIcon extends StatelessWidget {
  final String tittle;
  final Function() press;
  final Widget icon;
  final Color color;
  const ButtonWithIcon({
    Key? key,
    required this.color,
    required this.tittle,
    required this.press,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 40),
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            icon,
            Text(
              tittle,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
