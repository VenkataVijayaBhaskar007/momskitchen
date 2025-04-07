import 'package:flutter/material.dart';

class CheckoutPage extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;
  final double subtotal;

  CheckoutPage({required this.cartItems, required this.subtotal});

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  // Sample delivery addresses (in a real app, this would come from user data)
  String selectedAddress = '123, MG Road, Delhi';
  List<String> addresses = [
    '123, MG Road, Delhi',
    '456, Brigade Road, Bangalore',
    '789, Park Street, Kolkata',
  ];

  // Sample payment methods
  String selectedPayment = 'Cash on Delivery';
  List<String> paymentMethods = [
    'Cash on Delivery',
    'Credit/Debit Card',
    'UPI',
    'Net Banking',
  ];

  // Delivery fee and tax (could be dynamic in a real app)
  final double deliveryFee = 50.0;
  final double taxRate = 0.05; // 5% tax

  double get total =>
      widget.subtotal + deliveryFee + (widget.subtotal * taxRate);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
        backgroundColor: Color(0xffff9b48),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Order Summary
              Text(
                'Order Summary',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    children: widget.cartItems.map((item) {
                      return ListTile(
                        title: Text(
                          item['name'],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text('Qty: ${item['quantity']}'),
                        trailing: Text(
                          '₹${(item['price'] * item['quantity']).toStringAsFixed(2)}',
                          style: TextStyle(color: Color(0xffff9b48)),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Delivery Address
              Text(
                'Delivery Address',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    children: [
                      DropdownButtonFormField<String>(
                        value: selectedAddress,
                        decoration: InputDecoration(
                          labelText: 'Select Address',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        items: addresses.map((address) {
                          return DropdownMenuItem(
                            value: address,
                            child: Text(address),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedAddress = value!;
                          });
                        },
                      ),
                      SizedBox(height: 10),
                      TextButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text('Add new address coming soon!')),
                          );
                        },
                        child: Text(
                          'Add New Address',
                          style: TextStyle(color: Color(0xffff9b48)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Payment Method
              Text(
                'Payment Method',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: DropdownButtonFormField<String>(
                    value: selectedPayment,
                    decoration: InputDecoration(
                      labelText: 'Select Payment Method',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    items: paymentMethods.map((method) {
                      return DropdownMenuItem(
                        value: method,
                        child: Text(method),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedPayment = value!;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Price Breakdown
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    children: [
                      _buildPriceRow('Subtotal', widget.subtotal),
                      _buildPriceRow('Delivery Fee', deliveryFee),
                      _buildPriceRow('Tax (5%)', widget.subtotal * taxRate),
                      Divider(),
                      _buildPriceRow('Total', total, isTotal: true),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Place Order Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    _showOrderConfirmation(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffff9b48),
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    'Place Order',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPriceRow(String label, double amount, {bool isTotal = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 18 : 16,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            '₹${amount.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: isTotal ? 18 : 16,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? Color(0xffff9b48) : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  void _showOrderConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Order Confirmed'),
        content: Text(
          'Your order has been placed successfully!\nTotal: ₹${total.toStringAsFixed(2)}',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Back to cart
              Navigator.pop(
                  context); // Back to home (adjust based on your navigation stack)
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}
