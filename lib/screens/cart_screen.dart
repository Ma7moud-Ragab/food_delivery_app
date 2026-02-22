import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/cart/cart_cubit.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text(
            "Cart",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Expanded(
            child: BlocBuilder<CartCubit, CartState>(
              builder: (context, state) {
                if (state.items.isEmpty) {
                  return const Center(child: Text("Your cart is empty"));
                }
                return ListView.builder(
                  itemCount: state.items.length,
                  itemBuilder: (context, index) {
                    final item = state.items[index];
                    return ListTile(
                      leading: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            image: NetworkImage(item.imageUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      title: Text(
                        item.title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text("\$${item.price.toStringAsFixed(2)}"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              context.read<CartCubit>().decreaseQuantity(item);
                            },
                            icon: const Icon(
                              Icons.minimize,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            "${item.quantity}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              context.read<CartCubit>().increaseQuantity(item);
                            },
                            icon: const Icon(Icons.add, color: Colors.grey),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
          BlocBuilder<CartCubit, CartState>(
            builder: (context, state) {
              return Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _rowItem("Subtotal", state.subTotal),
                    _rowItem("Delivery", state.deliveryFee),
                    _rowItem("Taxes", state.taxes),
                    const Divider(),
                    _rowItem("Total", state.total, isBold: true),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        onPressed: () {},
                        child: const Text(
                          "Checkout",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _rowItem(String label, double value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label),
        Text(
          "\$${value.toStringAsFixed(2)}",
          style: isBold ? const TextStyle(fontWeight: FontWeight.bold) : null,
        ),
      ],
    );
  }
}
