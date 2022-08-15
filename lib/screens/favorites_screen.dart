import 'package:filmmer_final/models/upload.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/favourites_controller.dart';
import '../helper/constants.dart';
import '../storage_local/local_database.dart';
import '../widgets/custom_text.dart';

class FavoritesScreen extends StatelessWidget {
  FavoritesScreen({Key? key}) : super(key: key);
  final dbHelper = DatabaseHelper.instance;

  final FavoritesController controll = Get.put(FavoritesController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        // centerTitle: true,
        elevation: 0,
        title:  CustomText(text: 'favourite'.tr, color: lightColor),
        actions: [
          IconButton(
            icon: GetBuilder<FavoritesController>(
              init:Get.find<FavoritesController>(),
              builder: (controller)=>CustomText(
                    text: controller
                            .newList
                            .length
                            .toString(),
                       
                    size: size.width*0.05,
                  ),
            ),
            onPressed: null,
          ),
          IconButton(
            icon: const Icon(Icons.search),
            splashRadius: 15,
            onPressed: () {
              Get.find<FavoritesController>().search(context);
            },
          ),
          IconButton(
            icon: const Icon(Icons.shuffle),
            splashRadius: 15,
            onPressed: () {
              Get.find<FavoritesController>().randomnav();
            },
          ),
        ],
      ),

      body:  GetBuilder<FavoritesController>(
        init: Get.find<FavoritesController>(),
        builder:(controller)=> Padding(
            padding: const EdgeInsets.all(16),
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: Get.find<FavoritesController>().newList.length,
              itemBuilder: (context, index) {
                return ListTile( 
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.white),
                      splashRadius: 15,
                      onPressed: () {
                       controller.localDelete(
                           controller.newList[index].id, index);
                      },
                    ),
                    title: CustomText(
                      text: controller.newList[index].name,
                      color: whiteColor,
                      size: size.width*0.05,
                    ), 
                    onTap: () {
                      controller.navv(controller.newList[index]);
                    });
              },
            ),
        ),
      ),
    );
  }
}
