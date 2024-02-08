import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_x/logic_layer/home_page/home_page_bloc.dart';
import 'package:shop_x/logic_layer/home_page/home_page_event.dart';
import 'package:shop_x/utils/debouncer.dart';
import 'package:sizer/sizer.dart';

class searchWidget extends StatelessWidget {
  searchWidget({
    Key? key,
  }) : super(key: key);

  final _debounce = Debouncer(milliseconds: 500);
  bool folded = true;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomePageBloc, HomePageState>(builder: (context, state) {
      if (state is SearchActive || state is SearchedProducts) {
        folded = false;
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 5.sp),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            width: folded ? 5.w : 70.w,
            height: 0.5.h,
            decoration: BoxDecoration(
              color: !folded
                  ? Theme.of(context).scaffoldBackgroundColor
                  : Theme.of(context).appBarTheme.backgroundColor,
              borderRadius: BorderRadius.circular(32),
            ),
            child:
                Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 10.sp),
                  // color: Theme.of(context).scaffoldBackgroundColor,
                  child: folded
                      ? null
                      : TextField(
                          autofocus: true,
                          decoration: InputDecoration(
                            // fillColor:
                            //     Theme.of(context).scaffoldBackgroundColor,
                            // filled: true,
                            //  Theme.of(context).scaffoldBackgroundColor,
                            hintText: 'Enter Search Product',
                            hintStyle:
                                TextStyle(fontFamily: 'Lato', fontSize: 12.sp),
                            border: InputBorder.none,
                          ),
                          onChanged: (query) {
                            if (query.isNotEmpty) {
                              _debounce.run(() {
                                context
                                    .read<HomePageBloc>()
                                    .add(SearchProducts(searchQuery: query));
                              });
                            }
                          },
                        ),
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                decoration: BoxDecoration(
                    color: folded
                        ? Colors.grey[50]
                        : Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(32.sp)),
                child: GestureDetector(
                  child: Padding(
                    padding: EdgeInsets.all(8.0.sp),
                    child: folded
                        ? Icon(
                            Icons.search,
                            size: 17.sp,
                            color:
                                Theme.of(context).appBarTheme.foregroundColor,
                          )
                        : Icon(
                            Icons.close,
                            size: 17.sp,
                            color:
                                Theme.of(context).appBarTheme.foregroundColor,
                          ),
                  ),
                  onTap: () {
                    context
                        .read<HomePageBloc>()
                        .add(SearchProducts(clearQuery: folded ? false : true));
                  },
                ),
              ),
            ]),
          ),
        );
      } else {
        folded = true;
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 5.sp),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            width: folded ? 11.w : 70.w,
            height: 0.5.h,
            decoration: BoxDecoration(
              color: !folded
                  ? Colors.grey[100]
                  : Theme.of(context).appBarTheme.backgroundColor,
              borderRadius: BorderRadius.circular(32.sp),
            ),
            child: Row(children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 16.sp),
                  child: folded
                      ? null
                      : const TextField(
                          decoration: InputDecoration(
                            hintText: 'Enter Search Product',
                            hintStyle: TextStyle(fontFamily: 'Lato'),
                            border: InputBorder.none,
                          ),
                        ),
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                decoration: BoxDecoration(
                    color: folded
                        ? Theme.of(context).appBarTheme.backgroundColor
                        : Colors.grey[100],
                    borderRadius: BorderRadius.circular(32)),
                child: GestureDetector(
                  child: Padding(
                    padding: EdgeInsets.all(8.sp),
                    child: folded
                        ? Icon(Icons.search, size: 17.sp)
                        : Icon(
                            Icons.close,
                            size: 17.sp,
                            color:
                                Theme.of(context).appBarTheme.foregroundColor,
                          ),
                  ),
                  onTap: () {
                    context.read<HomePageBloc>().add(SearchProducts());
                  },
                ),
              ),
            ]),
          ),
        );
      }
    });
  }
}
