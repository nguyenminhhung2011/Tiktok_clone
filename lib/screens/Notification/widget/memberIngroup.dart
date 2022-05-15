import 'package:flutter/material.dart';

class MemberInGroup extends StatelessWidget {
  const MemberInGroup({
    Key? key,
    required this.photoPath,
  }) : super(key: key);
  final String photoPath;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      width: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
            photoPath,
          ),
        ),
      ),
    );
  }
}
