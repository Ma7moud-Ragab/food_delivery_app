import 'package:equatable/equatable.dart';

import '../../models/food_model.dart';

class CartState extends Equatable {
  final List<FoodModel> items;

  const CartState({required this.items});

  double get subTotal => items.fold(0, (sum, i) => sum + i.subTotal);
  double get discount => items.fold(0, (sum, i) => sum + i.discountAmount);
  double get taxes => items.fold(0, (sum, i) => sum + i.taxAmount);
  double get deliveryFee => subTotal >= 200 ? 0 : 20;
  double get total => subTotal - discount + taxes + deliveryFee;

  CartState copyWith({List<FoodModel>? items}) {
    return CartState(items: items ?? this.items);
  }

  @override
  List<Object> get props => [items];
}
