import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'checkout_page.dart'; // Import CheckoutPage

class ExplorePage extends StatefulWidget {
  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  String selectedCategory = 'All'; // Default category

  // Updated sample data for Indian categories
  final List<Map<String, String>> categories = [
    {'name': 'All', 'icon': '🍽️'},
    {'name': 'Curries', 'icon': '🍛'},
    {'name': 'Tandoori Delights', 'icon': '🍗'},
    {'name': 'Biryani Specials', 'icon': '🍚'},
    {'name': 'Sweet Treats', 'icon': '🍮'},
  ];

  // Updated sample data for Indian featured dishes
  final List<Map<String, dynamic>> featuredDishes = [
    // Curries
    {
      'name': 'Butter Chicken',
      'image': 'assets/butter_chicken.jpg',
      'price': 250.0,
      'rating': 4.8,
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
      'rating': 4.6,
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
      'rating': 4.9,
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
      'rating': 4.7,
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
      return featuredDishes;
    }
    return featuredDishes
        .where((dish) => dish['category'] == selectedCategory)
        .toList();
  }

  String _getAssetPath(String path) {
    if (kIsWeb) {
      // Remove 'assets/' prefix for web to avoid double 'assets/' issue
      return path.replaceFirst('assets/', '');
    }
    return path;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Explore'),
        backgroundColor: Color(0xffff9b48),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Filter options coming soon!')),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xffffb348), Color(0xFF9C6BFF)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search for Indian dishes or cuisines...',
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
            // Categories Section (Tab-like)
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
                  SizedBox(height: 12),
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
            // Featured Dishes Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Featured Indian Dishes (${selectedCategory})',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            SizedBox(height: 12),
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
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: filteredDishes.length,
                      itemBuilder: (context, index) {
                        final dish = filteredDishes[index];
                        return FeaturedDishTile(
                          name: dish['name']!,
                          image: _getAssetPath(dish['image']!),
                          price: dish['price']!,
                          rating: dish['rating']!,
                          onTap: () {
                            // On tap, navigate to CheckoutPage with this item
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
                                    '${dish['name']} selected for checkout!'),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

// Category Tile Widget (Not used since we switched to ActionChip)
class CategoryTile extends StatelessWidget {
  final String icon;
  final String name;
  final VoidCallback onTap;

  CategoryTile({required this.icon, required this.name, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        margin: EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              icon,
              style: TextStyle(fontSize: 30),
            ),
            SizedBox(height: 8),
            Text(
              name,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xffff9b48),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Featured Dish Tile Widget
class FeaturedDishTile extends StatelessWidget {
  final String name;
  final String image;
  final double price;
  final double rating;
  final VoidCallback onTap;

  FeaturedDishTile({
    required this.name,
    required this.image,
    required this.price,
    required this.rating,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Redirects to CheckoutPage
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 8),
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image(
                  image: AssetImage(image),
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    print('Error loading image: $image, Error: $error');
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
                      name,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '₹${price.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xffff9b48),
                      ),
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.star, size: 16, color: Colors.amber),
                        SizedBox(width: 4),
                        Text(
                          rating.toString(),
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(Icons.add_shopping_cart, color: Color(0xffff9b48)),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('$name added to cart!')),
                  );
                  // Optionally navigate to CheckoutPage immediately
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CheckoutPage(
                        cartItems: [
                          {
                            'name': name,
                            'image': image,
                            'price': price,
                            'quantity': 1,
                            'rating': rating,
                          }
                        ],
                        subtotal: price,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
