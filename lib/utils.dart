import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

int parseColor(colorHex) {
  return (int.parse(colorHex.substring(1, 7), radix: 16) + 0xFF000000);
}

Widget getIcon(iconAsset, color, double size) {
  if (!kIsWeb) {
    iconAsset = "assets/$iconAsset";
  }
  return SvgPicture.asset(
    iconAsset,
    height: size,
    width: size,
    color: (color != null) ? color : Colors.black,
  );
  return Container();
}
