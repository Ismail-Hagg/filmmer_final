
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/favourites_controller.dart';
import '../helper/constants.dart';
import '../widgets/custom_text.dart';

class FavoritesScreen extends StatelessWidget {
  FavoritesScreen({Key? key}) : super(key: key);

  //final FavoritesController controll = Get.put(FavoritesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryColor,
        appBar: AppBar(
          backgroundColor: primaryColor,
          // centerTitle: true,
          elevation: 0,
          title: const CustomText(text: 'Favorites', color: lightColor),
          actions: [
            IconButton(
              icon: Obx(() => CustomText(
                    text: Get.find<FavoritesController>().flip == 0
                        ? Get.find<FavoritesController>()
                            .items
                            .value
                            .length
                            .toString()
                        : Get.find<FavoritesController>()
                            .filter
                            .length
                            .toString(),
                    size: 18,
                  )),
              onPressed: null,
            ),
            IconButton(
              icon: const Icon(Icons.search),
              splashRadius: 15,
              onPressed: () {
                //Get.to(()=>SearchSaved());
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
        body: GetX<FavoritesController>( 
          init: Get.put(FavoritesController()),
          builder: (controll) => controll.items.value.isEmpty
              ? Container() 
              : Padding(
                  padding: const EdgeInsets.all(16),
                  child: ListView.builder(
                    itemCount: controll.flip==0? controll.items.value.length:controll.filter.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: CustomText( 
                          text: controll.flip==0? controll.items.value[index].name: controll.filter[index].name,
                          color: Colors.white,
                          size: 18,
                        ),
                        onTap: () {
                          controll.nav(index);
                        },
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.white),
                          splashRadius: 15,
                          onPressed: () {
                            controll.delete(
                              controll.flip==0?controll.items.value[index].id:controll.filter[index].id,
                              'Favourites'
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
        )
        );
  }
}
