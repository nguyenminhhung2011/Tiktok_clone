import 'package:flutter/material.dart';

class AvatarCircle extends StatelessWidget {
  final String avtPath;
  final double sizeAvt;
  const AvatarCircle({
    Key? key,
    required this.avtPath,
    required this.sizeAvt,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: sizeAvt,
          height: sizeAvt,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage('images/border.png'),
            ),
          ),
        ),
        Positioned(
          left: 8,
          top: 8,
          child: Container(
            width: sizeAvt - 16,
            height: sizeAvt - 16,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(
                    avtPath,
                  ),
                  fit: BoxFit.cover,
                )),
          ),
        ),
      ],
    );
  }
}
