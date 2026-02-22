export 'food_state.dart';

import 'package:bloc/bloc.dart';

import '../../models/food_model.dart';
import 'food_state.dart';

class FoodCubit extends Cubit<FoodState> {
  FoodCubit() : super(FoodState(foods: List.from(FoodModel.sampleFoods)));

  void toggleFavorite(FoodModel food) {
    final updatedFoods = state.foods.map((f) {
      if (f.title == food.title) {
        return f.copyWith(isFavorite: !f.isFavorite);
      }
      return f;
    }).toList();

    emit(state.copyWith(foods: updatedFoods));
  }

  void updateQuantity(FoodModel food, int newQuantity) {
    final updatedFoods = state.foods.map((f) {
      if (f.title == food.title) {
        return f.copyWith(quantity: newQuantity);
      }
      return f;
    }).toList();
    emit(state.copyWith(foods: updatedFoods));
  }
}
