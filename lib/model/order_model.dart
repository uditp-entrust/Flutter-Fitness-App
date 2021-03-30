class OrderModel {
  String productName, productImage, brand;
  int quantity, id;
  double price;

  OrderModel(
      {this.price,
      this.id,
      this.productName,
      this.quantity,
      this.productImage,
      this.brand});

  static List<OrderModel> orderList = [
    OrderModel(
        id: 1,
        price: 15.49,
        quantity: 1,
        brand: 'Black Mountain Products',
        productImage: 'assets/images/fitness-product-1.jpg',
        productName:
            'Tepemccu Hydraulic Power Twister Adjustable Arm-Exerciser'),
    OrderModel(
        id: 2,
        price: 18.99,
        quantity: 1,
        brand: 'Best Choice Products',
        productImage: 'assets/images/fitness-product-2.jpg',
        productName: 'Kunto Fitness Tennis Elbow Strap'),
    OrderModel(
        id: 4,
        price: 14.98,
        quantity: 2,
        brand: 'RENPHO',
        productName: 'Gym Fitness Wall Decals',
        productImage: 'assets/images/fitness-product-3.jpg'),
    OrderModel(
        id: 1,
        price: 15.49,
        quantity: 1,
        brand: 'Black Mountain Products',
        productImage: 'assets/images/fitness-product-1.jpg',
        productName:
            'Tepemccu Hydraulic Power Twister Adjustable Arm-Exerciser'),
    OrderModel(
        id: 5,
        price: 18.99,
        quantity: 1,
        brand: 'Best Choice Products',
        productImage: 'assets/images/fitness-product-2.jpg',
        productName: 'Kunto Fitness Tennis Elbow Strap'),
    OrderModel(
        id: 6,
        price: 14.98,
        quantity: 2,
        brand: 'RENPHO',
        productName: 'Gym Fitness Wall Decals',
        productImage: 'assets/images/fitness-product-3.jpg'),
  ];
}
