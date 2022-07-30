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
      this.flowDown, this.spaceUp, this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color ?? Colors.transparent,
            border: Border.all(
                color: borderColor ?? Colors.transparent,
                width: borderWidth ?? 0.0),
          ),
          child: child??Container(),
        ),
        SizedBox(height: spaceUp??0.0,),
        CustomText(
          text: textUp,
          size: sizeUp,
          color: colorUp,
          flow: flowUp,
          maxline: maxUp,
          weight:weightUp,
        ),
        CustomText(
          text: textDown,
          size: sizeDown,
          color: colorDown,
          flow: flowDown,
          maxline: maxDown,
          weight:weightDown,
        )
      ],
    );
  }
}
