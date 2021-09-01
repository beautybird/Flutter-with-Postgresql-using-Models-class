import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';

class ClayContainerDesign extends StatelessWidget {
  var containerColor;
  double? borderRadius;
  BorderRadius? customBorderRadius;
  CurveType? curveType;
  double? height;
  String? textDetails;
  double? clayTextSize;
  Color? clayTextColor;
  Color? clayTextColorText;

  ClayContainerDesign(
      {this.containerColor,
        this.borderRadius,
        this.customBorderRadius,
        this.curveType,
        this.height,
        this.textDetails,
        this.clayTextSize,
        this.clayTextColor,
        this.clayTextColorText});

  @override
  Widget build(BuildContext context) {
    return ClayContainer(
      color: containerColor,
      borderRadius: borderRadius,
      customBorderRadius: customBorderRadius,
      curveType: curveType,
      height: height,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: ClayText(
          textDetails ?? '',
          emboss: true,
          size: clayTextSize,
          depth: 60,
          style: TextStyle(
            fontStyle: FontStyle.italic,
            letterSpacing: 1.0,
          ),
          color: clayTextColor,
          textColor: clayTextColorText,
        ),
      ),
    );
  }
}
