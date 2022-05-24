import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/constains.dart';
import 'package:tiktok_clone/screens/profileUser/widgets/displayVideo.dart';
import 'package:tiktok_clone/screens/profileUser/widgets/videoFavCard.dart';
import 'package:tiktok_clone/widgets/Avtar_circle.dart';

import '../../controls/prodifController.dart';
import '../../controls/profile_controllers.dart';
import '../../models/user.dart';

class ProfileDifScreen extends StatefulWidget {
  final User data;
  const ProfileDifScreen({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<ProfileDifScreen> createState() => _ProfileDifScreenState();
}

class _ProfileDifScreenState extends State<ProfileDifScreen> {
  final ProDiffControl _prodiffControls = Get.put(ProDiffControl());
  final ProfileControls profileControls = Get.put(ProfileControls());
  int _currentIndex = 0;
  int checkClick = 0; //0: Videos 1: Persons 2: Favorites
  @override
  void initState() {
    super.initState();
    _prodiffControls.getAllVideo(widget.data.uid);
    _prodiffControls.getAllFavVideo(widget.data.uid);
    _prodiffControls.getAllFollowers(widget.data.uid);
    _prodiffControls.getAllFollowing(widget.data.uid);
  }

  void updateDataWhenUserFollowOrUnFollow() {
    setState(() {
      if (widget.data.followers.contains(authMethods.user.uid)) {
        widget.data.followers
            .removeWhere((element) => element == authMethods.user.uid);
      } else {
        widget.data.followers.add(authMethods.user.uid);
      }
    });
  }

  void updateDataOfMainUser() {
    profileControls.updateFollowing(authMethods.user.uid);
    profileControls.updateUserUnfollow(authMethods.user.uid);
  }

  void dispose() {
    super.dispose();
    updateDataOfMainUser();
  }

  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
          title: Text(
            widget.data.username,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          actions: [
            Icon(
              Icons.favorite,
              color: const Color.fromARGB(255, 32, 211, 234),
            ),
            const SizedBox(width: 20),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AvatarCircle(
                  avtPath: widget.data.photoUrl,
                  sizeAvt: 150,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              widget.data.username,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 19,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              "${_prodiffControls.listVideo.length} Posts | ${widget.data.following.length} following | ${widget.data.followers.length} followers",
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              "Email: ${widget.data.email}",
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(14),
                  onTap: () {
                    _prodiffControls.followingUser(widget.data.uid);
                    updateDataWhenUserFollowOrUnFollow();
                  },
                  child: Container(
                    width: 200,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color:
                          (widget.data.followers.contains(authMethods.user.uid))
                              ? Color.fromARGB(255, 32, 211, 234)
                              : Color.fromARGB(255, 250, 45, 108),
                    ),
                    child:
                        (widget.data.followers.contains(authMethods.user.uid))
                            ? Text(
                                'UnFollowing',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              )
                            : Text(
                                'Following',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                  ),
                ),
                const SizedBox(width: 5),
                InkWell(
                  borderRadius: BorderRadius.circular(14),
                  onTap: () {},
                  child: Container(
                    width: 40,
                    height: 40,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Colors.grey.withOpacity(0.3)),
                    child: Icon(
                      Icons.facebook_outlined,
                      size: 20,
                      color: Colors.blue,
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                InkWell(
                  borderRadius: BorderRadius.circular(14),
                  onTap: () {},
                  child: Container(
                    width: 40,
                    height: 40,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Colors.grey.withOpacity(0.3)),
                    child: Icon(
                      Icons.tiktok,
                      size: 20,
                      color: Color.fromARGB(255, 250, 45, 108),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            Container(
              width: MediaQuery.of(context).size.width / 2,
              height: 0.8,
              color: Colors.grey,
            ),
            const SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              height: 50,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 32, 211, 234),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                  bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        if (checkClick != 0) {
                          setState(() {
                            checkClick = 0;
                          });
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 5),
                        height: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: (checkClick == 0)
                              ? Color.fromARGB(255, 250, 45, 108)
                              : Colors.transparent,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(5),
                            bottomLeft: Radius.circular(5),
                            bottomRight: Radius.circular(5),
                          ),
                        ),
                        child: Text(
                          'Videos',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        if (checkClick != 1) {
                          setState(() {
                            checkClick = 1;
                          });
                        }
                      },
                      child: Container(
                        height: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: (checkClick == 1)
                              ? Color.fromARGB(255, 250, 45, 108)
                              : Colors.transparent,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5),
                            bottomLeft: Radius.circular(5),
                            bottomRight: Radius.circular(5),
                          ),
                        ),
                        child: Text(
                          'Persons',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        if (checkClick != 2) {
                          setState(() {
                            checkClick = 2;
                          });
                        }
                      },
                      child: Container(
                        height: 40,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(left: 5),
                        decoration: BoxDecoration(
                          color: (checkClick == 2)
                              ? Color.fromARGB(255, 250, 45, 108)
                              : Colors.transparent,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(25),
                            bottomLeft: Radius.circular(5),
                            bottomRight: Radius.circular(5),
                          ),
                        ),
                        child: Text(
                          'Favorites',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              height: MediaQuery.of(context).size.height / 2.2,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 248, 183),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                ),
              ),
              child: (checkClick == 0)
                  ? SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: GridView.builder(
                        shrinkWrap: true,
                        itemCount: _prodiffControls.listVideo.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                          childAspectRatio: 1,
                        ),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => Dialog(
                                  backgroundColor: Colors.transparent,
                                  child: DisPlayVideo(
                                    size: MediaQuery.of(context).size,
                                    video: _prodiffControls.listVideo[index],
                                  ),
                                ),
                              );
                            },
                            child: VideoDifCard(
                              prodiffControls: _prodiffControls,
                              index: index,
                            ),
                          );
                        },
                      ),
                    )
                  : (checkClick == 1)
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: PageView.builder(
                                onPageChanged: (index) {
                                  setState(() {
                                    _currentIndex = index;
                                  });
                                },
                                itemCount: 2,
                                itemBuilder: (contex, index) {
                                  return (index == 0)
                                      ? Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Following',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: const Color.fromARGB(
                                                    255, 250, 45, 108),
                                                fontSize: 20,
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            SingleChildScrollView(
                                                scrollDirection: Axis.vertical,
                                                child: Column(
                                                  children: _prodiffControls
                                                      .ListFollowing.map(
                                                    (e) =>
                                                        FollowingDifCardPerson(
                                                            data: e),
                                                  ).toList(),
                                                ))
                                          ],
                                        )
                                      : Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Follower',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: const Color.fromARGB(
                                                    255, 32, 211, 234),
                                                fontSize: 20,
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            SingleChildScrollView(
                                                scrollDirection: Axis.vertical,
                                                child: Column(
                                                  children: _prodiffControls
                                                      .ListFollowers.map(
                                                    (e) =>
                                                        FollowersDifCardPerson(
                                                            data: e),
                                                  ).toList(),
                                                ))
                                          ],
                                        );
                                },
                              ),
                            ),
                            Container(
                              height: 8,
                              alignment: Alignment.center,
                              margin: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width / 2 -
                                          95),
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 2,
                                itemBuilder: (context, position) {
                                  return buildIndicator(
                                      position == _currentIndex,
                                      MediaQuery.of(context).size);
                                },
                              ),
                            ),
                            const SizedBox(height: 10),
                          ],
                        )
                      : SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            children: _prodiffControls.ListFavVideo.map(
                              (e) => VideoFavCard(data: e),
                            ).toList(),
                          ),
                        ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildIndicator(bool isActive, Size size) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: 12,
      width: isActive ? 80 : 30,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
          //container with border
          color:
              isActive ? Colors.blue : const Color.fromARGB(255, 32, 211, 234),
          borderRadius: BorderRadius.all(Radius.circular(12)),
          boxShadow: [
            BoxShadow(
                color: Colors.black38, offset: Offset(2, 3), blurRadius: 3)
          ]),
    );
  }
}

class VideoDifCard extends StatelessWidget {
  const VideoDifCard({
    Key? key,
    required ProDiffControl prodiffControls,
    required this.index,
  })  : _prodiffControls = prodiffControls,
        super(key: key);

  final ProDiffControl _prodiffControls;
  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.transparent,
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black26,
              Colors.grey,
            ],
          ),
          image: DecorationImage(
            fit: BoxFit.cover,
            image:
                NetworkImage(_prodiffControls.listVideo[index].thumbNailsPath),
          ),
          border: Border.all(width: 5, color: Colors.white),
        ),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.favorite,
                      color: const Color.fromARGB(255, 250, 45, 108),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      '${_prodiffControls.listVideo[index].likes.length} likes',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ],
            ),
            Center(
              child: Icon(
                Icons.play_arrow,
                color: const Color.fromARGB(255, 32, 211, 234),
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FollowersDifCardPerson extends StatelessWidget {
  const FollowersDifCardPerson({
    Key? key,
    required this.data,
  }) : super(key: key);
  final User data;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color.fromARGB(255, 255, 252, 227),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 18),
        padding: const EdgeInsets.symmetric(vertical: 10),
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(),
        child: Row(
          children: [
            AvatarCircle(
              avtPath: data.photoUrl,
              sizeAvt: 70,
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
                    fontSize: 17,
                  ),
                ),
                Text(
                  '#${data.bio}',
                  style: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.bold),
                )
              ],
            ),
            Spacer(),
            Icon(
              Icons.favorite,
              color: Color.fromARGB(255, 32, 211, 234),
            ),
          ],
        ),
      ),
    );
  }
}

class FollowingDifCardPerson extends StatelessWidget {
  const FollowingDifCardPerson({
    Key? key,
    required this.data,
  }) : super(key: key);
  final User data;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color.fromARGB(255, 255, 252, 227),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 18),
        padding: const EdgeInsets.symmetric(vertical: 10),
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(),
        child: Row(
          children: [
            AvatarCircle(
              avtPath: data.photoUrl,
              sizeAvt: 70,
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
                    fontSize: 17,
                  ),
                ),
                Text(
                  '#${data.bio}',
                  style: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.bold),
                )
              ],
            ),
            Spacer(),
            Icon(
              Icons.favorite,
              color: Color.fromARGB(255, 250, 45, 108),
            ),
          ],
        ),
      ),
    );
  }
}
