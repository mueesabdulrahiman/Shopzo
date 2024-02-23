import 'package:equatable/equatable.dart';

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

class SearchAnimation extends HomePageEvent {}

class FetchCategories extends HomePageEvent {}

class LoadHomeData extends HomePageEvent {}

class GetCategoryProducts extends HomePageEvent {
  final String categoryName;
  GetCategoryProducts({required this.categoryName});
}
