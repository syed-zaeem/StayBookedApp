import 'package:bookingapplication2/Screens/About_Us_Page.dart';
import 'package:bookingapplication2/Screens/Cart_Page.dart';
import 'package:bookingapplication2/Screens/Contact_Us_Page.dart';
import 'package:bookingapplication2/Screens/Home_Page.dart';
import 'package:bookingapplication2/Screens/More_Page.dart';
import 'package:bookingapplication2/Screens/My_Reviews_Page.dart';
import 'package:bookingapplication2/Screens/Price_Display_Page.dart';
import 'package:bookingapplication2/Screens/Trips_Page_Customer.dart';
import 'package:flutter/material.dart';

class HomePageCustomer extends StatefulWidget {
  const HomePageCustomer({super.key});

  @override
  State<HomePageCustomer> createState() => _HomePageCustomerState();
}

class _HomePageCustomerState extends State<HomePageCustomer> {
  int _currentIndex = 0;

  // Define your pages/screens here
  final List<Widget> _pages = [
    // Replace with your actual screens
    HomePage(),
    // MyReviewsPage(),
    // PriceDisplayPage(),
    // AboutUsPgae(),
    // ContactUsPage(),
    MyTripPage(),
    CartPage(),
    MorePage(), // Add the new screen for the fourth item
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "StayBooked",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          PopupMenuButton<String>(
            color: Colors.white,
            iconSize: 30,
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem<String>(
                  value: 'item1',
                  child: Text('Sign Up'),
                ),
                const PopupMenuItem<String>(
                  value: 'item2',
                  child: Text('Log In'),
                ),
                const PopupMenuItem<String>(
                  value: 'item3',
                  child: Text('Item 3'),
                ),
              ];
            },
            onSelected: (String value) {
              switch (value) {
                case 'item1':
                  Navigator.pushNamed(context, "/Signup");
                  break;
                case 'item2':
                  Navigator.pushNamed(context, "/Login");
                  break;
                case 'item3':
                  // Handle item 3 selection
                  break;
              }
            },
          ),
        ],
        backgroundColor: Colors.orange,
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_rounded),
            label: 'My Trips',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'More',
          ),
        ],
      ),
    );
  }
}

class Screen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Screen 1 Content'),
    );
  }
}

class Screen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Screen 2 Content'),
    );
  }
}

class Screen3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Screen 3 Content'),
    );
  }
}

class Screen4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Screen 4 Content'),
    );
  }
}
