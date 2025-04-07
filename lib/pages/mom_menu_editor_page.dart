import 'package:flutter/material.dart';

class MomMenuEditorPage extends StatefulWidget {
  @override
  _MomMenuEditorPageState createState() => _MomMenuEditorPageState();
}

class _MomMenuEditorPageState extends State<MomMenuEditorPage> {
  // Sample menu data (in a real app, this would come from an API)
  List<Map<String, dynamic>> menuItems = [
    {
      'name': 'Butter Chicken',
      'price': 250.0,
      'category': 'Curries',
      'image': 'assets/butter_chicken.jpg',
    },
    {
      'name': 'Paneer Tikka',
      'price': 180.0,
      'category': 'Tandoori Delights',
      'image': 'assets/paneer_tikka.jpg',
    },
    {
      'name': 'Chicken Biryani',
      'price': 300.0,
      'category': 'Biryani Specials',
      'image': 'assets/biryani.jpg',
    },
    {
      'name': 'Gulab Jamun',
      'price': 100.0,
      'category': 'Sweet Treats',
      'image': 'assets/gulab_jamun.jpg',
    },
  ];

  // Form controllers for adding/editing dishes
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  String _selectedCategory = 'Curries'; // Default category
  bool _isEditing = false;
  int _editingIndex = -1;

  // List of categories for dropdown
  final List<String> categories = [
    'Curries',
    'Tandoori Delights',
    'Biryani Specials',
    'Sweet Treats',
  ];

  // Function to add or update a dish
  void _addOrUpdateDish() {
    if (_nameController.text.isEmpty || _priceController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    double price;
    try {
      price = double.parse(_priceController.text);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Price must be a valid number')),
      );
      return;
    }

    final newDish = {
      'name': _nameController.text,
      'price': price,
      'category': _selectedCategory,
      'image': 'assets/placeholder.jpg', // Simulate image selection
    };

    setState(() {
      if (_isEditing) {
        // Update existing dish
        menuItems[_editingIndex] = newDish;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${newDish['name']} updated!')),
        );
      } else {
        // Add new dish
        menuItems.add(newDish);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${newDish['name']} added to menu!')),
        );
      }
      // Reset form
      _nameController.clear();
      _priceController.clear();
      _selectedCategory = 'Curries';
      _isEditing = false;
      _editingIndex = -1;
    });
  }

  // Function to edit a dish
  void _editDish(int index) {
    setState(() {
      _isEditing = true;
      _editingIndex = index;
      _nameController.text = menuItems[index]['name'];
      _priceController.text = menuItems[index]['price'].toString();
      _selectedCategory = menuItems[index]['category'];
    });
  }

  // Function to delete a dish with confirmation
  void _deleteDish(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Dish'),
        content: Text(
            'Are you sure you want to delete ${menuItems[index]['name']}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                menuItems.removeAt(index);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Dish deleted!')),
              );
            },
            child: Text('Yes', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Menu Editor',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Color(0xffff9b48),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Add/Edit Dish Form
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xffffb348), Color(0xFF9C6BFF)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _isEditing ? 'Edit Dish' : 'Add New Dish',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      hintText: 'Dish Name',
                      hintStyle: TextStyle(color: Colors.white70),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.2),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon:
                          Icon(Icons.restaurant_menu, color: Colors.white),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 12),
                  TextField(
                    controller: _priceController,
                    decoration: InputDecoration(
                      hintText: 'Price (₹)',
                      hintStyle: TextStyle(color: Colors.white70),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.2),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: Icon(Icons.attach_money, color: Colors.white),
                    ),
                    style: TextStyle(color: Colors.white),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    value: _selectedCategory,
                    decoration: InputDecoration(
                      hintText: 'Category',
                      hintStyle: TextStyle(color: Colors.white70),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.2),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: Icon(Icons.category, color: Colors.white),
                    ),
                    dropdownColor: Color(0xffff9b48),
                    items: categories.map((String category) {
                      return DropdownMenuItem<String>(
                        value: category,
                        child: Text(
                          category,
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          _selectedCategory = newValue;
                        });
                      }
                    },
                    style: TextStyle(color: Colors.white),
                    icon: Icon(Icons.arrow_drop_down, color: Colors.white),
                  ),
                  SizedBox(height: 16),
                  Center(
                    child: ElevatedButton(
                      onPressed: _addOrUpdateDish,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xffff9b48),
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        _isEditing ? 'Update Dish' : 'Add Dish',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                  if (_isEditing)
                    Center(
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            _isEditing = false;
                            _editingIndex = -1;
                            _nameController.clear();
                            _priceController.clear();
                            _selectedCategory = 'Curries';
                          });
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                        ),
                        child: Text('Cancel Edit'),
                      ),
                    ),
                ],
              ),
            ),
            // Menu Items List
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Your Menu',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            SizedBox(height: 12),
            menuItems.isEmpty
                ? Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.restaurant_menu,
                            size: 80,
                            color: Colors.grey[400],
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Your Menu is Empty',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Add some delicious dishes!',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: menuItems.length,
                    itemBuilder: (context, index) {
                      final dish = menuItems[index];
                      return DishTile(
                        dish: dish,
                        index: index,
                        onEdit: _editDish,
                        onDelete: _deleteDish,
                      );
                    },
                  ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class DishTile extends StatelessWidget {
  final Map<String, dynamic> dish;
  final int index;
  final Function(int) onEdit;
  final Function(int) onDelete;

  DishTile({
    required this.dish,
    required this.index,
    required this.onEdit,
    required this.onDelete,
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
        padding: EdgeInsets.all(12),
        child: Row(
          children: [
            // Dish Image
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                dish['image'],
                width: 60,
                height: 60,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  print('Error loading image: ${dish['image']}, Error: $error');
                  return Container(
                    width: 60,
                    height: 60,
                    color: Colors.grey[300],
                    child: Icon(Icons.fastfood, color: Colors.grey),
                  );
                },
              ),
            ),
            SizedBox(width: 12),
            // Dish Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dish['name'],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '₹${dish['price'].toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xffff9b48),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    dish['category'],
                    style: TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                ],
              ),
            ),
            // Actions
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.blue),
                  onPressed: () => onEdit(index),
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () => onDelete(index),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
