export 'cart_state.dart';

import 'package:bloc/bloc.dart';

import '../../models/food_model.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(const CartState(items: []));

  void addItem(FoodModel food) {
    final List<FoodModel> updated = List.from(state.items);
    final index = updated.indexWhere((e) => e.title == food.title);

    if (index == -1) {
      updated.add(food.copyWith(quantity: 1));
    } else {
      final existing = updated[index];
      updated[index] = existing.copyWith(quantity: existing.quantity + 1);
    }

    emit(state.copyWith(items: updated));
  }

  void removeItem(FoodModel food) {
    final updated = state.items.where((e) => e.title != food.title).toList();
    emit(state.copyWith(items: updated));
  }

  void increaseQuantity(FoodModel food) {
    final updated = state.items.map((e) {
      if (e.title == food.title) {
        return e.copyWith(quantity: e.quantity + 1);
      }
      return e;
    }).toList();
    emit(state.copyWith(items: updated));
  }

  void decreaseQuantity(FoodModel food) {
    final updated = state.items.map((e) {
      if (e.title == food.title && e.quantity > 1) {
        return e.copyWith(quantity: e.quantity - 1);
      }
      return e;
    }).where((e) => e.quantity > 0).toList();
    emit(state.copyWith(items: updated));
  }
}
