class Product {
  final String name;
  final double price;
  final double gstInPercent;
  int amount;

  Product({
    required this.name,
    required this.price,
    required this.gstInPercent,
    this.amount = 0,
  });
}
