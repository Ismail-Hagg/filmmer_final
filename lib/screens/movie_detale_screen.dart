import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shape_of_view_null_safe/shape_of_view_null_safe.dart';
import '../controllers/movie_detale_controller.dart';
import '../helper/constants.dart';
import '../helper/countries.dart';
import '../widgets/content_scroll.dart';
import '../widgets/custom_text.dart';

class MovieDetale extends StatelessWidget {
  final String tag;
  const MovieDetale({Key? key, required this.tag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: mainColor,
      body: SingleChildScrollView(
        child: GetBuilder<MovieDetaleController>(
          init: Get.find<MovieDetaleController>(),
          builder: (controller) => Column(children: [
            SizedBox(
              height: size.height * 0.44,
              child: Stack(children: [
                SizedBox(
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
                        image: controller.detales.posterPath == null
                            ? const AssetImage('assets/images/placeholder.jpg')
                                as ImageProvider
                            : NetworkImage(imagebase +
                                controller.detales.posterPath.toString()),
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
                      controller.goToTrailer();
                    },
                    shape: const CircleBorder(),
                    fillColor: whiteColor,
                    child: controller.load == 0
                        ? const Center(
                            child: CircularProgressIndicator(color: lightColor),
                          )
                        : const Icon(Icons.play_arrow,
                            color: lightColor, size: 50),
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
                              onPressed: () => controller.watch()),
                          CustomText(
                              text: controller.detales.voteAverage!
                                  .toStringAsFixed(1),
                              color: lightColor,
                              size: size.width * 0.05,)
                        ]),
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: const Icon(Icons.arrow_back,
                                color: whiteColor, size: 30),
                          ),
                          Obx(
                            () => GestureDetector(
                              onTap: () => controller.sendObject(),
                              child: controller.flip.value == 0
                                  ? const Icon(Icons.favorite_outline,
                                      color: whiteColor, size: 30)
                                  : const Icon(Icons.favorite,
                                      color: lightColor, size: 30),
                            ),
                          )
                        ]),
                  ),
                )
              ]),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 6),
              child: CustomText(
                  text: controller.detales.title.toString(),
                  color: whiteColor,
                  size: size.width * 0.055,
                  maxline: 2,
                  weight: FontWeight.w500),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: SizedBox(
                  height: size.height * 0.05,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.detales.genres != null
                        ? controller.detales.genres!.length
                        : 3,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return CustomText(
                          text: controller.detales.genres == null
                              ? 'Genre'
                              : controller.detales.genres![index].name,
                          color: lightColor,
                          size: size.width * 0.04);
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const CustomText(
                          text: ' | ', color: lightColor, size: 16);
                    },
                  )),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                SizedBox(
                    width: (size.width - 32) * 0.2,
                    child: Column(children: [
                      CustomText(
                        text: 'Year'.tr,
                        color: whiteColor,
                        size: size.width * 0.04,
                        flow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 3),
                      CustomText(
                        text: controller.detales.productionCountries == null
                            ? 'Year'.tr
                            : controller.detales.releaseDate!,
                        color: lightColor,
                        size: size.width * 0.035,
                        weight: FontWeight.bold,
                        flow: TextOverflow.ellipsis,
                      )
                    ])),
                SizedBox(
                    width: (size.width - 32) * 0.6,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            text: 'country'.tr,
                            color: whiteColor,
                            size: size.width * 0.04,
                            flow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 3),
                          CustomText(
                            align: TextAlign.left,
                            text: controller.detales.productionCountries ==
                                    null
                                ? 'country'.tr
                                : controller.detales.originCountry != ''
                                    ? countries[
                                        controller.detales.originCountry]
                                    : controller.detales
                                        .productionCountries![0].name,
                            color: lightColor,
                            size: size.width * 0.035,
                            weight: FontWeight.bold,
                            flow: TextOverflow.ellipsis,
                          )
                        ])),
                SizedBox(
                    width: (size.width - 32) * 0.2,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            text: controller.detales.isShow == false
                                ? 'length'.tr
                                : 'seasons'.tr,
                            color: whiteColor,
                            size: size.width * 0.04,
                            flow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 3),
                          CustomText(
                            text: controller.detales.runtime.toString(),
                            color: lightColor,
                            size: size.width * 0.035,
                            weight: FontWeight.bold,
                          )
                        ]))
              ]),
            ),
            controller.detales.overview == ''
                ? Container()
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: SizedBox(
                      height: size.height * 0.12,
                      child: SingleChildScrollView(
                          child: CustomText(
                        text: controller.detales.overview,
                        size: size.width * 0.035,
                        color: whiteColor,
                      )),
                    ),
                  ),
            controller.detales.cast!.cast!.isEmpty
                ? Container()
                : ContentScroll(
                    isCast: true,
                    isArrow: false,
                    title: 'cast'.tr,
                    detale: controller.detales),
            controller.detales.recomendation!.results!.isEmpty
                ? Container()
                : Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: ContentScroll(
                        isCast: false,
                        isArrow: false,
                        title: 'recommendations'.tr,
                        detale: controller.detales),
                  )
          ]),
        ),
      ),
    );
  }
}
