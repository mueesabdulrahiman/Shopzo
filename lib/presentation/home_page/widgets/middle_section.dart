import 'package:flutter/material.dart';
import 'package:shop_x/data_layer/data_providers/api_services.dart';
import 'package:shop_x/presentation/widgets/temp_data.dart';

class MiddleSection extends StatelessWidget {
   MiddleSection({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;
  ApiServices apiService = ApiServices();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => SizedBox(
          width: size.width * 0.1,
        ),
        itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              // categoryIcons.contains(categoryIcons[index].text).toList;
            },
            child: categoryIcons[index]),
        itemCount: categoryIcons.length,
      ),
    );
  }

  // Widget _categoriesList() {
  //   return FutureBuilder(
  //       future: apiService.getCategories(),
  //       builder: ((context, snapshot) {
  //         if (snapshot.hasData) {
  //           return snapshot.data;
  //         }
  //         return const Center(
  //           child: CircularProgressIndicator(),
  //         );
  //       }));
  // }
}
