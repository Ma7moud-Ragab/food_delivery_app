import 'package:flutter/material.dart';
import '../food_model.dart';
import 'grid_view.dart';
import 'list_view.dart';

enum FoodTab { listview, gridview }

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  FoodTab selectedTab = FoodTab.listview;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Food Delivery",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: Icon(Icons.shopping_cart, color: Colors.black),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: "Search for food",
                prefixIcon: Icon(Icons.search, color: Colors.red),
                filled: true,
                fillColor: Color.fromARGB(255, 248, 200, 200),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 20),

            SizedBox(
              height: 160,
              child: CarouselView.weighted(
                flexWeights: const [4, 1],
                itemSnapping: true,
                children: [
                  _carouselItem(FoodModel.sampleFoods[0].imageUrl),
                  _carouselItem(FoodModel.sampleFoods[1].imageUrl),
                  _carouselItem(FoodModel.sampleFoods[2].imageUrl),
                  _carouselItem(FoodModel.sampleFoods[3].imageUrl),
                ],
              ),
            ),

            SizedBox(height: 20),
            Text(
              "Featured Items",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),

            Row(
              children: [
                _buildTab(
                  title: 'List View',
                  isSelected: selectedTab == FoodTab.listview,
                  onTap: () {
                    setState(() {
                      selectedTab = FoodTab.listview;
                    });
                  },
                ),
                const SizedBox(width: 12),
                _buildTab(
                  title: 'Grid View',
                  isSelected: selectedTab == FoodTab.gridview,
                  onTap: () {
                    setState(() {
                      selectedTab = FoodTab.gridview;
                    });
                  },
                ),
              ],
            ),

            const SizedBox(height: 20),

            Expanded(
              child: IndexedStack(
                index: selectedTab == FoodTab.listview ? 0 : 1,
                children: const [Custom_ListView(), Custom_GridView()],
              ),
            ),

            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  static Widget _carouselItem(String imageUrl) {
    return Image.network(imageUrl, fit: BoxFit.cover);
  }
}

Widget _buildTab({
  required String title,
  required bool isSelected,
  required VoidCallback onTap,
}) {
  return Expanded(
    child: GestureDetector(
      onTap: onTap,
      child: Container(
        height: 42,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? Colors.red : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.red),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ),
  );
}
