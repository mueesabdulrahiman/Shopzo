import 'package:equatable/equatable.dart';
// import 'package:flutter/material.dart';

// enum HomePageEvents {
//   fetchProducts,
//   searchProducts(isSearch: bool);
// }

abstract class HomePageEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchProducts extends HomePageEvent {}

class SearchProducts extends HomePageEvent {
  final String? searchQuery;
  final bool? clearQuery;
  SearchProducts({this.searchQuery, this.clearQuery});
}

class SearchAnimation extends HomePageEvent {
  // final bool flag;
  // SearchAnimation({required this.flag});
}

class FetchCategories extends HomePageEvent {}

class LoadHomeData extends HomePageEvent {}

class GetCategoryProducts extends HomePageEvent {
  final String categoryName;
  GetCategoryProducts({required this.categoryName});
}
