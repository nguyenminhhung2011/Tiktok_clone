import 'package:flutter/material.dart';

class VideoCard extends StatelessWidget {
  const VideoCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 2 - 20,
            height: 320,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: NetworkImage(
                  'https://i.pinimg.com/originals/46/cb/f6/46cbf63a8a09b08170778befb024c4fc.jpg',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 3),
          Text(
            'This is commment',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 3),
          Row(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(
                      'https://media.vov.vn/sites/default/files/styles/large/public/2021-06/rose-blackpink-pha-moi-ky-luc-voi-san-pham-am-nhac-solo-dau-tay.jpeg',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 5),
              Text(
                'Rose Blackpint',
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Icon(
                Icons.favorite,
                size: 18,
                color: Color.fromARGB(255, 250, 45, 108),
              ),
              const SizedBox(width: 3),
              Text(
                '2011',
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
