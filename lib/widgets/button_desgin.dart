import 'package:flutter/material.dart';

class ButtonDesign extends StatelessWidget {
  final Function() press;
  final Widget title;
  const ButtonDesign({
    Key? key,
    required this.press,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: const Color.fromARGB(255, 136, 199, 250),
        ),
        child: title,
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
            // icon,
            Text(
              tittle,
              style: const TextStyle(
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
