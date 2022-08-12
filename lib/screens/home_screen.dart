import 'package:filmmer_final/controllers/connectivity_controller.dart';
import 'package:filmmer_final/helper/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_cocontroller.dart';
import '../controllers/home_controller.dart';
import '../models/more_search_moving.dart';
import '../widgets/content_scroll.dart';
import '../widgets/custom_text.dart';
import '../widgets/drawer.dart';
import 'more_search_screen.dart';

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
                Get.find<HomeController>().goToSearch(true,'link','Search');
              },
            )
          ],
        ),
        body: MixinBuilder<HomeController>(
            init: Get.find<HomeController>(),
            builder: (builder) =>  builder.coming.value.results!.isNotEmpty
                      ? ListView(
                          physics: const BouncingScrollPhysics(),
                          children: [
                              ContentScroll(
                                title: 'Upcoming Movies',
                                isArrow: true,
                                isCast: false,
                                movie: controller.coming,
                                link: upcoming,
                              ),
                              ContentScroll(
                                  title: 'Popular Movies',
                                  isArrow: true,
                                  isCast: false,
                                  movie: controller.popularMovies,
                                  link: pop),
                              ContentScroll(
                                  title: 'Popular Shows',
                                  isArrow: true,
                                  isCast: false,
                                  movie: controller.popularShows,
                                  link: popularTv),
                              ContentScroll(
                                  title: 'Top Rated Movies',
                                  isArrow: true,
                                  isCast: false,
                                  movie: controller.topRatedMovies,
                                  link: top),
                              ContentScroll(
                                  title: 'Top Rated Shows',
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
                              child: GestureDetector(
                              onTap: () => builder.load(),
                              child: CustomText(
                                text: 'Click to Refresh',
                                color: whiteColor,
                                size: size.width * 0.055,
                              ),
                            )),
                )
                );
  }
}
