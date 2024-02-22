import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_x/data_layer/models/categories.dart';
import 'package:shop_x/logic_layer/home_page/home_page_bloc.dart';
import 'package:shop_x/presentation/home_page/widgets/bottom_section.dart';
import 'package:shop_x/presentation/widgets/category_widget.dart';
import 'package:sizer/sizer.dart';

class MiddleSection extends StatelessWidget {
  const MiddleSection({super.key, required this.size, required this.categories});

  final List<Categories> categories;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.sp),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => SizedBox(
          width: 10.w,
        ),
        itemBuilder: (context, index) {
          final data = categories[index];
          return GestureDetector(
              onTap: () {
                BottomSection.clickedCategoryProducts.value.clear();
                final totalProducts =
                    BlocProvider.of<HomePageBloc>(context).products ?? [];

                BottomSection.clickedCategoryProducts.value =
                    totalProducts.where((e) {
                  final categoryNames =
                      e.categories?.map((e) => e.name).toList() ?? [];
                  return categoryNames.contains(data.categoryName);
                }).toList();
                BottomSection.clickedCategoryProducts.notifyListeners();
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
