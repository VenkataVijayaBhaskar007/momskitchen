import 'package:flutter/material.dart';
import '../widgets/food_card.dart';
import 'checkout_page.dart'; // Import CheckoutPage for navigation

class HomeContent extends StatefulWidget {
  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  String selectedCategory = 'All'; // Default category

  final List<Map<String, String>> categories = [
    {'name': 'All', 'icon': '🍽️'},
    {'name': 'Curries', 'icon': '🍛'},
    {'name': 'Tandoori Delights', 'icon': '🍗'},
    {'name': 'Biryani Specials', 'icon': '🍚'},
    {'name': 'Sweet Treats', 'icon': '🍮'},
  ];

  final List<Map<String, dynamic>> dishes = [
    // Curries
    {
      'name': 'Butter Chicken',
      'image': 'assets/butter_chicken.jpg',
      'price': 250.0,
      'rating': 4.9,
      'quantity': 1,
      'category': 'Curries',
    },
    {
      'name': 'Chicken Korma',
      'image': 'assets/chicken_korma.jpg',
      'price': 260.0,
      'rating': 4.8,
      'quantity': 1,
      'category': 'Curries',
    },
    {
      'name': 'Palak Paneer',
      'image': 'assets/palak_paneer.jpg',
      'price': 200.0,
      'rating': 4.6,
      'quantity': 1,
      'category': 'Curries',
    },
    {
      'name': 'Rogan Josh',
      'image': 'assets/rogan_josh.jpg',
      'price': 280.0,
      'rating': 4.7,
      'quantity': 1,
      'category': 'Curries',
    },
    // Tandoori Delights
    {
      'name': 'Paneer Tikka',
      'image': 'assets/paneer_tikka.jpg',
      'price': 180.0,
      'rating': 4.7,
      'quantity': 1,
      'category': 'Tandoori Delights',
    },
    {
      'name': 'Chicken Tikka',
      'image': 'assets/chicken_tikka.jpg',
      'price': 220.0,
      'rating': 4.8,
      'quantity': 1,
      'category': 'Tandoori Delights',
    },
    {
      'name': 'Tandoori Roti',
      'image': 'assets/tandoori_roti.jpg',
      'price': 30.0,
      'rating': 4.5,
      'quantity': 1,
      'category': 'Tandoori Delights',
    },
    {
      'name': 'Seekh Kebab',
      'image': 'assets/seekh_kebab.jpg',
      'price': 240.0,
      'rating': 4.6,
      'quantity': 1,
      'category': 'Tandoori Delights',
    },
    // Biryani Specials
    {
      'name': 'Chicken Biryani',
      'image': 'assets/biryani.jpg',
      'price': 300.0,
      'rating': 5.0,
      'quantity': 1,
      'category': 'Biryani Specials',
    },
    {
      'name': 'Mutton Biryani',
      'image': 'assets/mutton_biryani.jpg',
      'price': 350.0,
      'rating': 4.9,
      'quantity': 1,
      'category': 'Biryani Specials',
    },
    {
      'name': 'Veg Biryani',
      'image': 'assets/veg_biryani.jpg',
      'price': 220.0,
      'rating': 4.6,
      'quantity': 1,
      'category': 'Biryani Specials',
    },
    {
      'name': 'Prawn Biryani',
      'image': 'assets/prawn_biryani.jpg',
      'price': 380.0,
      'rating': 4.8,
      'quantity': 1,
      'category': 'Biryani Specials',
    },
    // Sweet Treats
    {
      'name': 'Gulab Jamun',
      'image': 'assets/gulab_jamun.jpg',
      'price': 100.0,
      'rating': 4.8,
      'quantity': 1,
      'category': 'Sweet Treats',
    },
    {
      'name': 'Rasgulla',
      'image': 'assets/rasgulla.jpg',
      'price': 120.0,
      'rating': 4.7,
      'quantity': 1,
      'category': 'Sweet Treats',
    },
    {
      'name': 'Jalebi',
      'image': 'assets/jalebi.jpg',
      'price': 90.0,
      'rating': 4.6,
      'quantity': 1,
      'category': 'Sweet Treats',
    },
    {
      'name': 'Kheer',
      'image': 'assets/kheer.jpg',
      'price': 150.0,
      'rating': 4.9,
      'quantity': 1,
      'category': 'Sweet Treats',
    },
  ];

  List<Map<String, dynamic>> get filteredDishes {
    if (selectedCategory == 'All') {
      return dishes;
    }
    return dishes
        .where((dish) => dish['category'] == selectedCategory)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    // Log the asset paths being used
    for (var dish in dishes) {
      print('Attempting to load image: ${dish['image']}');
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Moms Kitchen',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Color(0xffff9b48),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Section
            Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xffffb348), Color(0xFF9C6BFF)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white.withOpacity(0.2),
                    child: Icon(
                      Icons.restaurant,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Get Home Food',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          blurRadius: 10.0,
                          color: Colors.black26,
                          offset: Offset(2.0, 2.0),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'at your doorstep',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          blurRadius: 10.0,
                          color: Colors.black26,
                          offset: Offset(2.0, 2.0),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search for dishes...',
                        hintStyle: TextStyle(color: Colors.white70),
                        prefixIcon: Icon(Icons.search, color: Colors.white),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.2),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      style: TextStyle(color: Colors.white),
                      onSubmitted: (value) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Searching for: $value')),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            // Categories Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Categories',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    height: 50,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final category = categories[index]['name']!;
                        final isSelected = selectedCategory == category;
                        return Padding(
                          padding: const EdgeInsets.only(right: 12.0),
                          child: ActionChip(
                            avatar: Text(categories[index]['icon']!),
                            label: Text(categories[index]['name']!),
                            backgroundColor: isSelected
                                ? Color(0xffff9b48).withOpacity(0.2)
                                : Colors.white,
                            elevation: isSelected ? 4 : 2,
                            onPressed: () {
                              setState(() {
                                selectedCategory = category;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Filtering $category'),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            // Chef's Specials
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Chef’s Specials (${selectedCategory})',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            filteredDishes.isEmpty
                ? Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                      child: Text(
                        'No items found in $selectedCategory',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        childAspectRatio: 0.7,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemCount: filteredDishes.length,
                      itemBuilder: (context, index) {
                        final dish = filteredDishes[index];
                        return GestureDetector(
                          onTap: () {
                            // Navigate to CheckoutPage with the selected item
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CheckoutPage(
                                  cartItems: [dish],
                                  subtotal:
                                      dish['price'] * (dish['quantity'] ?? 1),
                                ),
                              ),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    "${dish['name']} selected for checkout!"),
                              ),
                            );
                          },
                          child: FoodCard(
                            name: dish['name']!,
                            image: dish['image']!,
                            price: '₹${dish['price'].toStringAsFixed(2)}',
                            rating: dish['rating']!,
                          ),
                        );
                      },
                    ),
                  ),
            SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
