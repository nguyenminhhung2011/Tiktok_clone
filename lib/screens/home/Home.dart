// ignore_for_file: deprecated_member_use

import 'dart:math';

import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:tiktok_clone/controls/auth_controls.dart';
import 'package:tiktok_clone/screens/home/widgets/icon_text.dart';

import '../../constains.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  bool _isFollowing = true;
  bool _checkShowProfile = false;
  double _height = 0;
  // make animation
  late AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 10), vsync: this)
        ..repeat();
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: InkWell(
          onTap: () {},
          child: Container(
            margin: const EdgeInsets.only(top: 8, left: 10),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 250, 45, 108),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.live_tv),
          ),
        ),
        actions: [
          InkWell(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromARGB(255, 136, 199, 250),
              ),
              child: Icon(Icons.search),
            ),
          ),
          SizedBox(width: 15),
        ],
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 220,
              padding:
                  const EdgeInsets.only(left: 5, top: 5, right: 5, bottom: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Color.fromARGB(255, 255, 252, 227),
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromARGB(255, 255, 252, 227),
                    Color.fromARGB(255, 255, 252, 227),
                  ],
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      if (_isFollowing == false) {
                        setState(() {
                          _isFollowing = !_isFollowing;
                        });
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 100,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: (_isFollowing)
                            ? Color.fromARGB(255, 136, 199, 250)
                            : Colors.transparent,
                      ),
                      child: Text(
                        'Following',
                        style: TextStyle(
                          fontFamily: "Muli",
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: (_isFollowing)
                              ? Colors.white
                              : Color.fromARGB(255, 136, 199, 250),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  InkWell(
                    onTap: () {
                      if (_isFollowing == true) {
                        setState(() {
                          _isFollowing = !_isFollowing;
                        });
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 100,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: !(_isFollowing)
                            ? Color.fromARGB(255, 250, 45, 108)
                            : Colors.transparent,
                      ),
                      child: Text(
                        'For You',
                        style: TextStyle(
                          fontFamily: "Muli",
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: !(_isFollowing)
                              ? Colors.white
                              : Color.fromARGB(255, 250, 45, 108),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 10,
        itemBuilder: (context, index) {
          return Container(
            height: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
            ),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  width: double.infinity,
                  child: Image(
                    image: NetworkImage(
                      'https://image.winudf.com/v2/image1/Y29tLlJvc2VCbGFja3BpbmtXYWxscGFwZXIuYWRuYXBwc19zY3JlZW5fMF8xNTk1ODQ5NDE0XzA3OA/screen-0.jpg?fakeurl=1&type=.webp',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 4,
                          child: Container(
                            height: MediaQuery.of(context).size.height / 6,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  '@HenrycollabUs',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        fontFamily: "Muli",
                                      ),
                                ),
                                const SizedBox(height: 7),
                                ExpandableText(
                                  '# Like this video',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      ?.copyWith(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 13,
                                        fontFamily: "Muli",
                                      ),
                                  expandText: 'show more',
                                  collapseText: 'show less',
                                  expandOnTextTap: true,
                                  collapseOnTextTap: true,
                                  maxLines: 2,
                                  linkColor: Colors.blue,
                                ),
                                const SizedBox(height: 7),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.music_note,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 5),
                                    Container(
                                      height: 20,
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      child: Marquee(
                                        text: ' Shawn Mendes: Camelio bello ',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            ?.copyWith(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 13,
                                              fontFamily: "Muli",
                                            ),
                                        velocity: 10,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height:
                                MediaQuery.of(context).size.height / 1.9 - 20,
                            child: Column(
                              children: [
                                const SizedBox(height: 20),
                                Stack(
                                  overflow: Overflow.visible,
                                  children: [
                                    Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          width: 2,
                                          color: Colors.white,
                                        ),
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                            'https://i.vietgiaitri.com/2021/12/9/1-fan-bong-duoc-rose-blackpink-tra-loi-tin-nhan-nhung-bi-chan-trong-1-not-nhac-vi-su-co-cu-quay-xe-sau-do-moi-bat-ngo-223-6200333.jpg',
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 15,
                                      top: 39,
                                      child: Container(
                                        padding: const EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color:
                                              Color.fromARGB(255, 250, 45, 108),
                                        ),
                                        child: Icon(Icons.add,
                                            color: Colors.white, size: 15),
                                      ),
                                    )
                                  ],
                                ),
                                Spacer(),
                                Icon_text(
                                  no: '1.2M',
                                  press: () {},
                                  icon: Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                    size: 35,
                                  ),
                                ),
                                Spacer(),
                                Icon_text(
                                  no: '2.3M',
                                  press: () {},
                                  icon: Icon(
                                    Icons.comment,
                                    size: 35,
                                  ),
                                ),
                                Spacer(),
                                Icon_text(
                                  no: 'Share',
                                  press: () async {
                                    await firebaseAuth.signOut();
                                  },
                                  icon: Icon(
                                    Icons.share,
                                    size: 35,
                                  ),
                                ),
                                Spacer(),
                                Icon_text(
                                  no: 'View',
                                  press: () {
                                    setState(() {
                                      _height = (_height == 150) ? 0 : 150;
                                      _checkShowProfile = !_checkShowProfile;
                                    });
                                  },
                                  icon: Icon(
                                    Icons.person,
                                    size: 35,
                                  ),
                                ),
                                Spacer(),
                                AnimatedBuilder(
                                  animation: _controller,
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color.fromARGB(255, 136, 199, 250),
                                    ),
                                    child: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                        'https://scontent.fsgn2-3.fna.fbcdn.net/v/t39.30808-6/271537442_481970630087778_2729125125287225165_n.jpg?_nc_cat=106&ccb=1-5&_nc_sid=09cbfe&_nc_ohc=31EE469YyFQAX-BMRZ2&_nc_ht=scontent.fsgn2-3.fna&oh=00_AT9JAfJoCX6QWNt4k7zpn79dOBqvo2v0jeNAX-EhytAFbg&oe=626FA8C5',
                                      ),
                                    ),
                                  ),
                                  builder: (context, Widget? child) {
                                    return Transform.rotate(
                                        angle: _controller.value * 2 * pi,
                                        child: child);
                                  },
                                ),
                                Spacer(),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    AnimatedContainer(
                      curve: Curves.fastOutSlowIn,
                      width: double.infinity,
                      height: _height,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        color: Colors.black,
                        gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black26,
                            Colors.white10,
                          ],
                        ),
                      ),
                      duration: Duration(seconds: 1),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 40),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        width: 2,
                                        color:
                                            Color.fromARGB(255, 136, 199, 250),
                                      ),
                                    ),
                                    child: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                        'https://i.vietgiaitri.com/2021/12/9/1-fan-bong-duoc-rose-blackpink-tra-loi-tin-nhan-nhung-bi-chan-trong-1-not-nhac-vi-su-co-cu-quay-xe-sau-do-moi-bat-ngo-223-6200333.jpg',
                                      ),
                                      radius: 30,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '@Username',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17,
                                              fontFamily: "Muli",
                                            ),
                                      ),
                                      const SizedBox(height: 3),
                                      Text(
                                        'Add here okay ?',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            ?.copyWith(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                              fontFamily: "Muli",
                                            ),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 13, vertical: 10),
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
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
