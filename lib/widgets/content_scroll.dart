import 'package:filmmer_final/models/cast_model.dart';
import 'package:filmmer_final/models/more_search_moving.dart';
import 'package:filmmer_final/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/actor_controller.dart';
import '../controllers/home_controller.dart';
import '../controllers/movie_detale_controller.dart';
import '../helper/constants.dart';
import '../models/movie_detale_model.dart';
import '../models/movie_result_model.dart';
import '../screens/actor_screen.dart';
import '../screens/more_search_screen.dart';
import '../screens/movie_detale_screen.dart';
import '../screens/test_screen.dart';
import 'circle_container.dart';
import 'movie_widget.dart';

class ContentScroll extends StatelessWidget {
  final String title;
  final MovieDetaleModel? detale;
  final Rx<HomeTopMovies>? movie;
  final String? link;
  final bool isArrow;
  final bool isCast;
  const ContentScroll({
    Key? key,
    required this.title,
    this.movie,
    this.link,
    required this.isArrow,
    required this.isCast,
    this.detale,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      children: [
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(
              width: (size.width - 30) * 0.9,
              child: CustomText(
                text: title,
                color: Colors.white,
                size: 20,
                weight: FontWeight.w600,
                flow: TextOverflow.ellipsis,
              ),
            ),
            isArrow == true
                ? Container(
                    width: (size.width - 30) * 0.1,
                    child: GestureDetector(
                        onTap: () {
                          Get.find<HomeController>()
                              .goToSearch(false, link.toString(), title);
                        },
                        child: const Icon(Icons.arrow_forward,
                            color: Colors.white, size: 30)),
                  )
                : Container()
          ]),
        ),
        const SizedBox(height: 15),
        isCast == false
            ?
            // display list of Movies

            movie == null
                ? SizedBox(
                    height: size.height * 0.28,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: detale!.recomendation!.results!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: GestureDetector(
                            onTap: () {
                              print(
                                  detale!.recomendation!.results![index].title);
                              Get.find<HomeController>().navigatoToDetale(
                                  detale!.recomendation!.results![index]);
                            },
                            child: MovieWidget(
                              width: size.width * 0.4,
                              height: size.height * 0.28,
                              link: detale!.recomendation!.results![index]
                                          .posterPath ==
                                      null
                                  ? 'https://www.kuleuven.be/communicatie/congresbureau/fotos-en-afbeeldingen/no-image.png/image'
                                  : detale!.recomendation!.results![0].id != 0
                                      ? imagebase +
                                          detale!.recomendation!.results![index]
                                              .posterPath
                                              .toString()
                                      : detale!.recomendation!.results![index]
                                          .posterPath
                                          .toString(),
                              rating: detale!.recomendation!.results![index]
                                      .voteAverage ??
                                  '0.0',
                              color: lightColor,
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : Obx(() => SizedBox(
                      height: size.height * 0.28,
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: movie!.value.results!.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: GestureDetector(
                              onTap: () {
                                print(movie!.value.results![index].title);
                                Get.find<HomeController>().navigatoToDetale(
                                    movie!.value.results![index]);
                              },
                              child: MovieWidget(
                                width: size.width * 0.4,
                                height: size.height * 0.28,
                                link: movie!.value.results![index].posterPath ==
                                        null
                                    ? 'https://www.kuleuven.be/communicatie/congresbureau/fotos-en-afbeeldingen/no-image.png/image'
                                    : imagebase +
                                        movie!.value.results![index].posterPath
                                            .toString(),
                                rating:
                                    movie!.value.results![index].voteAverage ??
                                        '0.0',
                                color: lightColor,
                              ),
                            ),
                          );
                        },
                      ),
                    ))
            :
            // display list of Cast
            Container(
                height: size.height * 0.2,
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: detale!.cast!.cast!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: GestureDetector(
                          onTap: () {
                            if (detale!.cast!.cast![index].profilePath !=
                                null) {
                              if (detale!.cast!.cast![index].name == 'Actor') {
                                print('not yet');
                              } else {
                                // Get.find<HomeController>().actor.name=detale!.cast!.cast![index].name;
                                // Get.find<HomeController>().actor.pic=imagebase+detale!.cast!.cast![index].profilePath.toString();
                                // Get.find<HomeController>().actor.age=0;
                                // Get.find<HomeController>().actor.id=detale!.cast!.cast![index].id.toString();
                                // Get.find<HomeController>().actor.bio=null;
                                // Get.find<HomeController>().actor.movies=null;
                                // Get.find<HomeController>().actor.shows=null;
                                // Get.create(() =>(ActorController()),permanent: false);
                                // Get.to(() => ActorScreen(),preventDuplicates: false);
                                Get.find<HomeController>().goToActor(
                                    detale!.cast!.cast![index].name,
                                    imagebase +
                                        detale!.cast!.cast![index].profilePath
                                            .toString(),
                                    0,
                                    detale!.cast!.cast![index].id.toString(),
                                    null,
                                    null,
                                    null);
                              }
                            } else {
                              print('no info');
                            }
                          },
                          child: Container(
                            width: size.width * 0.25,
                            child: CircleContainer(
                              maxUp: 1,
                              maxDown: 1,
                              isLocal: false,
                              link: detale!.cast!.cast![index].profilePath !=
                                      null
                                  ? detale!.cast!.cast![index].name == 'Actor'
                                      ? detale!.cast!.cast![index].profilePath
                                          .toString()
                                      : imagebase +
                                          detale!.cast!.cast![index].profilePath
                                              .toString()
                                  : 'https://www.kuleuven.be/communicatie/congresbureau/fotos-en-afbeeldingen/no-image.png/image',
                              textUp: detale!.cast!.cast![index].name,
                              colorUp: lightColor,
                              sizeUp: 15,
                              textDown: detale!.cast!.cast![index].character,
                              colorDown: whiteColor,
                              sizeDown: 11,
                              width: size.height * 0.13,
                              height: size.height * 0.13,
                              color: primaryColor,
                              spaceUp: 10,
                            ),
                          ),
                        ),
                      );
                    }),
              )
      ],
    );
  }
}
