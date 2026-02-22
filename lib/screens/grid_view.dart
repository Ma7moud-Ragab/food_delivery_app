import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/food_model.dart';
import '../cubits/food/food_cubit.dart';
import '../cubits/cart/cart_cubit.dart';
import 'product_details.dart';

class Custom_GridView extends StatelessWidget {
  const Custom_GridView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FoodCubit, FoodState>(
      builder: (context, state) {
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 0.75,
          ),
          itemCount: state.foods.length,
          itemBuilder: (context, index) {
            return _foodCard(context, state.foods[index]);
          },
        );
      },
    );
  }

  Widget _foodCard(BuildContext context, FoodModel food) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              textDirection: TextDirection.rtl,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetails(title: food.title),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        image: NetworkImage(food.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4),
                  child: IconButton(
                    onPressed: () {
                      context.read<FoodCubit>().toggleFavorite(food);
                    },
                    icon: Icon(
                      Icons.favorite,
                      color: food.isFavorite ? Colors.red : Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            food.title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 6),
          Text(
            food.price.toString() + ' \$',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.red,
              fontSize: 16,
            ),
          ),

          const SizedBox(height: 6),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 252, 178, 178),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                context.read<CartCubit>().addItem(food);
              },
              child: const Text("Add to Cart"),
            ),
          ),
        ],
      ),
    );
  }
}
