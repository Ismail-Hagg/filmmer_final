import 'dart:io';

import 'package:filmmer_final/controllers/auth_cocontroller.dart';
import 'package:filmmer_final/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import '../helper/constants.dart';
import '../storage_local/user_data.dart';
import 'circle_container.dart';
import 'custom_text.dart';


class Draw extends StatelessWidget {
  const Draw({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Drawer(
       child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              header(size),
               DrawItems()
            ],
          ),
    );
  }
}

Widget header(size){
  return SafeArea(
    child: Container(
      height: size.height*0.27,
      color: primaryColor,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: size.height*0.02),
        child: FutureBuilder(
          future:UserData().getUser,
          builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot){
            if (snapshot.connectionState==ConnectionState.active) {
               return CircleContainer(
                link:'',
            borderColor:lightColor,
            borderWidth:2,
            height:size.height*0.15,
            width:size.height*0.15,
            textUp: 'Username',
            textDown: 'Email',
            sizeUp: 20,
            sizeDown: 14,
            colorUp:Colors.white,
            colorDown:lightColor,
            spaceUp:size.height*0.01,
            child:const Center(child: CircularProgressIndicator(color: lightColor,),),
          );
            } else if (snapshot.connectionState==ConnectionState.done) {
                 
              return GestureDetector(
                onTap:(){
                  print(snapshot.data!.pic[0]);
                },
                child: CircleContainer(
                          borderColor:lightColor,
                          borderWidth:2,
                          height:size.height*0.15,
                          width:size.height*0.15,
                          textUp: snapshot.data!.name,
                          textDown: snapshot.data!.email,
                          sizeUp: 20,
                          sizeDown: 14, 
                          colorUp:Colors.white,
                          colorDown:lightColor,
                          spaceUp:size.height*0.01,
                          fit: BoxFit.cover,
                          // image: DecorationImage(
                          //   fit: BoxFit.cover,
                          //   image:
                          //   snapshot.data!.isLocal==false?
                          //   NetworkImage(snapshot.data!.pic):
                          //   snapshot.data!.pic=='default'?
                          //   const AssetImage('assets/images/placeholder.jpg') as ImageProvider:
                          //   FileImage(File(snapshot.data!.pic.toString()))
                          // ),
                          isLocal:snapshot.data!.isLocal,
                          def:snapshot.data!.pic=='default'?true :false,
                          link: snapshot.data!.pic.toString()
                        ),
              );
            } else {
               return CircleContainer(
                link: '',
            borderColor:lightColor,
            borderWidth:2,
            height:size.height*0.15,
            width:size.height*0.15,
            textUp: 'Username',
            textDown: 'Email',
            sizeUp: 20,
            sizeDown: 14,
            colorUp:Colors.white,
            colorDown:lightColor,
            spaceUp:size.height*0.01,
            // image: const DecorationImage(
            //   fit: BoxFit.cover,
            //   image:AssetImage('assets/images/placeholder.jpg')
            // )
            child:const Icon(Icons.error,color: lightColor));
          
            } 
            }
         
           
        ),
      ),
    ),
  );
  
}

Widget DrawItems(){
  return ListTile(
    title: const CustomText(text: 'Sign Out',),
    onTap: () =>Get.find<AuthController>().signOut()
  );
}