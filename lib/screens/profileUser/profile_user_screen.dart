import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/constains.dart';

import '../../controls/profile_controllers.dart';
import '../../widgets/Avtar_circle.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int indexOfTab = 0;
  final ProfileControls _profileControls = Get.put(ProfileControls());

  @override
  void initState() {
    super.initState();
    _profileControls.upDateUser(authMethods.user.uid);
  }

  Widget build(BuildContext context) {
    return GetBuilder<ProfileControls>(
      init: ProfileControls(),
      builder: (controller) {
        if (controller.user.isEmpty) {
          Center(
            child: CircularProgressIndicator(),
          );
        }
        return (controller.user['username'] != null)
            ? DefaultTabController(
                length: 3,
                child: Scaffold(
                  backgroundColor: Colors.white,
                  appBar: AppBar(
                    toolbarHeight: MediaQuery.of(context).size.height / 4,
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
                                  avtPath: controller.user['profilePic'],
                                  sizeAvt: 90,
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          controller.user['username'],
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
                                            text: controller
                                                .user['allPosts'].length
                                                .toString(),
                                          ),
                                          TextSpan(text: ' | '),
                                          TextSpan(text: 'Following: '),
                                          TextSpan(
                                            text: controller
                                                .user['following'].length
                                                .toString(),
                                          ),
                                          TextSpan(text: ' | '),
                                          TextSpan(text: 'Followers: '),
                                          TextSpan(
                                              text: controller
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
                                              text: controller.user['email']),
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
                              const SizedBox(width: 20),
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
                                onTap: () {},
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
                          )
                        ],
                      ),
                    ),
                  ),
                  body: TabBarView(
                    children: [
                      VideosTab(data: controller.user),
                      Icon(Icons.directions_transit),
                      SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          children: [],
                        ),
                      )
                    ],
                  ),
                ),
              )
            : Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.blue,
                ),
              );
      },
    );
  }
}

class VideosTab extends StatelessWidget {
  final Map<String, dynamic> data;
  const VideosTab({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          child: GridView.builder(
            shrinkWrap: true,
            itemCount: data['allPosts'].length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              childAspectRatio: 0.6,
            ),
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          data['allPosts'][index]['thumbNails'],
                        ),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                          gradient: const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black26,
                              Colors.white10,
                            ],
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(width: 5),
                            Container(
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    data['profilePic'],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 5),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  data['username'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 32, 211, 234),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.play_arrow,
                                      color: Colors.white,
                                      size: 17,
                                    ),
                                    Text(
                                      '20.11K',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ));
  }
}
