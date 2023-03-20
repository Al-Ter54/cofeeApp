import '../../../models/category.dart';

abstract class CategoryState {}

class CategoryStateLoading extends CategoryState {}

class CategoryStateLoaded extends CategoryState {
  CategoryStateLoaded(this.categories);

  final List<Category> categories;
}

class CategoryStateError extends CategoryState {}
