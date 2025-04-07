import 'package:flutter/material.dart';

class MomOrdersPage extends StatefulWidget {
  @override
  _MomOrdersPageState createState() => _MomOrdersPageState();
}

class _MomOrdersPageState extends State<MomOrdersPage> {
  String selectedStatusFilter = 'All'; // Default filter

  // Sample order data (in a real app, this would come from an API)
  final List<Map<String, dynamic>> orders = [
    {
      'orderId': 'ORD001',
      'customerName': 'John Doe',
      'customerAddress': '123 Main St, City',
      'items': [
        {'name': 'Butter Chicken', 'quantity': 2, 'price': 250.0},
        {'name': 'Tandoori Roti', 'quantity': 4, 'price': 30.0},
      ],
      'totalAmount': 620.0, // (2 * 250) + (4 * 30)
      'status': 'Pending',
      'orderDate': '2025-03-01 10:30 AM',
    },
    {
      'orderId': 'ORD002',
      'customerName': 'Jane Smith',
      'customerAddress': '456 Oak Ave, Town',
      'items': [
        {'name': 'Chicken Biryani', 'quantity': 1, 'price': 300.0},
        {'name': 'Gulab Jamun', 'quantity': 2, 'price': 100.0},
      ],
      'totalAmount': 500.0, // (1 * 300) + (2 * 100)
      'status': 'Preparing',
      'orderDate': '2025-03-01 11:00 AM',
    },
    {
      'orderId': 'ORD003',
      'customerName': 'Alice Brown',
      'customerAddress': '789 Pine Rd, Village',
      'items': [
        {'name': 'Paneer Tikka', 'quantity': 1, 'price': 180.0},
        {'name': 'Rasgulla', 'quantity': 3, 'price': 120.0},
      ],
      'totalAmount': 540.0, // (1 * 180) + (3 * 120)
      'status': 'Delivered',
      'orderDate': '2025-02-28 03:15 PM',
    },
  ];

  // List of status filters
  final List<String> statusFilters = [
    'All',
    'Pending',
    'Preparing',
    'Delivered',
  ];

  // Filtered orders based on selected status
  List<Map<String, dynamic>> get filteredOrders {
    if (selectedStatusFilter == 'All') {
      return orders;
    }
    return orders
        .where((order) => order['status'] == selectedStatusFilter)
        .toList();
  }

  // Function to update order status
  void _updateOrderStatus(int index, String newStatus) {
    setState(() {
      orders[index]['status'] = newStatus;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content:
              Text('Order ${orders[index]['orderId']} marked as $newStatus')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Orders',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Color(0xffff9b48),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Status Filter Section
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xffffb348), Color(0xFF9C6BFF)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Filter Orders:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                DropdownButton<String>(
                  value: selectedStatusFilter,
                  dropdownColor: Color(0xffff9b48),
                  icon: Icon(Icons.arrow_drop_down, color: Colors.white),
                  underline: SizedBox(),
                  items: statusFilters.map((String status) {
                    return DropdownMenuItem<String>(
                      value: status,
                      child: Text(
                        status,
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        selectedStatusFilter = newValue;
                      });
                    }
                  },
                ),
              ],
            ),
          ),
          // Orders List
          Expanded(
            child: filteredOrders.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.list_alt,
                          size: 80,
                          color: Colors.grey[400],
                        ),
                        SizedBox(height: 16),
                        Text(
                          'No $selectedStatusFilter Orders',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Check back later for new orders!',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    itemCount: filteredOrders.length,
                    itemBuilder: (context, index) {
                      final order = filteredOrders[index];
                      return OrderTile(
                        order: order,
                        index: index,
                        onStatusUpdate: _updateOrderStatus,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class OrderTile extends StatelessWidget {
  final Map<String, dynamic> order;
  final int index;
  final Function(int, String) onStatusUpdate;

  OrderTile({
    required this.order,
    required this.index,
    required this.onStatusUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order #${order['orderId']}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getStatusColor(order['status']),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    order['status'],
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            // Customer Info
            Text(
              'Customer: ${order['customerName']}',
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            Text(
              'Address: ${order['customerAddress']}',
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
            Text(
              'Placed: ${order['orderDate']}',
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
            SizedBox(height: 12),
            // Ordered Items
            Text(
              'Items:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            ...order['items'].map<Widget>((item) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${item['name']} x${item['quantity']}',
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                    Text(
                      '₹${(item['price'] * item['quantity']).toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                  ],
                ),
              );
            }).toList(),
            SizedBox(height: 8),
            // Total Amount
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  '₹${order['totalAmount'].toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xffff9b48),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            // Status Update Buttons
            if (order['status'] != 'Delivered')
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (order['status'] == 'Pending')
                    TextButton(
                      onPressed: () => onStatusUpdate(index, 'Preparing'),
                      style: TextButton.styleFrom(
                        foregroundColor: Color(0xffff9b48),
                      ),
                      child: Text('Mark as Preparing'),
                    ),
                  if (order['status'] == 'Preparing')
                    TextButton(
                      onPressed: () => onStatusUpdate(index, 'Delivered'),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.green,
                      ),
                      child: Text('Mark as Delivered'),
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  // Helper to get status color
  Color _getStatusColor(String status) {
    switch (status) {
      case 'Pending':
        return Colors.orange;
      case 'Preparing':
        return Colors.blue;
      case 'Delivered':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}
