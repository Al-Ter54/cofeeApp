import 'package:cofee/features/categories/bloc/caterory_events.dart';
import 'package:cofee/features/categories/bloc/category_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../services/cart_service.dart';
import '../../../services/category_service.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc({
    required this.categoryService,
    required this.cartService,
  }) : super(CategoryStateLoading()) {
    on<CategoryEventStarted>(_onInit);
    on<CategoryEventAddToCart>(_onAdd);
    add(CategoryEventStarted());
  }

  final CategoryService categoryService;
  final CartService cartService;

  Future<void> _onInit(
    CategoryEvent event,
    Emitter<CategoryState> emit,
  ) async {
    try {
      final categories = await categoryService.getMenu();
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
        cartService.cartAdd(event.item);
        final categories = await categoryService.getMenu();
        emit(CategoryStateLoaded(categories));
      } catch (_) {
        emit(CategoryStateError());
      }
    }
  }
}
