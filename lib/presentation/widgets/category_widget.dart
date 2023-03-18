import 'package:flutter/material.dart';
import 'package:shop_x/presentation/home_page/home_page.dart';



class CategoryIcon extends StatelessWidget {
  const CategoryIcon({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);
  final String icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of
    return Column(
      children: [
        Image.asset(
          icon,
          fit: BoxFit.scaleDown,
          width: 40,
          height: 40,
        ),
        SizedBox(
          height: siz.height * 0.01,
        ),
        Text(text),
      ],
    );
  }
}
