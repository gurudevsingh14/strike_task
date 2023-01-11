import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  double width;
  double height;
  ShapeBorder shape;

  ShimmerWidget.rectangle({required this.width,required this.height}):this.shape=  RoundedRectangleBorder();

  ShimmerWidget.circular({required this.width,required this.height,this.shape=const CircleBorder()});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        child: Container(
          width: width,
          height: height,
          decoration: ShapeDecoration(
              color: Colors.grey.shade400,
              shape: shape,
          )
        ),
        baseColor: Colors.grey.shade400,
        highlightColor: Colors.grey.shade300
    );
  }
}
