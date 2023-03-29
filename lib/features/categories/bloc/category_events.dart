import '../../../models/product.dart';

abstract class CategoryEvent {
  const CategoryEvent();
}

class CategoryEventInit extends CategoryEvent {}
class CategoryEventStarted extends CategoryEvent {}

class CategoryEventAddToCart extends CategoryEvent {
  final Product item;

  CategoryEventAddToCart(this.item);
}
