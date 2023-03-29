import 'package:cofee/features/categories/bloc/category_events.dart';
import 'package:cofee/features/categories/bloc/category_states.dart';
import 'package:cofee/models/category.dart';
import 'package:cofee/models/product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../services/cart_service.dart';
import '../../../services/category_service.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc({
    required this.categoryService,
    required this.cartService,
  }) : super(CategoryStateLoading()) {
    on<CategoryEventInit>(_onInit);
    on<CategoryEventStarted>(_onStarted);
    on<CategoryEventAddToCart>(_onAdd);
    add(CategoryEventInit());
  }

  final CategoryService categoryService;
  final CartService cartService;

  Future<void> _onInit(
    CategoryEvent event,
    Emitter<CategoryState> emit,
  ) async {
    try {
      await categoryService.getCategoriesFromRemote();
      add(CategoryEventStarted());
    } catch (_) {
      emit(CategoryStateError());
    }
  }

  Future<void> _onStarted(
    CategoryEvent event,
    Emitter<CategoryState> emit,
  ) async {
    try {
      final categories = await getCategories();
      emit(CategoryStateLoaded(categories));
    } catch (_) {
      emit(CategoryStateError());
    }
  }

  Future<void> _onAdd(
    CategoryEventAddToCart event,
    Emitter<CategoryState> emit,
  ) async {
    final state = this.state;
    if (state is CategoryStateLoaded) {
      try {
        await cartService.cartAdd(event.item);
        final categories = await getCategories();
        emit(CategoryStateLoaded(categories));
      } catch (_) {
        emit(CategoryStateError());
      }
    }
  }
  Future<List<Category>> getCategories() async {

    List<Category> categories = [];
    final categoriesEntities = await categoryService.getCategories();
    final productsEntities = await categoryService.getProducts();
    for (final categoryEntity in categoriesEntities) {
      List<Product> products = [];
      for (final productEntity in productsEntities) {
        if (productEntity.categoryId == categoryEntity.id) {
          products.add(Product(
            id: productEntity.id,
            name: productEntity.name,
            price: productEntity.price,
            image: productEntity.image,
          ));
        }
      }
      Category category = Category(
        name: categoryEntity.name,
        products: products,
      );
      categories.add(category);
    }
    return categories;
  }
}
