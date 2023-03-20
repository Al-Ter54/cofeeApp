import '../../../models/product.dart';

abstract class CartEvent {}

class CartEventStarted extends CartEvent {}

class CartEventAdd extends CartEvent {
  final Product item;

  CartEventAdd(this.item);
}

class CartEventRemove extends CartEvent {
  final Product item;

  CartEventRemove(this.item);
}

class CartEventClear extends CartEvent {}
