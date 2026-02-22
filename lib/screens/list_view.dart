import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/food_model.dart';
import '../cubits/food/food_cubit.dart';
import '../cubits/cart/cart_cubit.dart';
import 'product_details.dart';

class Custom_ListView extends StatelessWidget {
  const Custom_ListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FoodCubit, FoodState>(
      builder: (context, state) {
        return ListView.builder(
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
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3)),
        ],
      ),
      child: Row(
        children: [
          Stack(
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
                child: Image.network(
                  food.imageUrl,
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                ),
              ),
              IconButton(
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
                onPressed: () {
                  context.read<FoodCubit>().toggleFavorite(food);
                },
                icon: Icon(
                  food.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: food.isFavorite ? Colors.red : Colors.white,
                  size: 20,
                ),
              ),
            ],
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  food.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "${food.price} \$",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 36,
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
