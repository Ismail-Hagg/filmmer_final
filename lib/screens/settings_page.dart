import 'package:filmmer_final/screens/test.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helper/constants.dart';
import '../models/user_model.dart';
import '../storage_local/user_data.dart';
import '../widgets/circle_container.dart';
import '../widgets/custom_text.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var topPadding = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
          backgroundColor: primaryColor,
          elevation: 0,
          centerTitle: true,
          ),
      body: Column(
        children: [
          Container(
            height: size.height * 0.3,
            // color:Colors.red,
            child: Center(
                child: FutureBuilder(
              future: UserData().getUser,
              builder:
                  (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Stack(
                    children: [
                      CircleContainer(
                        fit: BoxFit.cover,
                        link: snapshot.data!.pic,
                        isLocal: snapshot.data!.isLocal,
                        color: whiteColor,
                        width: size.width * 0.5,
                        height: size.width * 0.5,
                        borderColor: lightColor,
                        borderWidth: 2,
                      ),
                      Positioned(
                        bottom: size.width * 0.11,
                        right: size.width * 0.31,
                        child: GestureDetector(
                          onTap: (){
                            Get.to(()=>Test());
                          },
                          child: CircleContainer(
                            link:'',
                            width: size.width * 0.08,
                            height: size.width * 0.08,
                            color:Colors.black,
                            borderColor:whiteColor,
                            borderWidth: 1,
                          ),
                        ),
                      )
                    ],
                  );
                }
                return const Center(
                    child: CircularProgressIndicator(color: lightColor));
              },
            )),
          ),
        ],
      ),
    );
  }
}



