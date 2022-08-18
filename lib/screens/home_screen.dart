import 'package:filmmer_final/helper/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../widgets/content_scroll.dart';
import '../widgets/custom_text.dart';
import '../widgets/drawer.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: primaryColor,
        drawer: const Draw(),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: primaryColor,
          centerTitle: true,
          title: const CustomText(
            text: 'Filmmer',
            size: 26,
            color: lightColor,
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              splashRadius: 15,
              onPressed: () {
                Get.find<HomeController>().goToSearch(true, 'link', 'Search');
              },
            )
          ],
        ),
        body: MixinBuilder<HomeController>(
          init: Get.find<HomeController>(),
          builder: (builder) => builder.coming.value.results!.isNotEmpty
              ? ListView(physics: const BouncingScrollPhysics(), children: [
                  ContentScroll(
                    title: 'upcoming'.tr,
                    isArrow: true,
                    isCast: false,
                    movie: controller.coming,
                    link: upcoming,
                  ),
                  ContentScroll(
                      title: 'popularMovies'.tr,
                      isArrow: true,
                      isCast: false,
                      movie: controller.popularMovies,
                      link: pop),
                  ContentScroll(
                      title: 'popularShows'.tr,
                      isArrow: true,
                      isCast: false,
                      movie: controller.popularShows,
                      link: popularTv),
                  ContentScroll(
                      title: 'topMovies'.tr,
                      isArrow: true,
                      isCast: false,
                      movie: controller.topRatedMovies,
                      link: top),
                  ContentScroll(
                      title: 'topShowa'.tr,
                      isArrow: true,
                      isCast: false,
                      movie: controller.topRatedShows,
                      link: topTv),
                  const SizedBox(
                    height: 12,
                  )
                ])
              : builder.build.value == true
                  ? const Center(
                      child: CircularProgressIndicator(
                      color: lightColor,
                    ))
                  : Center(
                      child: CustomText(
                      text: 'internet'.tr,
                      color: whiteColor,
                      size: size.width * 0.055,
                    )),
        ));
  }
}
