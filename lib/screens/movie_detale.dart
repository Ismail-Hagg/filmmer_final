import 'package:flutter/material.dart';
import 'package:shape_of_view_null_safe/shape_of_view_null_safe.dart';

import '../helper/constants.dart';
import '../widgets/circle_container.dart';

class MovieDetale extends StatelessWidget {
  final String imageLink;
  const MovieDetale({Key? key, required this.imageLink}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.48,
            child: Stack(children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.45,
                child: ShapeOfView(
                    elevation: 25,
                    shape: ArcShape(
                        direction: ArcDirection.Outside,
                        height: 50,
                        position: ArcPosition.Bottom),
                    child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                      image: NetworkImage(imageLink),
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
                  onPressed: () {},
                  // onPressed:controller.loading==0? () => controller.trailer.results!.isEmpty==true?(()=>{
                  //   Get.snackbar('', 'No Trailer Available',backgroundColor: lightColor,colorText: const Color.fromARGB(255, 255, 255, 255)),
                  //   print('object')
                  // }):Get.to(()=> TrailerPage()):(){},
                  shape: const CircleBorder(),
                  fillColor: Colors.white,
                  child:
                      const Icon(Icons.play_arrow, color: lightColor, size: 60),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Icon(Icons.add), Icon(Icons.add)]),
                ),
              )
            ]),
          ),
         
        ]),
      ),
    );
  }
}
