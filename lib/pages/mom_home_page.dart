import 'package:flutter/material.dart';
import 'mom_orders_page.dart'; // To be created
import 'mom_menu_editor_page.dart'; // To be created
import 'mom_profile_page.dart'; // To be created

class MomHomePage extends StatefulWidget {
  @override
  _MomHomePageState createState() => _MomHomePageState();
}

class _MomHomePageState extends State<MomHomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    MomOrdersPage(),
    MomMenuEditorPage(),
    MomProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 15,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          selectedItemColor: Color(0xffffb948),
          unselectedItemColor: Colors.grey,
          backgroundColor: Colors.transparent,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.list_alt), label: 'Orders'),
            BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: 'Menu'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
