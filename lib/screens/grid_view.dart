import 'package:flutter/material.dart';

import '../food_model.dart';
import 'product_details.dart';

class Custom_GridView extends StatefulWidget {
  const Custom_GridView({super.key});

  @override
  State<Custom_GridView> createState() => _Custom_GridViewState();
}

class _Custom_GridViewState extends State<Custom_GridView> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.75,
      ),
      itemCount: FoodModel.sampleFoods.length,
      itemBuilder: (context, index) {
        return _foodCard(FoodModel.sampleFoods[index]);
      },
    );
  }

  Widget _foodCard( FoodModel food) {
    return Container(
      padding: EdgeInsets.all(8),
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
                        builder: (context) => ProductDetails(product: food),
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
                      food.isFavorite = !food.isFavorite;
                      setState(() {});
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
          SizedBox(height: 8),
          Text(
            food.title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          SizedBox(height: 6),
          Text(
            food.price.toString() + ' \$',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.red,
              fontSize: 16,
            ),
          ),

          SizedBox(height: 6),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 252, 178, 178),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {},
              child: Text("Add to Cart"),
            ),
          ),
        ],
      ),
    );
  }
}
