import 'package:flutter/material.dart';

import '../food_model.dart';

// ignore: must_be_immutable
class CartScreen extends StatefulWidget {
  List<FoodModel> cartItems = [
    FoodModel(
      title: "Burger",
      imageUrl:
          "https://thetimesofcanada.com/wp-content/uploads/2024/10/image001-2.jpg",
      price: 80,
      rating: 4.5,
      preparationTime: 20,
      calories: 350,
      description:
          "Juicy grilled burger with fresh lettuce, tomato and special sauce.",
      ingredients: ["Beef", "Bread", "Lettuce", "Tomato", "Cheese"],
      discount: 0.05,
    ),
    FoodModel(
      title: "Pizza",
      imageUrl:
          "https://thumbs.dreamstime.com/b/close-up-sliced-pizza-pepperoni-mushrooms-green-peppers-olives-melted-cheese-slice-delicious-topped-361107723.jpg",
      price: 150,
      rating: 4.8,
      preparationTime: 25,
      calories: 500,
      description:
          "Cheesy pepperoni pizza topped with olives and fresh vegetables.",
      ingredients: ["Flour", "Cheese", "Pepperoni", "Olives", "Tomato Sauce"],
      discount: 0.1,
    ),
  ];

  CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double get cartSubTotal {
    return widget.cartItems.fold(0, (sum, item) => sum + item.subTotal);
  }

  double get cartDiscount {
    return widget.cartItems.fold(0, (sum, item) => sum + item.discountAmount);
  }

  double get cartTaxes {
    return widget.cartItems.fold(0, (sum, item) => sum + item.taxAmount);
  }

  double get deliveryFee {
    return cartSubTotal >= 200 ? 0 : 20;
  }

  double get cartTotal {
    return cartSubTotal - cartDiscount + cartTaxes + deliveryFee;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        spacing: 16,
        children: [
          Text(
            "Cart",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.cartItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        image: NetworkImage(widget.cartItems[index].imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  title: Text(
                    widget.cartItems[index].title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    "\$${widget.cartItems[index].price.toStringAsFixed(2)}",
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,

                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            if (widget.cartItems[index].quantity > 1)
                              widget.cartItems[index].quantity--;
                          });
                        },
                        icon: Icon(Icons.minimize, color: Colors.grey),
                      ),
                      Text(
                        "${widget.cartItems[index].quantity}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            widget.cartItems[index].quantity++;
                          });
                        },
                        icon: Icon(Icons.add, color: Colors.grey),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Subtotal"),
                    Text("\$${cartSubTotal.toStringAsFixed(2)}"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Delivery"),
                    Text("\$${deliveryFee.toStringAsFixed(2)}"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Taxes"),
                    Text("\$${cartTaxes.toStringAsFixed(2)}"),
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "\$${cartTotal.toStringAsFixed(2)}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    onPressed: () {},
                    child: Text(
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
          ),
        ],
      ),
    );
  }
}
