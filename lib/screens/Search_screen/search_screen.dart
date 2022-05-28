import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/controls/fake_data.dart';
import 'package:tiktok_clone/screens/Search_screen/widgets/person_card.dart';
import 'package:tiktok_clone/screens/Search_screen/widgets/video_card.dart';

import '../../controls/searchPerson.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final SearchController _searchPerSonController = SearchController();
  bool isShow = false;
  bool checkSearch = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height / 5,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
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
            const SizedBox(height: 10),
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
                  const Icon(Icons.search, color: Colors.black, size: 30),
                  const SizedBox(width: 5),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.4,
                    child: TextFormField(
                      controller: _searchController,
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                      decoration: const InputDecoration(
                        hintStyle: TextStyle(color: Colors.grey),
                        hintText: 'Search here',
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        if (_searchController.text.isNotEmpty) {
                          setState(() {
                            isShow = true;
                          });
                        }
                        setState(() {
                          _searchPerSonController
                              .searchWithType(_searchController.text);
                          _searchPerSonController
                              .searchVideoWithType(_searchController.text);
                        });
                      },
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
          ],
        ),
      ),
      body: (isShow)
          ? Obx(() => (checkSearch)
              ? SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: _searchPerSonController.searchUser.map((e) {
                      return PerSonCard(
                        data: e,
                      );
                    }).toList(),
                  ))
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: _searchPerSonController.searchVideo.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 7,
                      mainAxisSpacing: 5,
                      childAspectRatio: 0.6,
                    ),
                    itemBuilder: (context, index) {
                      return VideoCard(
                          data: _searchPerSonController.searchVideo[index]);
                    },
                  ),
                ))
          : SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      children: FakeData().namme_search.map(
                        (e) {
                          return FakePersonCard(name: e);
                        },
                      ).toList(),
                    ),
                    const Text(
                      'Popular Search',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    Column(
                      children: FakeData().popular_search.map(
                        (e) {
                          return FakePopularSearch(
                              name: e['name'], color: e['color']);
                        },
                      ).toList(),
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
                child: const Text(
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
                child: const Text(
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

class FakePersonCard extends StatelessWidget {
  final String name;
  const FakePersonCard({
    Key? key,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.access_time, color: Colors.black),
        const SizedBox(width: 4),
        Text(name, style: const TextStyle(color: Colors.black)),
        const Spacer(),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.close, color: Colors.black),
        )
      ],
    );
  }
}

class FakePopularSearch extends StatelessWidget {
  final String name;
  final Color color;
  const FakePopularSearch({Key? key, required this.name, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 4),
        Text(name, style: const TextStyle(color: Colors.black)),
        const Spacer(),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.close, color: Colors.black),
        )
      ],
    );
  }
}
