import 'package:flutter/material.dart';

import '../../../models/user.dart';

class PerSonCard extends StatelessWidget {
  final User data;
  const PerSonCard({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.red,
      margin: const EdgeInsets.symmetric(horizontal: 18),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(1),
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                width: 2,
                color: Color.fromARGB(255, 250, 45, 108),
              ),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  data.photoUrl,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.username,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  // fontFamily: "Muli",
                  fontSize: 15,
                ),
              ),
              Text(
                '#${data.bio}',
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  // fontFamily: "Muli",
                  fontSize: 12,
                ),
              ),
            ],
          ),
          Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(23),
              color: Color.fromARGB(255, 250, 45, 108),
            ),
            child: Row(
              children: [
                Icon(Icons.favorite),
                const SizedBox(width: 5),
                Text('${data.followers.length}k'),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.person_add, color: Colors.black),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
