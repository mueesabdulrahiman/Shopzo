part of 'home_page_bloc.dart';

abstract class HomePageState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomePageInitial extends HomePageState {}

class ProductsLoading extends HomePageState {}

class ProductsLoaded extends HomePageState {
  final List<Sample> products;
  //final List<Sample> searchProducts;
  final bool flag;
  ProductsLoaded({required this.products, this.flag = true});
}

class SearchedProducts extends HomePageState {
  final List<Sample> searchProducts;
  SearchedProducts({required this.searchProducts});
}

class ProductsListError extends HomePageState {
  final error;
  ProductsListError({this.error});
}

class ProductSearching extends HomePageState {
  final bool flag;
  ProductSearching({required this.flag});
}

class SearchActive extends HomePageState {}

class SearchLoading extends HomePageState {}

class SearchInactive extends HomePageState {}

class CategoriesLoading extends HomePageState {}

class HomeDataLoaded extends HomePageState {
  final List<Categories> categories;
  final List<Sample> products;
   final List<Sample>categoryProducts;
  HomeDataLoaded({required this.categories, required this.products,  this.categoryProducts = const []});
}
