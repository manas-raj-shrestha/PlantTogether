import 'package:flutter/material.dart';

int parseColor(colorHex) {
  return (int.parse(colorHex.substring(1, 7), radix: 16) + 0xFF000000);
}

Widget getIcon(iconAsset, color, double size) {
  // return SvgPicture.asset(
  //   iconAsset,
  //   height: size,
  //   width: size,
  //   color: (color != null) ? color : Colors.black,
  // );
  return Container();
}
