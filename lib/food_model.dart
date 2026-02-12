class FoodModel {
  final String title;
  final String imageUrl;
  final double price;
  final double rating;
  final int preparationTime;
  final int calories;
  final String description;
  final List<String> ingredients;
  bool isFavorite;
  int quantity;
  final double discount;
  final double taxRate;
  final double deliveryFee;

  FoodModel({
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.rating,
    required this.preparationTime,
    required this.calories,
    required this.description,
    required this.ingredients,

    this.isFavorite = false,
    this.quantity = 1,
    this.discount = 0,
    this.taxRate = 0.1,
    this.deliveryFee = 20,

  });

  double get subTotal => price * quantity;

  double get discountAmount => subTotal * discount;

  double get taxAmount => (subTotal - discountAmount) * taxRate;

  double get total => subTotal - discountAmount + taxAmount + deliveryFee;
  static List<FoodModel> sampleFoods = [
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
    FoodModel(
      title: "Fried Chicken",
      imageUrl:
          "https://www.mommyplates.com/wp-content/uploads/2025/05/Fried-Chicken-1.webp",
      price: 120,
      rating: 4.3,
      preparationTime: 30,
      calories: 600,
      description: "Crispy fried chicken with secret spices.",
      ingredients: ["Chicken", "Flour", "Spices", "Oil"],
    ),
    FoodModel(
      title: "Pasta",
      imageUrl:
          "https://hips.hearstapps.com/hmg-prod/images/creamy-pasta-burrata-7-1656098638.jpeg",
      price: 110,
      rating: 4.6,
      preparationTime: 18,
      calories: 420,
      description: "Creamy pasta with burrata cheese and herbs.",
      ingredients: ["Pasta", "Cream", "Cheese", "Herbs"],
    ),
  ];
}
