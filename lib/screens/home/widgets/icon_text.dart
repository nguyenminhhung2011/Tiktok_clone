import 'package:flutter/material.dart';

class Icon_text extends StatelessWidget {
  final String no;
  final Function() press;
  final Widget icon;
  const Icon_text({
    Key? key,
    required this.no,
    required this.press,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(onTap: press, child: icon),
        const SizedBox(height: 5),
        Text(
          no,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
