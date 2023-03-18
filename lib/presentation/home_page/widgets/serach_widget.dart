import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_x/logic_layer/home_page/home_page_bloc.dart';
import 'package:shop_x/logic_layer/home_page/home_page_event.dart';
import 'package:shop_x/utils/debouncer.dart';

class searchWidget extends StatelessWidget {
   searchWidget({
    Key? key,
  }) : super(key: key);

  final _debounce = Debouncer(milliseconds: 500);
  late bool folded;


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomePageBloc, HomePageState>(builder: (context, state) {
      if (state is SearchActive || state is SearchedProducts) {
        log('Search :$folded');

        folded = false;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            width: folded ? 45 : 280,
            height: 56,
            decoration: BoxDecoration(
              color: !folded ? Colors.grey[100] : Colors.grey[50],
              borderRadius: BorderRadius.circular(32),
            ),
            child: Row(children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: 16),
                  child: folded
                      ? null
                      : TextField(
                          autofocus: true,
                          decoration: const InputDecoration(
                            hintText: 'Enter Search Product',
                            border: InputBorder.none,
                          ),
                          onChanged: (query) {
                            if (query.isEmpty) {
                              context
                                  .read<HomePageBloc>()
                                  .add(FetchProducts());
                            }

                            if (query.isNotEmpty) {
                              _debounce.run(() {
                                context.read<HomePageBloc>().add(
                                    SearchProducts(searchQuery: query));
                              });
                            }
                          },
                        ),
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                decoration: BoxDecoration(
                    color: folded ? Colors.grey[50] : Colors.grey[100],
                    borderRadius: BorderRadius.circular(32)),
                child: GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: folded
                        ? const Icon(Icons.search)
                        : const Icon(Icons.close),
                  ),
                  onTap: () {
                    context.read<HomePageBloc>().add(SearchProducts(
                        clearQuery: folded ? false : true));
                  },
                ),
              ),
            ]),
          ),
        );
      } else {
        folded = true;
        log("isSearchelse: $folded");
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            width: folded ? 45 : 280,
            height: 56,
            decoration: BoxDecoration(
              color: !folded ? Colors.grey[100] : Colors.grey[50],
              borderRadius: BorderRadius.circular(32),
            ),
            child: Row(children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: 16),
                  child: folded
                      ? null
                      : const TextField(
                          decoration: InputDecoration(
                            hintText: 'Enter Search Product',
                            border: InputBorder.none,
                          ),
                        ),
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                decoration: BoxDecoration(
                    color: folded ? Colors.grey[50] : Colors.grey[100],
                    borderRadius: BorderRadius.circular(32)),
                child: GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: folded
                        ? const Icon(Icons.search)
                        : const Icon(Icons.close),
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
