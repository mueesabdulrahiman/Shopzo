import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:shop_x/data_layer/data_providers/api_services.dart';
import 'package:shop_x/data/shop_repository.dart';
import 'package:shop_x/data_layer/models/samples/sample.dart';
import 'package:shop_x/logic_layer/cart_page/cart_page_cubit.dart';
import 'package:shop_x/logic_layer/home_page/home_page_event.dart';
import 'package:shop_x/presentation/cart_page/cart_page.dart';
import 'package:shop_x/presentation/home_page/home_page.dart';

import 'home_page_event.dart';

part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  final ApiServices apiServices;
  List<Sample>? products;
  List<Sample>? searchedProducts;
  bool hasSearchClicked = false;
  bool? searchAnimationClicked;
  bool flag = false;

  //static ValueNotifier<bool> searchNotifier = ValueNotifier(false);

  HomePageBloc({required this.apiServices}) : super(HomePageInitial()) {
    // @override
    // Stream<HomePageState> mapEventToState(HomePageEvents event) async* {

    //   switch (event) {
    //     case HomePageEvents.fetchProducts:
    //      if(products != null){
    //     if (products!.isNotEmpty) {
    //     yield state;
    //     return;
    //   }
    //   }
    //       yield ProductsLoading();
    //       try {
    //         products = await apicalls.getData();
    //         yield ProductsLoaded(products: products);
    //       } catch (e) {
    //         yield ProductsListError();
    //       }
    //       break;
    //   }
    // }

    // get products

    on<FetchProducts>((event, emit) async {
      if (products != null) {
        if (products!.isNotEmpty) {
          log('fetchProducts');
          log(" state : $state");
          emit(state);
          return;
        }
      }
      log('loading');
      emit(ProductsLoading());

      try {
        products = await apiServices.getProducts();
        log('product loaded');
        emit(ProductsLoaded(products: products ?? [], flag: flag));
      } catch (e) {
      
        log('ProductsListError1');
        emit(ProductsListError(error: e.toString()));
      }
    });

    // search products    

    List<Sample>? getSearchedProducts(String query) {
      final searchedProducts = products?.where((element) {
        return element.name!.toLowerCase().contains(query.toLowerCase());
      }).toList();
      log("searchProducts : $searchedProducts");
      return searchedProducts;
    }

    on<SearchProducts>((event, emit) {
      log('hasSearchClicked:$hasSearchClicked');

      final currentState = state;

      if (event.clearQuery == true) {
        log(event.clearQuery.toString());
        hasSearchClicked = false;
        log('clearing');
        emit(ProductsLoaded(products: products ?? [], flag: flag));
        return;
      }

      if (hasSearchClicked == false) {
        log('started');
        hasSearchClicked = true;
        emit(SearchActive());
        return;
      }

      // if (currentState is SearchActive || currentState is SearchedProducts) {
      log('ProductSearching');

      try {
        searchedProducts?.clear();
        log('searchedProducts: $searchedProducts');
        emit(SearchLoading());
        searchedProducts = getSearchedProducts(event.searchQuery!);
        //getSearchedProducts();
        log("productss: $searchedProducts");
        log('Products got');

        emit(SearchedProducts(searchProducts: searchedProducts ?? []));
      } catch (e) {
        log('ProductsListError2');
        emit(ProductsListError(error: e.toString()));
      }
      //  }

      // if (currentState is SearchInactive) {
      //   log('SearchActive');
      //   emit(SearchActive());
      // }
    });
  }
}
