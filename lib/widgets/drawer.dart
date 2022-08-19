import 'package:filmmer_final/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../helper/constants.dart';
import '../screens/favorites_screen.dart';
import '../screens/settings_page.dart';
import '../screens/watchlist_screen.dart';
import '../storage_local/user_data.dart';
import 'circle_container.dart';
import 'custom_text.dart';

class Draw extends StatelessWidget {
  const Draw({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [header(size), DrawItems(size)],
      ),
    );
  }
}

Widget header(size) {
  return SafeArea(
    child: Container(
      height: size.height * 0.27,
      color: primaryColor,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
        child: FutureBuilder(
            future: UserData().getUser,
            builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return CircleContainer(
                    borderColor: lightColor,
                    borderWidth: 2,
                    height: size.height * 0.16,
                    width: size.height * 0.16,
                    textUp: snapshot.data!.name,
                    textDown: snapshot.data!.email,
                    sizeUp: size.width * 0.055,
                    sizeDown: size.width * 0.035,
                    colorUp: Colors.white,
                    colorDown: lightColor,
                    spaceUp: size.width * 0.01,
                    fit: BoxFit.cover,
                    isLocal: snapshot.data!.isLocal,
                    def: snapshot.data!.pic == 'default' ? true : false,
                    flowDown: TextOverflow.ellipsis,
                    flowUp: TextOverflow.ellipsis,
                    link: snapshot.data!.pic.toString());
              } else {
                return CircleContainer(
                    borderColor: lightColor,
                    borderWidth: 2,
                    height: size.height * 0.16,
                    width: size.height * 0.16,
                    textUp: 'Username',
                    textDown: 'Email',
                    sizeUp: size.width * 0.055,
                    sizeDown: size.width * 0.035,
                    colorUp: Colors.white,
                    colorDown: lightColor,
                    spaceUp: size.width * 0.01,
                    fit: BoxFit.cover,
                    isLocal: true,
                    link: '');
              }
            }),
      ),
    ),
  );
}

Widget DrawItems(size) {
  return Container(
    padding: const EdgeInsets.all(20),
    child: Wrap(
      runSpacing: 16,
      children: [
        ListTile(
          leading: const Icon(
            Icons.list,
            color: lightColor,
          ),
          title: CustomText(
            text: 'watchList'.tr,
            size: size.width * 0.04,
          ),
          onTap: () {
            Get.back();
            Get.to(() => WatchList());
          },
        ),
        ListTile(
          leading: const Icon(Icons.favorite, color: lightColor),
          title: CustomText(
            text: 'favourite'.tr,
            size: size.width * 0.04,
          ),
          onTap: () {
            Get.back();
            Get.to(() => FavoritesScreen());
          },
        ),
        ListTile(
          leading: const Icon(Icons.settings, color: lightColor),
          title: CustomText(
            text: 'settings'.tr,
            size: size.width * 0.04,
          ),
          onTap: () {
            Get.back();
            Get.to(() => Settings());
          },
        ),
      ],
    ),
  );
}
