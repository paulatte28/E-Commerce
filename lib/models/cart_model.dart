import 'package:coretico_ecommerce/models/product_model.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({
    required this.product,
    this.quantity = 1,
  });

  double get totalPrice => double.parse(product.price) * quantity;
}

class Cart {
  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);

  int get itemCount => _items.fold(0, (sum, item) => sum + item.quantity);

  double get totalPrice => _items.fold(0, (sum, item) => sum + item.totalPrice);

  void addProduct(Product product) {
    final existingIndex = _items.indexWhere(
      (item) => item.product.name == product.name,
    );

    if (existingIndex >= 0) {
      _items[existingIndex].quantity++;
    } else {
      _items.add(CartItem(product: product));
    }
  }

  void removeProduct(Product product) {
    _items.removeWhere((item) => item.product.name == product.name);
  }

  void increaseQuantity(Product product) {
    final item = _items.firstWhere(
      (item) => item.product.name == product.name,
    );
    item.quantity++;
  }

  void decreaseQuantity(Product product) {
    final item = _items.firstWhere(
      (item) => item.product.name == product.name,
    );
    
    if (item.quantity > 1) {
      item.quantity--;
    } else {
      removeProduct(product);
    }
  }

  bool isInCart(Product product) {
    return _items.any((item) => item.product.name == product.name);
  }

  void clear() {
    _items.clear();
  }
}