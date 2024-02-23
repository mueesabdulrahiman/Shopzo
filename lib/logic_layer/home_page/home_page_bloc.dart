import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_x/data_layer/data_providers/api_services.dart';
import 'package:shop_x/data_layer/models/categories.dart';
import 'package:shop_x/data_layer/models/item/product.dart';
import 'package:shop_x/logic_layer/home_page/home_page_event.dart';

part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  final ApiServices apiServices;
  List<Product>? products;
  List<Product>? searchedProducts;
  List<Categories>? categories;
  List<Product> clickedCategoryProducts = [];
  bool hasSearchClicked = false;
  bool? searchAnimationClicked;
  bool flag = false;

  HomePageBloc({required this.apiServices}) : super(HomePageInitial()) {
    // search products

    List<Product>? getSearchedProducts(String? query) {
      if (query != null) {
        final searchedProducts = products?.where((element) {
          return element.name!.toLowerCase().contains(query.toLowerCase());
        }).toList();
        return searchedProducts;
      }
      return null;
    }

    on<SearchProducts>((event, emit) {
      if (event.clearQuery == true) {
        hasSearchClicked = false;
        emit(HomeDataLoaded(
          categories: categories ?? [],
          products: products ?? [],
        ));
        return;
      }

      if (hasSearchClicked == false) {
        hasSearchClicked = true;
        emit(SearchActive());
        return;
      }

      try {
        searchedProducts?.clear();
        emit(SearchLoading());
        searchedProducts = getSearchedProducts(event.searchQuery);

        emit(SearchedProducts(searchProducts: searchedProducts ?? []));
      } catch (e) {
        emit(ProductsListError(error: e.toString()));
      }
    });

    on<LoadHomeData>((event, emit) async {
      if (categories != null) {
        if (categories!.isNotEmpty) {
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
  }
}
