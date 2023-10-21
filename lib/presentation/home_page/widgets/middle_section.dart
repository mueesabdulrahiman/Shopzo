import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_x/data_layer/models/categories.dart';
import 'package:shop_x/logic_layer/home_page/home_page_bloc.dart';
import 'package:shop_x/presentation/home_page/widgets/bottom_section.dart';
import 'package:shop_x/presentation/widgets/category_widget.dart';

class MiddleSection extends StatelessWidget {
  const MiddleSection({Key? key, required this.size, required this.categories})
      : super(key: key);

  final List<Categories> categories;
  final Size size;

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
        itemBuilder: (context, index) {
          final data = categories[index];
          return GestureDetector(
              onTap: () {
                log('clicked');
                // context.read<HomePageBloc>().add(GetCategoryProducts(categoryName: data.categoryName!));
                BottomSection.clickedCategoryProducts.value.clear();
                final totalProducts =
                    BlocProvider.of<HomePageBloc>(context).products ?? [];

                BottomSection.clickedCategoryProducts.value =
                    totalProducts.where((e) {
                  final categoryNames =
                      e.categories?.map((e) => e.name).toList() ?? [];
                  return categoryNames.contains(data.categoryName);
                }).toList();
                BottomSection.clickedCategoryProducts.notifyListeners;
                log(BottomSection.clickedCategoryProducts.toString());
              },
              child: CategoryIcon(
                icon: data.image!.src!,
                text: data.categoryName!,
                size: size,
              ));
        },
        itemCount: categories.length,
      ),
    );
  }
}
