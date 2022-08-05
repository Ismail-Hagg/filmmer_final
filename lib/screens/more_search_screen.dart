import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import '../controllers/more_search_controller.dart';
import '../helper/constants.dart';
import '../widgets/custom_text.dart';
import '../widgets/movie_widget.dart';

class MoreSearchScreen extends StatelessWidget {
  MoreSearchScreen({Key? key}) : super(key: key);

  MoreSearchController controller = Get.put(MoreSearchController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double height = AppBar().preferredSize.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: primaryColor,
      appBar: controller.move.isSearch == false
          ? PreferredSize(
              preferredSize: Size.fromHeight(size.height * 0.075),
              child: AppBar(
                  elevation: 0,
                  backgroundColor: primaryColor,
                  centerTitle: true,
                  title: CustomText(
                    text: controller.move.title,
                    color: lightColor,
                  )),
            )
          : PreferredSize(
              preferredSize: Size.fromHeight(size.height * 0.075),
              child: AppBar(
                  backgroundColor: primaryColor,
                  elevation: 0,
                  title: TextField(
                    cursorColor: lightColor,
                    autofocus: true,
                    style: const TextStyle(color: lightColor),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search',
                      hintStyle: TextStyle(
                        color: lightColor,
                      ),
                    ),
                    onSubmitted: (val) {
                      if (val.trim() != '') {
                        controller.query = val.trim();
                        controller.count = 1;
                        controller.search(controller.count);
                      }
                    },
                  )),
            ),
      body: GetBuilder<MoreSearchController>(
          init: Get.find<MoreSearchController>(),
          builder: (controll) => controll.model.results != null
              ? Column(children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Container(
                      height: size.height * 0.17 - size.height * 0.077,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(
                                splashRadius: 15,
                                icon: const Icon(Icons.arrow_back_ios,
                                    color: lightColor),
                                onPressed: () {
                                  if (controll.move.isSearch == false) {
                                    controll.nextPage(
                                        controll.model.totalPages!.toInt());
                                  } else {
                                    controll.searchUp('up',
                                        controll.model.totalPages!.toInt());
                                  }
                                }),
                            CustomText(
                                text: controll.count.toString(),
                                color: whiteColor),
                            IconButton(
                                splashRadius: 15,
                                icon: const Icon(Icons.arrow_forward_ios,
                                    color: lightColor),
                                onPressed: () {
                                  if (controll.move.isSearch == false) {
                                    controll.prePage();
                                  } else {
                                    controll.searchUp('down',
                                        controll.model.totalPages!.toInt());
                                  }
                                })
                          ]),
                    ),
                  ),
                  Container(
                    height: size.height * 0.83 - size.height * 0.078,
                    child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Wrap(
                            direction: Axis.horizontal,
                            spacing: 2,
                            runSpacing: 2,
                            children: List.generate(
                                controll.model.results!.length, (index) {
                              return GestureDetector(
                                onTap: () {
                                  Get.find<HomeController>().navigatoToDetale(
                                      controll.model.results![index]);
                                },
                                child: MovieWidget(
                                  width: size.width * 0.32,
                                  height: size.height * 0.25,
                                  link: controll.model.results![index]
                                              .posterPath ==
                                          null
                                      ? 'https://www.kuleuven.be/communicatie/congresbureau/fotos-en-afbeeldingen/no-image.png/image'
                                      : imagebase +
                                          controll
                                              .model.results![index].posterPath
                                              .toString(),
                                  color: lightColor,
                                ),
                              );
                            }))),
                  ),
                ])
              : Container()),
    );
  }
}
