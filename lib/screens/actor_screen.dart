import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shape_of_view_null_safe/shape_of_view_null_safe.dart';

import '../controllers/actor_controller.dart';
import '../controllers/home_controller.dart';
import '../helper/constants.dart';
import '../widgets/circle_container.dart';
import '../widgets/custom_text.dart';
import '../widgets/movie_widget.dart';

class ActorScreen extends StatelessWidget {
  ActorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var safePadding = MediaQuery.of(context).padding.top;
    return Scaffold(
        body: SafeArea(
      child: Container(
        color: primaryColor,
        child: GetBuilder<ActorController>(
          init: Get.find<ActorController>(),
          builder: (controller) => Column(children: [
            Container(
                height: size.height * 0.3 - safePadding,
                color: primaryColor,
                child: Stack(
                  children: [
                    ShapeOfView(
                      elevation: 10,
                      child: Container(color: lightColor.withOpacity(0.5)),
                      shape: ArcShape(
                          direction: ArcDirection.Inside,
                          height: 30,
                          position: ArcPosition.Bottom),
                    ),
                    Positioned(
                      right: 0,
                      left: 0,
                      bottom: 0,
                      child: CircleContainer(
                          isLocal: false,
                          fit: BoxFit.cover,
                          link: controller.model.pic.toString(),
                          height: size.width * 0.38,
                          width: size.width * 0.38,
                          borderWidth: 1,
                          borderColor: whiteColor),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      child: IconButton(
                          icon: const Icon(Icons.arrow_back, color: whiteColor),
                          onPressed: () {
                            Get.back();
                          }),
                    )
                  ],
                )),
            Container(
              height: size.height * 0.7,
              child: Column(
                children: [
                  Container(
                      height: size.height * 0.08,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(
                                text: controller.model.name,
                                color: lightColor,
                                size: size.width * 0.05),
                            CustomText(
                                text:
                                    'Age : ${controller.model.age.toString()} Years Old',
                                color: lightColor,
                                size: size.width * 0.04)
                          ])),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Container(
                      height: size.height * 0.15,
                      child: SingleChildScrollView(
                          child: controller.model.bio != null
                              ? CustomText(
                                  text: controller.model.bio,
                                  color: whiteColor,
                                  size: size.width * 0.035)
                              : Center(
                                  child: CustomText(
                                      text: 'Biography',
                                      color: whiteColor,
                                      size: size.width * 0.035),
                                )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      height: size.height * 0.05,
                      width: size.width * 0.6,
                      //color:Colors.red,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              controller.flip(0);
                            },
                            child: Container(
                              //width:size.width*0.3,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 1, color: lightColor),
                                  borderRadius: BorderRadius.circular(20),
                                  color: controller.count == 1
                                      ? Colors.transparent
                                      : lightColor),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: CustomText(
                                      text: '  Movies  ',
                                      size: 16,
                                      color: controller.count == 1
                                          ? lightColor
                                          : Colors.white),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              controller.flip(1);
                            },
                            child: Container(
                              //width:size.width*0.3,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 1, color: lightColor),
                                  borderRadius: BorderRadius.circular(20),
                                  color: controller.count == 0
                                      ? Colors.transparent
                                      : lightColor),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: CustomText(
                                      text: 'Tv Shows',
                                      size: 16,
                                      color: controller.count == 0
                                          ? lightColor
                                          : Colors.white),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: Container(
                        height: size.height * 0.1,
                        //color:Colors.red,
                        child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Container(
                                //color:Colors.green,
                                width: size.width * 0.3,
                                child: Column(children: [
                                  CustomText(
                                      text: '2', size: 16, color: Colors.white),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  CustomText(
                                    maxline: 2,
                                    text: 'acadimy awards thingy',
                                    size: 14,
                                    color: lightColor,
                                    flow: TextOverflow.ellipsis,
                                  )
                                ]),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const CustomText(
                                text: '  ',
                                size: 30,
                                color: Colors.white,
                              );
                            },
                            itemCount: 5)),
                  ),
                  Container(
                    height: (size.height * 0.32) - 36,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemCount: controller.model.movies == null
                          ? 10
                          : controller.count == 0
                              ? controller.model.movies!.length
                              : controller.model.shows!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: GestureDetector(
                            onTap: ()=>Get.find<HomeController>().navigatoToDetale(
                               controller.count==0? controller.model.movies![index]:controller.model.shows![index]
                            ),
                            child: MovieWidget(
                              rating: controller.count==0?
                               controller.model.movies!=null?controller.model.movies![index].voteAverage: '0.0':controller.model.shows!=null?controller.model.shows![index].voteAverage:'0.0',
                              height: (size.height * 0.25),
                              width: (size.width * 0.35),
                              link: controller.model.movies == null
                                  ? 'https://images.unsplash.com/photo-1653682902362-308526d14ef5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80'
                                  : controller.count == 0
                                      ?controller.model.movies![index].posterPath!=null?
                                       imagebase +
                                          controller
                                              .model.movies![index].posterPath
                                              .toString():'https://www.kuleuven.be/communicatie/congresbureau/fotos-en-afbeeldingen/no-image.png/image'
                                      :
                                          controller
                                              .model.shows![index].posterPath!=null?
                                       imagebase +
                                          controller
                                              .model.shows![index].posterPath
                                              .toString():'https://www.kuleuven.be/communicatie/congresbureau/fotos-en-afbeeldingen/no-image.png/image',
                              color: lightColor,
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ]),
        ),
      ),
    ));
  }
}
