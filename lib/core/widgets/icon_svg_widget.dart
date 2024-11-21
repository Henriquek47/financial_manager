import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class IconSvgWidget extends StatelessWidget {
  final String asset;
  final Color color;
  final double size;
  final VoidCallback? onTap;
  const IconSvgWidget(
      {super.key,
      required this.asset,
      required this.color,
      required this.size,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SvgPicture.asset(
        asset,
        color: color,
         height: size,
        width: size,
      ),
    );
  }
}
