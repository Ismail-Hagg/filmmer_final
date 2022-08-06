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
          title: const CustomText(
            text: 'WatchList',
            color: lightColor,
          ),
          actions: [
            // GetBuilder<WatchListController>(
            //   init: Get.find<WatchListController>(),
            //   builder: (bro) =>
               Obx(()=>
                  IconButton(
                  icon: CustomText(
                    text: Get.find<WatchListController>().tabs.value == 0
                        ? Get.find<WatchListController>().movies.value.length.toString()
                        : Get.find<WatchListController>().shows.value.length.toString(),
                    size: 18,
                  ),
                  onPressed: null,
                             ),
               ),
            //),
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
          init: Get.put(WatchListController()),
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
                              text: 'Movies',
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
                              text: 'Shows',
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
                child: Container(
                    child: GetX<WatchListController>(
                      init: Get.find<WatchListController>(),
                      builder: (build) => ListView.builder(
                        itemCount: Get.find<WatchListController>().tabs.value == 0
                            ? build.movies.value.length
                            : build.shows.value.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: CustomText(
                              text: Get.find<WatchListController>().tabs.value == 0
                                  ? build.movies.value[index].name
                                  : build.shows.value[index].name,
                              color: Colors.white,
                            ),
                            onTap: () {
                              Get.find<WatchListController>().tabs.value == 0
                                  ?
                              print([build.movies.value[index].name]): print(build.shows.value[index].name);
                              Get.find<WatchListController>().navsearched(
                                  build.tabs.value == 0
                                      ? build.movies.value[index]
                                      : build.shows.value[index]);
                            },
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.white),
                              splashRadius: 15,
                              onPressed: () {
                                controll.delete(
                                    controll.tabs.value == 0
                                        ? controll.movies.value[index].id
                                        : controll.shows.value[index].id,
                                    controll.tabs.value == 0
                                        ? 'movieWatchList'
                                        : 'showWatchList');
                              },
                            ),
                          );
                        },
                      ),
                    )),
              )
            ],
          ),
        ));
  }
}

// Widget lst(int index) {
//   return GetX<WatchListController>(
//     init:Get.find<WatchListController>(),
//     builder:(build)=> ListView.builder(
//       itemCount:index==0?build.movies.value.length:build.shows.value.length,
//       itemBuilder: (context, index) {
//         return ListTile(
//           title: CustomText(
//             text:index==0? build.movies.value[index].name:build.shows.value[index].name,
//             color: Colors.white,
//             size: 18,
//           ),
//           onTap: () {
//             print(build.shows.value[index].name);
//           },
//           trailing: IconButton(
//             icon: const Icon(Icons.delete, color: Colors.white),
//             splashRadius: 15,
//             onPressed: () {
//               // controll.delete(controll.flip == 0
//               //     ? controll.items.value[index].id
//               //     : controll.filter[index].id);
//             },
//           ),
//         );
//       },
//     ),
//   );
// }
