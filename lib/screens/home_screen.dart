import 'package:filmmer_final/helper/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_cocontroller.dart';
import '../controllers/home_controller.dart';
import '../widgets/content_scroll.dart';
import '../widgets/custom_text.dart';
import '../widgets/drawer.dart';


class HomeScreen extends StatelessWidget {
   HomeScreen({Key? key}) : super(key: key);

  final HomeController controller=Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:primaryColor,
      drawer:const Draw(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor:primaryColor,
        centerTitle:true,
        title:const CustomText(
          text:'Filmmer',
          size:26,
          color:lightColor,
        ),
        actions: [
          IconButton(
            icon:const Icon(Icons.search),
            splashRadius: 15,
            onPressed: (){
              Get.find<AuthController>().signOut();
            },
          ) 
        ],
      ),
      body:  ListView(
        children: [
          ContentScroll(
            title: 'Upcoming Movies',
            isArrow: true,
            isCast:false,
            movie: controller.coming,
          ),
          ContentScroll(
            title: 'Popular Movies',
            isArrow: true,
            isCast:false,
            movie: controller.popularMovies,
          ),
          ContentScroll(
            title: 'Popular Shows',
            isArrow: true,
            isCast:false,
            movie: controller.popularShows,
          ),
          ContentScroll(
            title: 'Top Rated Movies',
            isArrow: true,
            isCast:false,
            movie: controller.topRatedMovies,
          ),
          ContentScroll(
            title: 'Top Rated Shows',
            isArrow: true,
            isCast:false,
            movie: controller.topRatedShows,
          ),
          const SizedBox(height: 12,)
        ]
      )
    );
  }
}