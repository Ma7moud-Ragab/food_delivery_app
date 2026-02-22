import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/food/food_cubit.dart';
import '../cubits/cart/cart_cubit.dart';
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
        title: const Text(
          "Food Delivery",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: BlocBuilder<CartCubit, CartState>(
              builder: (context, state) {
                return Stack(
                  alignment: Alignment.topRight,
                  children: [
                    const Icon(Icons.shopping_cart, color: Colors.black),
                    if (state.items.isNotEmpty)
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 16,
                            minHeight: 16,
                          ),
                          child: Text(
                            state.items.length.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
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
                prefixIcon: const Icon(Icons.search, color: Colors.red),
                filled: true,
                fillColor: const Color.fromARGB(255, 248, 200, 200),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // carousel built from bloc state
            SizedBox(
              height: 160,
              child: BlocBuilder<FoodCubit, FoodState>(
                builder: (context, state) {
                  return CarouselView.weighted(
                    flexWeights: const [4, 1],
                    itemSnapping: true,
                    children: state.foods
                        .map((f) => _carouselItem(f.imageUrl))
                        .toList(),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),
            const Text(
              "Featured Items",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

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

            const SizedBox(height: 20),
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
