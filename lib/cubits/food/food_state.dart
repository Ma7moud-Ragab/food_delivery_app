import 'package:equatable/equatable.dart';

import '../../models/food_model.dart';

class FoodState extends Equatable {
  final List<FoodModel> foods;

  const FoodState({required this.foods});

  FoodState copyWith({List<FoodModel>? foods}) {
    return FoodState(foods: foods ?? this.foods);
  }

  @override
  List<Object> get props => [foods];
}
