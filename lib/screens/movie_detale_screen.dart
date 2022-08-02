import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shape_of_view_null_safe/shape_of_view_null_safe.dart';

import '../controllers/home_controller.dart';
import '../controllers/movie_detale_controller.dart';
import '../helper/constants.dart';
import '../widgets/content_scroll.dart';
import '../widgets/custom_text.dart';

class MovieDetale extends StatelessWidget {
  
   MovieDetale({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: mainColor,
      body: SingleChildScrollView(
        child: 
        GetBuilder<MovieDetaleController>(
          init: Get.put(MovieDetaleController()),
          builder:(controller)=> 
          
             Column(children: [
              Container(
                height: size.height * 0.44,
                child: Stack(children: [
                 
                     Container(
                      height: size.height * 0.4,
                      child: ShapeOfView(
                          elevation: 25,
                          shape: ArcShape(
                              direction: ArcDirection.Outside,
                              height: 50,
                              position: ArcPosition.Bottom),
                          child: Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                            image:controller.detales.posterPath==null?const AssetImage('assets/images/placeholder.jpg')as ImageProvider:
                             NetworkImage( imagebase+controller.detales.posterPath.toString()),
                            fit: BoxFit.cover,
                          )))),
                    ),
                  
                  Positioned(
                    right: 0,
                    left: 0,
                    bottom: 0,
                    child: RawMaterialButton(
                      padding: const EdgeInsets.all(10),
                      elevation: 12,
                      onPressed: () {
                        // if (controller.count.value==0) {
                        //   controller.count.value=1;
                        // } else {
                        //   controller.count.value=0;
                        // }
                        print(controller.detales.releaseDate);
                        controller.loadDetales(controller.detales);
                      },
                      shape: const CircleBorder(),
                      fillColor: whiteColor, 
                      child:
                          const Icon(Icons.play_arrow, color: lightColor, size: 60),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                                splashRadius: 15,
                                icon: const Icon(Icons.add,
                                    color: whiteColor, size: 30),
                                onPressed: () {}),
                             CustomText(
                                text: controller.detales.voteAverage!.toStringAsFixed(1), color: lightColor, size: 26)
                          ]),
                    ),
                  ),
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical:10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: (){
                              Get.back();
                            },
                            child: const Icon(Icons.arrow_back,color: whiteColor, size: 30),
                          ),
                          GestureDetector(
                              onTap: (){},
                            child: const Icon(Icons.favorite_outline,color: whiteColor, size: 30),
                          )
                        ]
                      ),
                    ),
                  )
                ]),
              ),
               Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0,horizontal:6),
                child: CustomText(
                    text: controller.detales.title.toString(),
                    color: whiteColor,
                    size: 22,
                    //flow: TextOverflow.ellipsis,
                    maxline: 2,
                    weight: FontWeight.w500),
              ),
              Container(
                  height: size.height * 0.05,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount:controller.detales.genres!=null? controller.detales.genres!.length:3,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return  CustomText(
                          text: controller.detales.genres==null?
                           'Genre':controller.detales.genres![index].name, color: lightColor, size: 16);
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const CustomText(
                          text: ' | ', color: lightColor, size: 16);
                    },
                  )),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 12),
                    child: Container(
                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: (size.width-32) * 0.2,
                            child:Column(
                              children: [
                                const CustomText(
                                  text: 'Year',
                                  color: whiteColor,
                                  size: 16,
                                  flow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height:3),
                                CustomText(
                                  text: controller.detales.releaseDate!.substring(0,4),
                                  color:lightColor,
                                  size: 18,
                                  weight:FontWeight.bold,
                                  flow: TextOverflow.ellipsis,
                                )
                              ]
                            )
                          ),
                          Container(
                            width: (size.width-32) * 0.6,
                            child:Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const CustomText(
                                  text: 'Country',
                                  color: whiteColor,
                                  size: 16,
                                  flow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height:3),
                                CustomText(
                                  text:controller.detales.productionCountries!=null? controller.detales.productionCountries![0].name:'Country',
                                  color:lightColor,
                                  size: 16,
                                  weight:FontWeight.bold,
                                  flow: TextOverflow.ellipsis,
                                )
                              ]
                            )
                          ),
                          Container(
                            width: (size.width-32) * 0.2,
                            child:Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomText(
                                  text: controller.detales.isShow==false? 'Length':'Seasons',
                                  color: whiteColor,
                                  size: 16,
                                  flow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height:3),
                                CustomText(
                                  text: controller.detales.runtime.toString(),
                                  color:lightColor,
                                  size: 18,
                                  weight:FontWeight.bold,
                  
                                )
                              ]
                            )
                          )
                        ]
                      )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Container(
                      height: size.height * 0.12,
                      child: SingleChildScrollView(
                        child:CustomText(
                          text:controller.detales.overview,
                          size:15,
                          color:whiteColor,
                        )
                      ),
                    ),
                  ),
                  Container(
                    child: ContentScroll(
                      isCast: true,
                      isArrow:false,
                      title: 'Cast',
                      detale: controller.detales
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom:12.0),
                    child: Container(
                      child: ContentScroll(
                        isCast: false,
                        isArrow:false,
                        title: 'Recommendations',
                        detale: controller.detales
                      ),
                    ),
                  )
            ]),
          ),
        
      ),
    );
  }
}
