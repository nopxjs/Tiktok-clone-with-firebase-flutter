import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:toktik/controllers/search_controller.dart';
import 'package:toktik/models/user.dart';
import 'package:toktik/views/screens/profile_screen.dart';

import '../../constants.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  TextEditingController _searchController = TextEditingController();

  final SearchController searchController = Get.put(SearchController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColorDark.withOpacity(0.84),
        title: TextFormField(
          controller: _searchController,
          onChanged: (value) {
            searchController.searchUser(value);
          },
          decoration: const InputDecoration(
            filled: false,
            hintText: 'Search',
            fillColor: Colors.white,
            hintStyle: TextStyle(fontSize: 18, color: Colors.white),
          ),
          // cursorColor: backgroundColorDark.withOpacity(0.9),
          style: const TextStyle(color: Colors.white),
        ),
      ),
      // body: searchController.searchedUser.isEmpty
      //     ? const Center(
      //         child: Text(
      //           'Search for user',
      //           style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
      //         ),
      //       )
      //     :
      body: Obx(() {
        return ListView.builder(
          itemCount: searchController.searchedUser.length,
          itemBuilder: (BuildContext context, int index) {
            User user = searchController.searchedUser[index];
            return InkWell(
              onTap: () {
                Get.to(
                  ProfileScreen(uid: user.uid),
                );
              },
              // child: ListTile(
              //   leading: CircleAvatar(
              //     backgroundImage: NetworkImage(
              //       user.profilePhoto,
              //     ),
              //   ),
              //   title: Text(
              //     user.name.toString(),
              //     style: const TextStyle(fontSize: 18),
              //   ),
              // ),
              child: Container(
                margin: const EdgeInsets.all(5),
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: backgroundColorDark.withOpacity(0.8),
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    // const SizedBox(
                    //   width: 10,
                    // ),
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                        user.profilePhoto,
                      ),
                    ),
                    const SizedBox(
                      width: 14,
                    ),
                    Text(
                      user.name,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox()
                  ],

                  // SizedBox(
                  //   height: 6,
                  // )
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
