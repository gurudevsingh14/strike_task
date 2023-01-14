import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  double width;
  double height;
  ShapeBorder shape;

  ShimmerWidget.rectangle({required this.width,required this.height}):shape=  RoundedRectangleBorder();

  ShimmerWidget.circular({required this.width,required this.height,this.shape=const CircleBorder()});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        child: Container(
          width: width,
          height: height,
          decoration: ShapeDecoration(
              color: Colors.black.withOpacity(0.08),
              shape: shape,
          )
        ),
        baseColor: Colors.black54,
        highlightColor: Colors.black
    );
  }
}
