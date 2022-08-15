import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/watchlist_controller.dart';
import '../helper/constants.dart';
import '../widgets/custom_text.dart';

class WatchList extends StatelessWidget {
  WatchList({
    Key? key,
  }) : super(key: key);

  final WatchListController controll = Get.put(WatchListController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: primaryColor,
        appBar: AppBar(
          backgroundColor: primaryColor,
          elevation: 0,
          title:  CustomText(
            text: 'watchList'.tr,
            color: lightColor,
          ),
          actions: [
            GetBuilder<WatchListController>(
              init: Get.find<WatchListController>(),
              builder: (bro) => IconButton(
                icon: CustomText(
                  text: Get.find<WatchListController>().tabs.value == 0
                      ? Get.find<WatchListController>()
                          .moviesLocal
                          .length
                          .toString()
                      : Get.find<WatchListController>()
                          .showLocal
                          .length
                          .toString(),
                  size: 18,
                ),
                onPressed: null,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.search),
              splashRadius: 15,
              onPressed: () {
                //Get.to(()=>SearchSaved());
                Get.find<WatchListController>().search(context);
              },
            ),
            IconButton(
              icon: const Icon(Icons.shuffle),
              splashRadius: 15,
              onPressed: () {
                Get.find<WatchListController>().nav();
              },
            ),
          ],
        ),
        body: GetBuilder<WatchListController>(
          init: Get.find<WatchListController>(),
          builder: (controller) => Column(
            children: [
              Row(
                children: [
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          controller.change(0);
                        },
                        child: Container(
                          width: size.width * 0.5,
                          height: size.height * 0.065,
                          child: Center(
                            child: CustomText(
                              text: 'movies'.tr,
                              color: controller.tabs.value == 0
                                  ? Colors.white
                                  : Colors.white.withOpacity(0.3),
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 2,
                        color: controller.tabs.value == 0
                            ? lightColor
                            : Colors.transparent,
                        width: size.width * 0.5,
                      )
                    ],
                  ),
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          controller.change(1);
                        },
                        child: Container(
                          width: size.width * 0.5,
                          height: size.height * 0.065,
                          child: Center(
                            child: CustomText(
                              text: 'shows'.tr,
                              color: controller.tabs.value == 1
                                  ? Colors.white
                                  : Colors.white.withOpacity(0.3),
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 2,
                        color: controller.tabs.value == 1
                            ? lightColor
                            : Colors.transparent,
                        width: size.width * 0.5,
                      )
                    ],
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: controller.tabs.value == 0
                        ? controller.moviesLocal.length
                        : controller.showLocal.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: ()=>controller.preNav(index),
                        title: CustomText(
                            text: controller.tabs.value == 0
                                ? controller.moviesLocal[index].name
                                : controller.showLocal[index].name,
                            color: Colors.white,
                            size: size.width * 0.05),
                                         trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.white),
                              splashRadius: 15,
                              onPressed: () {
                                controll.delete(index,controll.tabs.value);
                              },
                            ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
