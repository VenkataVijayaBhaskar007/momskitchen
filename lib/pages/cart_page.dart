import 'package:flutter/material.dart';
import 'checkout_page.dart'; // Ensure this import matches your file structure

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // Sample cart data with Indian food
  List<Map<String, dynamic>> cartItems = [
    {
      'name': 'Butter Chicken',
      'image': 'assets/butter_chicken.jpg',
      'price': 250.0,
      'quantity': 2,
    },
    {
      'name': 'Paneer Tikka',
      'image': 'assets/paneer_tikka.jpg',
      'price': 180.0,
      'quantity': 1,
    },
    {
      'name': 'Gulab Jamun',
      'image': 'assets/gulab_jamun.jpg',
      'price': 100.0,
      'quantity': 3,
    },
    {
      'name': 'Biryani',
      'image': 'assets/biryani.jpg',
      'price': 300.0,
      'quantity': 1,
    },
  ];

  // Calculate subtotal
  double get subtotal => cartItems.fold(
      0, (sum, item) => sum + (item['price'] * item['quantity']));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        backgroundColor: Color(0xffff9b48),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.delete_outline),
            onPressed: cartItems.isNotEmpty
                ? () {
                    setState(() {
                      cartItems.clear();
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Cart cleared!')),
                    );
                  }
                : null,
          ),
        ],
      ),
      body: cartItems.isEmpty
          ? _buildEmptyCart()
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      return CartItemTile(
                        item: cartItems[index],
                        onRemove: () {
                          setState(() {
                            cartItems.removeAt(index);
                          });
                        },
                        onQuantityChanged: (newQuantity) {
                          setState(() {
                            cartItems[index]['quantity'] = newQuantity;
                          });
                        },
                      );
                    },
                  ),
                ),
                _buildCheckoutSection(context),
              ],
            ),
    );
  }

  Widget _buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 100,
            color: Colors.grey[400],
          ),
          SizedBox(height: 20),
          Text(
            'Your Cart is Empty',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Add some delicious Indian dishes to get started!',
            style: TextStyle(fontSize: 16, color: Colors.grey[500]),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xffff9b48),
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            child: Text(
              'Explore Menu',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckoutSection(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Subtotal',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                '₹${subtotal.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xffff9b48),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            'Delivery fees and taxes calculated at checkout',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CheckoutPage(
                      cartItems: cartItems,
                      subtotal: subtotal,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xffff9b48),
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                'Checkout',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CartItemTile extends StatelessWidget {
  final Map<String, dynamic> item;
  final VoidCallback onRemove;
  final Function(int) onQuantityChanged;

  CartItemTile({
    required this.item,
    required this.onRemove,
    required this.onQuantityChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                item['image'],
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 80,
                    height: 80,
                    color: Colors.grey[300],
                    child: Icon(Icons.fastfood, color: Colors.grey),
                  );
                },
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['name'],
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '₹${(item['price'] * item['quantity']).toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xffff9b48),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.remove_circle_outline, color: Colors.grey),
                  onPressed: () {
                    if (item['quantity'] > 1) {
                      onQuantityChanged(item['quantity'] - 1);
                    } else {
                      onRemove();
                    }
                  },
                ),
                Text(
                  '${item['quantity']}',
                  style: TextStyle(fontSize: 16),
                ),
                IconButton(
                  icon: Icon(Icons.add_circle_outline, color: Colors.grey),
                  onPressed: () => onQuantityChanged(item['quantity'] + 1),
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: onRemove,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
