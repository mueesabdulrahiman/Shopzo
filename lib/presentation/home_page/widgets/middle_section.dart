import 'package:flutter/material.dart';
import 'package:shop_x/presentation/widgets/temp_data.dart';

class MiddleSection extends StatelessWidget {
  const MiddleSection({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => SizedBox(
          width: size.width * 0.1,
        ),
        itemBuilder: (context, index) => categoryIcons[index],
        itemCount: categoryIcons.length,
      ),
    );
  }
}
