import 'package:flutter/material.dart';
import 'package:rupee_day/util/hex_corlor.dart';

class CommonTextButton extends StatelessWidget {
  final String title;
  final double titleSize;
  final Color titleColor;
  final double width;
  final double height;
  final double borderRadius;
  final Color? backgroundColor;
  final BoxShadow boxShadow;
  final Function()? onTap;

  const CommonTextButton(
    this.title, {
    super.key,
    this.titleSize = 20.0,
    this.titleColor = Colors.white,
    required this.width,
    required this.height,
    required this.borderRadius,
    this.onTap,
    this.backgroundColor,
    this.boxShadow = const BoxShadow(),
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: backgroundColor ?? HexColor('#E09754'),
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [boxShadow],
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontSize: titleSize,
              fontWeight: FontWeight.w600,
              color: titleColor,
            ),
          ),
        ),
      ),
    );
  }
}
