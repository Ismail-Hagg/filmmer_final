import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pod_player/pod_player.dart';
import 'package:youtube/youtube_thumbnail.dart';
import '../controllers/trailer_controller.dart';
import '../helper/constants.dart';
import '../widgets/custom_text.dart';


class TrailerScreen extends StatelessWidget {
  const TrailerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: GetBuilder<TrailerController>(
          init: Get.put(TrailerController()),
          builder: (controller)=>Column(
            children: [
              PodVideoPlayer(controller: controller.controller),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: CustomText(
                  text: controller.title,
                  color:whiteColor,
                  size: size.width * 0.04,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: controller.lst.length,
                  itemBuilder: (context,index){
                    return InkWell(
                onTap: (){
                  controller.change(controller.lst[index].key.toString(),controller.lst[index].name.toString(),);
                },
                child: SizedBox(
                  height: ((size.height*0.648)-20)*0.2,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: size.width*0.3,
                          child: Image.network(YoutubeThumbnail(youtubeId: controller.lst[index].key).hd(),fit: BoxFit.cover,),
                        ),
                        const SizedBox(width: 30,),
                        Container(
                          alignment: Alignment.center,
                          width: (size.width*0.7)-40,
                          height: ((size.height*0.648)-20)*0.3,
                          child:  CustomText(
                            text: controller.lst[index].name,
                            color: Colors.white,
                            size:size.width * 0.04,
                          ),
                        )
                      ],
                    ),
                  ),
                 
                ),
              );
                  },
                ),
              )
            ]
          ),
        ),
      ),
    );
  }
}