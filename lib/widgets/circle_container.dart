import 'dart:io';

import 'package:filmmer_final/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class CircleContainer extends StatelessWidget {
  final double? height;
  final double? width;
  final double? borderWidth;
  final Color? borderColor;
  final Color? color;
  final String? textUp;
  final String? textDown;
  final int? maxUp;
  final int? maxDown;
  final Color? colorUp;
  final Color? colorDown;
  final double? sizeUp;
  final double? sizeDown;
  final FontWeight? weightUp;
  final FontWeight? weightDown;
  final TextOverflow? flowUp;
  final TextOverflow? flowDown;
  final double? spaceUp;
  final Widget? child;
  final String? path;
  final String link;
  final BoxFit? fit;
  final bool? isLocal;
  final bool? def;
  final DecorationImage? image;
  const CircleContainer(
      {Key? key,
      this.height,
      this.width,
      this.borderWidth,
      this.borderColor,
      this.color,
      this.textUp,
      this.textDown,
      this.maxUp,
      this.maxDown,
      this.colorUp,
      this.colorDown,
      this.sizeUp,
      this.sizeDown,
      this.weightUp,
      this.weightDown,
      this.flowUp,
      this.flowDown, this.spaceUp, this.child, this.path, required this.link, this.fit, this.isLocal, this.def, this.image, })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
             image: image??DecorationImage(
              image:isLocal==false?NetworkImage(link.toString()):
              link!=''? link[0]=='a'?
              AssetImage(link.toString()) as ImageProvider:FileImage(File(link.toString())): const AssetImage('assets/images/placeholder.jpg') ,
              fit: fit,
             ),
            shape: BoxShape.circle,
            color: color ?? Colors.transparent,
            border: Border.all(
                color: borderColor ?? Colors.transparent,
                width: borderWidth ?? 0.0),
          ),
          child: child??Container(), 
        ),
        SizedBox(height: spaceUp??0.0,),
        textUp!=null? Align(
          alignment: Alignment.center,
          child: CustomText(
            text: textUp,
            size: sizeUp,
            color: colorUp,
            flow: flowUp,
            maxline: maxUp,
            weight:weightUp,
          ),
        ):Container(),
        textDown!=null? Align(
          alignment: Alignment.center,
          child: CustomText(
            text: textDown,
            size: sizeDown,
            color: colorDown,
            flow: flowDown,
            maxline: maxDown,
            weight:weightDown,
          ),
        ):Container(),
      ],
    );
  }
}
