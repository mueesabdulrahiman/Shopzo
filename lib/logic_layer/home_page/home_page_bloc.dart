import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_x/data_layer/data_providers/api_services.dart';
import 'package:shop_x/data_layer/models/categories.dart';
import 'package:shop_x/data_layer/models/samples/sample.dart';
import 'package:shop_x/logic_layer/home_page/home_page_event.dart';


part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  final ApiServices apiServices;
  List<Sample>? products;
  List<Sample>? searchedProducts;
  List<Categories>? categories;
  List<Sample> clickedCategoryProducts = [];
  bool hasSearchClicked = false;
  bool? searchAnimationClicked;
  bool flag = false;


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

    //on<FetchProducts>((event, emit) async {
      // if (products != null) {
      //   if (products!.isNotEmpty) {
      //     log('fetchProducts');
      //     log(" state : $state");
      //     emit(state);
      //     return;
      //   }
      // }
    //   log('loading');
    //   emit(ProductsLoading());

    //   try {
    //     products = await apiServices.getProducts();
    //     log('product loaded');
    //     // emit(ProductsLoaded(products: products ?? [], flag: flag));
    //     emit(HomeDataLoaded(
    //         categories: categories ?? [],
    //         products: products ?? [],
    //         ));
    //   } catch (e) {
    //     log('ProductsListError1');
    //     emit(ProductsListError(error: e.toString()));
    //   }
    // });

    // search products

    List<Sample>? getSearchedProducts(String? query) {
      if (query != null) {
        final searchedProducts = products?.where((element) {
          return element.name!.toLowerCase().contains(query.toLowerCase());
        }).toList();
        log("searchProducts : $searchedProducts");
        return searchedProducts;
      }
      return null;
    }

    on<SearchProducts>((event, emit) {
      log('hasSearchClicked:$hasSearchClicked');


      if (event.clearQuery == true) {
        log(event.clearQuery.toString());
        hasSearchClicked = false;
        log('clearing');
        //  emit(ProductsLoaded(products: products ?? [], flag: flag));
        emit(HomeDataLoaded(
            categories: categories ?? [],
            products: products ?? [],
            ));
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
        searchedProducts = getSearchedProducts(event.searchQuery);
        //getSearchedProducts();
        log("productss: $searchedProducts");
        log('Products got');

        emit(SearchedProducts(searchProducts: searchedProducts ?? []));
      } catch (e) {
        log('ProductsListError2');
        log(e.toString());
        emit(ProductsListError(error: e.toString()));
      }
      //  }

      // if (currentState is SearchInactive) {
      //   log('SearchActive');
      //   emit(SearchActive());
      // }
    });

    // get categories

    // on<FetchCategories>((event, emit) async {
    //   if (categories != null) {
    //     if (categories!.isNotEmpty) {
    //       log('fetchCategories');
    //       log(" state : $state");
    //       emit(state);
    //       return;
    //     }
    //   }
    //   emit(ProductsLoading());
    //   categories = await apiServices.getCategories();
    //   log('categories loaded');
    //   emit(HomeDataLoaded(
    //       categories: categories ?? [],
    //       products: products ?? [],
    //       ));
    // });

    on<LoadHomeData>((event, emit) async {
      if (categories != null) {
        if (categories!.isNotEmpty) {
          log('state: $state');
          emit(state);
          return;
        }
      }
      emit(ProductsLoading());
      categories = await apiServices.getCategories();
      products = await apiServices.getProducts();
      emit(HomeDataLoaded(
          categories: categories ?? [],
          products: products ?? [],
         ));
    });

    // on<GetCategoryProducts>((event, emit) {
    //   clickedCategoryProducts.clear();
    //   final totalProducts = products ?? [];

    //   clickedCategoryProducts = totalProducts.where((e) {
    //     final categoryNames = e.categories?.map((e) => e.name).toList() ?? [];
    //     return categoryNames.contains(event.categoryName);
    //   }).toList();
    //   log(clickedCategoryProducts.toString());
    //   emit(HomeDataLoaded(
    //       categories: categories ?? [],
    //       products: products ?? [],
    //       categoryProducts: clickedCategoryProducts));
      
    // });
  }
}
