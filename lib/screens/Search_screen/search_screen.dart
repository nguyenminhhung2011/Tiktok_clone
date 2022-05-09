import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool checkSearch = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.07,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Row(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Search',
              textAlign: TextAlign.center,
              // ignore: deprecated_member_use
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
                fontFamily: "Muli",
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                height: 60,
                width: MediaQuery.of(context).size.width / 1.1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(width: 2, color: Colors.black),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 10),
                    Icon(Icons.search, color: Colors.black, size: 30),
                    const SizedBox(width: 5),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.4,
                      child: TextFormField(
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                          hintStyle: TextStyle(color: Colors.grey),
                          hintText: 'Search here',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  checkSearchPerSonPost(context),
                ],
              ),
              const SizedBox(height: 10),
              (checkSearch)
                  ? SingleChildScrollView(
                      scrollDirection: Axis.vertical, child: PerSonSearch())
                  : Container(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: GridView.builder(
                          shrinkWrap: true,
                          itemCount: 5,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 7,
                            mainAxisSpacing: 5,
                            childAspectRatio: 0.6,
                          ),
                          itemBuilder: (context, index) {
                            return VideoCard();
                          },
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Container checkSearchPerSonPost(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      height: 60,
      width: MediaQuery.of(context).size.width / 1.1,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: InkWell(
              borderRadius: BorderRadius.circular(30),
              onTap: () {
                setState(() {
                  if (checkSearch == false) {
                    checkSearch = true;
                  }
                });
              },
              child: Container(
                alignment: Alignment.center,
                height: 50,
                decoration: BoxDecoration(
                  color: checkSearch ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  'Person',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              borderRadius: BorderRadius.circular(30),
              onTap: () {
                setState(() {
                  if (checkSearch == true) {
                    checkSearch = false;
                  }
                });
              },
              child: Container(
                alignment: Alignment.center,
                height: 50,
                decoration: BoxDecoration(
                  color: !checkSearch ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  'Videos',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

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

class PerSonSearch extends StatelessWidget {
  const PerSonSearch({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PerSonCard(),
        PerSonCard(),
        PerSonCard(),
        PerSonCard(),
        PerSonCard(),
      ],
    );
  }
}

class PerSonCard extends StatelessWidget {
  const PerSonCard({
    Key? key,
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
                  'https://scontent.fsgn5-13.fna.fbcdn.net/v/t39.30808-6/271537442_481970630087778_2729125125287225165_n.jpg?_nc_cat=106&ccb=1-6&_nc_sid=09cbfe&_nc_ohc=zGOuA7Eyo90AX-aPxOg&_nc_ht=scontent.fsgn5-13.fna&oh=00_AT9uN0iIvFTkYUbqG45UnncGmAIcU1PpXTITyfE1ljHVzw&oe=627D8085',
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Username',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  // fontFamily: "Muli",
                  fontSize: 15,
                ),
              ),
              Text(
                '#Tiktok name',
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
                Text('7,7k'),
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
