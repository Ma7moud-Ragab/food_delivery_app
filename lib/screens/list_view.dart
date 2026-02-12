import 'package:flutter/material.dart';

import '../food_model.dart';
import 'product_details.dart';

class Custom_ListView extends StatefulWidget {
  const Custom_ListView({super.key});

  @override
  State<Custom_ListView> createState() => _Custom_ListViewState();
}

class _Custom_ListViewState extends State<Custom_ListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: FoodModel.sampleFoods.length,
      itemBuilder: (context, index) {
        return _foodCard(FoodModel.sampleFoods[index]);
      },
    );
  }

  Widget _foodCard(FoodModel food) {
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
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetails(product: food),
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
              ),
              IconButton(
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
                onPressed: () {
                  setState(() {
                    food.isFavorite = !food.isFavorite;
                  });
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
              onPressed: () {},
              child: const Text("Add to Cart"),
            ),
          ),
        ],
      ),
    );
  }
}
