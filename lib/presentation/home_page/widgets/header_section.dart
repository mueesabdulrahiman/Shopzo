import 'package:flutter/material.dart';
import 'package:shop_x/presentation/widgets/temp_data.dart';

class TopSection extends StatelessWidget {
  const TopSection({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      padding: const EdgeInsets.only(top: 5, left: 5),
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) => bannerImages[index],
      itemCount: bannerImages.length,
      separatorBuilder: (context, index) => SizedBox(
        width: size.width * 0.03,
      ),
    );
  }
}
