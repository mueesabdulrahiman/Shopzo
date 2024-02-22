import 'package:flutter/material.dart';
import 'package:shop_x/presentation/home_page/home_page.dart';
import 'package:sizer/sizer.dart';

class CategoryIcon extends StatelessWidget {
  const CategoryIcon({
    Key? key,
    required this.icon,
    required this.text,
    required this.size,
  }) : super(key: key);
  final String icon;
  final String text;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.network(
          icon,
          fit: BoxFit.scaleDown,
          width: 10.w,
          height: 7.h,
        ),
        SizedBox(height: 1.h),
        Text(
          text,
          style: TextStyle(
              color: Theme.of(context).textTheme.bodyLarge?.color,
              fontFamily: 'Lato',
              fontWeight: FontWeight.w600,
              fontSize: 10.sp),
        ),
      ],
    );
  }
}
