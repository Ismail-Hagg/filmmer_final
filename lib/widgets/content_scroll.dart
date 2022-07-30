import 'package:filmmer_final/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'circle_container.dart';
import 'movie_widget.dart';

class ContentScroll extends StatelessWidget {
  final String title;
  final List? movie;
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
        SizedBox(
          height: size.height * 0.28,
          child: ListView.builder(
            itemCount: 10,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: GestureDetector(
                  onTap: () {},
                  child: MovieWidget(
                    width: size.width * 0.4,
                    height: size.height * 0.28,
                    link:
                        'https://www.themoviedb.org/t/p/w600_and_h900_bestv2/ngpLhUccj6mlvAVpiIa7jUcFxhT.jpg',
                    rating: '9.5',
                    color: Colors.orange,
                  ),
                ),
              );
            },
          ),
        ):Container(
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
