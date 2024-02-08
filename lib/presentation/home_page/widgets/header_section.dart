import 'package:flutter/material.dart';
import 'package:shop_x/presentation/widgets/temp_data.dart';
import 'package:sizer/sizer.dart';

class TopSection extends StatelessWidget {
  const TopSection({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      padding: EdgeInsets.only(top: 0.5.h, left: 2.w),
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) => 
      bannerImages[index],
      itemCount: bannerImages.length,
      separatorBuilder: (context, index) => SizedBox(
        width: 2.w,
      ),
    );
  }

 
}
