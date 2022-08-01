import 'package:filmmer_final/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../helper/constants.dart';
import '../models/movie_model.dart';
import '../screens/movie_detale.dart';
import 'circle_container.dart';
import 'movie_widget.dart';

class ContentScroll extends StatelessWidget {
  final String title;
  final Rx<HomeTopMovies>? movie; 
  final List? cast;
  final String? link;
  final bool isArrow;
  final bool isCast;
  const ContentScroll({Key? key,required this.title, this.movie, this.cast, this.link, required this.isArrow, required this.isCast}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      children: [
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:  [
                 Container(
                  width: (size.width-30)*0.9,
                   child: CustomText(
                    text: title,
                    color: Colors.white,
                    size: 22,
                    weight: FontWeight.w600,
                    flow: TextOverflow.ellipsis,
                ),
                 ),
                isArrow==true?
                Container(
                   width: (size.width-30)*0.1,
                  child: GestureDetector(
                    onTap:(){
                      
                    },
                      child:const Icon(Icons.arrow_forward,
                          color: Colors.white, size: 30)),
                ):Container()
              ]),
        ),
        const SizedBox(height: 15),
        isCast==false?
        // display list of Movies
        Obx(()=>
           SizedBox(
            height: size.height * 0.28,
            child: ListView.builder(
              itemCount:movie!.value.results!.isNotEmpty? movie!.value.results!.length:movie!.value.initial!.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: GestureDetector(
                    onTap: () {
                      print(movie!.value.results![index].title);
                      Get.to(() => MovieDetale(imageLink:imagebase+movie!.value.results![index].posterPath.toString()));
                    },
                    child: MovieWidget(
                      width: size.width * 0.4,
                      height: size.height * 0.28,
                      link:movie!.value.results!.isNotEmpty? movie!.value.results![index].posterPath==null?
                      'https://www.kuleuven.be/communicatie/congresbureau/fotos-en-afbeeldingen/no-image.png/image':
                          imagebase+movie!.value.results![index].posterPath.toString():movie!.value.initial![index],
                      rating:movie!.value.results!.isNotEmpty?movie!.value.results![index].voteAverage??'0':'0',
                      color: Colors.orange,
                    ),
                  ),
                );
              },
            ),
          ),
        ):
        // display list of Movies
        Container(
          height: size.height * 0.15,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount:10,
            itemBuilder:(context,index){
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: GestureDetector(
                  onTap: () {},
                  child: CircleContainer(
                    textUp: 'Actor Name',
                    colorUp: Colors.orange,
                    sizeUp: 15,
                    textDown: 'Rple Played',
                    colorDown: Colors.white,
                    sizeDown: 11,
                    width: size.height * 0.1,
                    height: size.height * 0.1,
                    color: Colors.orange,
                    spaceUp: 10,
                  ),
                ),
              );
            }
          ),
        )
      ],
    );
  }
}
