import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/constains.dart';
import 'package:tiktok_clone/screens/profileUser/profileDifUser.dart';
import 'package:tiktok_clone/screens/profileUser/videoFavTab.dart';
import 'package:tiktok_clone/screens/profileUser/videoTab.dart';
import 'package:tiktok_clone/screens/profileUser/widgets/cardPersonInList.dart';

import '../../controls/profile_controllers.dart';
import '../../models/user.dart';
import '../../models/video.dart';
import '../../widgets/Avtar_circle.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int indexOfTab = 0;
  bool isShowListPerson = false;
  final ProfileControls _profileControls = Get.put(ProfileControls());
  int counter = 2;
  @override
  void initState() {
    super.initState();
    _profileControls.upDateUser(authMethods.user.uid);
    _profileControls.updatVideoFav(authMethods.user.uid);
    _profileControls.updateUserUnfollow(authMethods.user.uid);
    _profileControls.updateFollowing(authMethods.user.uid);
    _profileControls.updateFollowers(authMethods.user.uid);
  }

  void updateController() {
    _profileControls.upDateUser(authMethods.user.uid);
    _profileControls.updateUserUnfollow(authMethods.user.uid);
    _profileControls.updateFollowing(authMethods.user.uid);
    if (_profileControls.userUnFollow.length == 0) {
      setState(() {
        isShowListPerson = false;
      });
    }
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Obx(
      () => (_profileControls.user['username'] != null)
          ? DefaultTabController(
              length: 3,
              child: Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  toolbarHeight: (isShowListPerson &&
                          _profileControls.userUnFollow.length > 0)
                      ? MediaQuery.of(context).size.height / 2
                      : MediaQuery.of(context).size.height / 4,
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  bottom: TabBar(
                    onTap: (index) {
                      setState(() {
                        indexOfTab = index;
                      });
                    },
                    indicatorColor: Color.fromARGB(255, 242, 196, 15),
                    tabs: [
                      Tab(
                        icon: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.tiktok,
                              color: (indexOfTab == 0)
                                  ? Color.fromARGB(255, 242, 196, 15)
                                  : Colors.grey,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              'Videos',
                              style: TextStyle(
                                color: (indexOfTab == 0)
                                    ? Color.fromARGB(255, 242, 196, 15)
                                    : Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                      Tab(
                        icon: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.person,
                              color: (indexOfTab == 1)
                                  ? Color.fromARGB(255, 242, 196, 15)
                                  : Colors.grey,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              'Person',
                              style: TextStyle(
                                color: (indexOfTab == 1)
                                    ? Color.fromARGB(255, 242, 196, 15)
                                    : Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                      Tab(
                        icon: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.favorite,
                              color: (indexOfTab == 2)
                                  ? Color.fromARGB(255, 242, 196, 15)
                                  : Colors.grey,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              'Favorited',
                              style: TextStyle(
                                color: (indexOfTab == 2)
                                    ? Color.fromARGB(255, 242, 196, 15)
                                    : Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  title: Container(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Profile User',
                              // ignore: deprecated_member_use
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            Spacer(),
                            Icon(
                              Icons.favorite,
                              color: Color.fromARGB(255, 250, 45, 108),
                            ),
                            const SizedBox(width: 20),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              AvatarCircle(
                                avtPath: _profileControls.user['profilePic'],
                                sizeAvt: 90,
                              ),
                              const SizedBox(width: 10),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        _profileControls.user['username'],
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Container(
                                        width: 20,
                                        height: 20,
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.blue,
                                        ),
                                        child: Icon(
                                          Icons.tiktok,
                                          color: Colors.white,
                                          size: 10,
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  RichText(
                                    text: TextSpan(
                                      text: '',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                      children: [
                                        TextSpan(text: 'Posts: '),
                                        TextSpan(
                                          text: _profileControls
                                              .user['allPosts'].length
                                              .toString(),
                                        ),
                                        TextSpan(text: ' | '),
                                        TextSpan(text: 'Following: '),
                                        TextSpan(
                                          text: _profileControls
                                              .user['following'].length
                                              .toString(),
                                        ),
                                        TextSpan(text: ' | '),
                                        TextSpan(text: 'Followers: '),
                                        TextSpan(
                                            text: _profileControls
                                                .user['followers'].length
                                                .toString()),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  RichText(
                                    text: TextSpan(
                                      text: '',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                      children: [
                                        TextSpan(text: 'Email: '),
                                        TextSpan(
                                            text:
                                                _profileControls.user['email']),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(width: 50),
                            InkWell(
                              borderRadius: BorderRadius.circular(14),
                              onTap: () {},
                              child: Container(
                                width: 200,
                                height: 40,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 250, 45, 108),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Text(
                                  'Edit your profile',
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
                              onTap: () {
                                setState(() {
                                  isShowListPerson =
                                      (_profileControls.userUnFollow.length !=
                                              0)
                                          ? !isShowListPerson
                                          : isShowListPerson;
                                });
                              },
                              child: Container(
                                width: 40,
                                height: 40,
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    color: Colors.grey.withOpacity(0.3)),
                                child: Icon(
                                  Icons.arrow_drop_down,
                                  size: 30,
                                  color: Colors.black,
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 10),
                        (isShowListPerson)
                            ? Container(
                                width: size.width,
                                alignment: Alignment.centerLeft,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children:
                                        _profileControls.userUnFollow.map((e) {
                                      return CardPersonInList(
                                        size: size,
                                        user: e,
                                        press: () async {
                                          _profileControls.followingUser(
                                              e.uid, e.following);
                                          updateController();
                                          setState(() {});
                                        },
                                      );
                                    }).toList(),
                                  ),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ),
                body: TabBarView(
                  children: [
                    VideosTab(data: _profileControls.user),
                    PersonTab(
                      followingUser: _profileControls.following,
                      followerUser: _profileControls.followers,
                      profileControls: _profileControls,
                    ),
                    videoFavTab(data: _profileControls.videoFav),
                  ],
                ),
              ),
            )
          : Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            ),
    );
  }
}

class PersonTab extends StatefulWidget {
  const PersonTab({
    Key? key,
    required this.followingUser,
    required this.followerUser,
    required this.profileControls,
  }) : super(key: key);

  final List<User> followingUser;
  final List<User> followerUser;
  final ProfileControls profileControls;
  @override
  State<PersonTab> createState() => _PersonTabState();
}

class _PersonTabState extends State<PersonTab> {
  bool checkFollowingFollowers = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        children: [
          Row(
            children: [
              const SizedBox(width: 20),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
                height: 40,
                width: 150,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 252, 227),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        if (checkFollowingFollowers == false) {
                          setState(() {
                            checkFollowingFollowers = true;
                          });
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 71,
                        height: 34,
                        decoration: BoxDecoration(
                          color: (checkFollowingFollowers)
                              ? Color.fromARGB(255, 250, 45, 108)
                              : Colors.transparent,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            topRight: Radius.circular(4),
                            bottomRight: Radius.circular(4),
                          ),
                        ),
                        child: Text(
                          'Following',
                          style: TextStyle(
                            color: (checkFollowingFollowers)
                                ? Colors.white
                                : Color.fromARGB(255, 250, 45, 108),
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    InkWell(
                      onTap: () {
                        if (checkFollowingFollowers == true) {
                          setState(() {
                            checkFollowingFollowers = false;
                          });
                        }
                      },
                      child: Container(
                        width: 71,
                        height: 34,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: (!checkFollowingFollowers)
                              ? Color.fromARGB(255, 32, 211, 234)
                              : Colors.transparent,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(4),
                            bottomLeft: Radius.circular(4),
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                        child: Text(
                          'Followers',
                          style: TextStyle(
                            color: (!checkFollowingFollowers)
                                ? Colors.white
                                : Color.fromARGB(255, 32, 211, 234),
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: (checkFollowingFollowers)
                  ? widget.followingUser.map(
                      (e) {
                        return FollowingCardPerson(
                          data: e,
                          profileControls: widget.profileControls,
                        );
                      },
                    ).toList()
                  : widget.followerUser.map(
                      (e) {
                        return FollowersCardPerson(
                          data: e,
                          profileControls: widget.profileControls,
                        );
                      },
                    ).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class FollowersCardPerson extends StatelessWidget {
  const FollowersCardPerson({
    Key? key,
    required this.data,
    required this.profileControls,
  }) : super(key: key);
  final User data;
  final ProfileControls profileControls;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfileDifScreen(
              data: data,
              profileControls: profileControls,
            ),
          ),
        );
      },
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

class FollowingCardPerson extends StatelessWidget {
  const FollowingCardPerson({
    Key? key,
    required this.data,
    required this.profileControls,
  }) : super(key: key);
  final User data;
  final ProfileControls profileControls;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfileDifScreen(
              data: data,
              profileControls: profileControls,
            ),
          ),
        );
      },
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
