import 'package:flutter/material.dart';
import 'package:self_improvement/components/sizeConfig.dart';

class ReusableCard extends StatelessWidget {
  final Color colour;
  final Widget cardChild;
  final Function onPress;
  ReusableCard({@required this.colour, this.cardChild, this.onPress});
  SizeConfig sizeConfig;
  @override
  Widget build(BuildContext context) {
    sizeConfig = SizeConfig(context);
    return GestureDetector(
      onTap: onPress,
      child: Container(
        margin: EdgeInsets.all(10.0),
        child: cardChild,
        height: sizeConfig.screenHeight * 74,
        padding: EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: colour,
        ),
      ),
    );
  }
}
