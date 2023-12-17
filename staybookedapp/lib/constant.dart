import 'package:flutter/material.dart';

var defaultBackgroundColor = Colors.grey[300];
var appBarColor = Colors.grey[900];
var myAppBar = AppBar(
  // backgroundColor: appBarColor,
  backgroundColor: Colors.orange,
  title: const Text(
    'StayBooked',
    style: TextStyle(fontWeight: FontWeight.bold),
  ),
  centerTitle: true,
);
var drawerTextColor = const TextStyle(
  color: Color.fromARGB(255, 0, 0, 0),
);

var tilePadding = const EdgeInsets.only(left: 8.0, right: 8, top: 8);

var darkBlue = Color.fromARGB(255, 255, 255, 255);
var drawerBackgroundColor = darkBlue;

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  IconData selectedIcon = Icons.home;
  bool isHovered = false;

  void handleHover(bool isHovering) {
    setState(() {
      isHovered = isHovering;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: drawerBackgroundColor,
      elevation: 0,
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: appBarColor,
            ),
            child: Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(
                      'https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?auto=format&fit=crop&q=80&w=1740&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'StayBooked',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: tilePadding,
            child: ListTile(
              leading: MouseRegion(
                onEnter: (_) {
                  handleHover(true);
                },
                onExit: (_) {
                  handleHover(false);
                },
                child: Icon(
                  Icons.home,
                  color: selectedIcon == Icons.home || isHovered
                      ? Colors.orange
                      : const Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              title: Text(
                'DASHBOARD',
                style: drawerTextColor,
              ),
              onTap: () {
                setState(() {
                  selectedIcon = Icons.home;
                });
              },
            ),
          ),
          Padding(
            padding: tilePadding,
            child: ListTile(
              leading: MouseRegion(
                onEnter: (_) {
                  handleHover(true);
                },
                onExit: (_) {
                  handleHover(false);
                },
                child: Icon(
                  Icons.business,
                  color: selectedIcon == Icons.business || isHovered
                      ? Colors.orange
                      : const Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              title: Text(
                'Edit Hotel',
                style: drawerTextColor,
              ),
              onTap: () {
                setState(() {
                  selectedIcon = Icons.business;
                });
                Navigator.pushNamed(context, "/EditHotelOrHomeManager");
              },
            ),
          ),
          Padding(
            padding: tilePadding,
            child: ListTile(
              leading: MouseRegion(
                onEnter: (_) {
                  handleHover(true);
                },
                onExit: (_) {
                  handleHover(false);
                },
                child: Icon(
                  Icons.star,
                  color: selectedIcon == Icons.star || isHovered
                      ? Colors.orange
                      : const Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              title: Text(
                'Reviews',
                style: drawerTextColor,
              ),
              onTap: () {
                setState(() {
                  selectedIcon = Icons.star;
                });
                Navigator.pushNamed(context, "/ViewFeedbacksManager");
              },
            ),
          ),
          Padding(
            padding: tilePadding,
            child: ListTile(
              leading: MouseRegion(
                onEnter: (_) {
                  handleHover(true);
                },
                onExit: (_) {
                  handleHover(false);
                },
                child: Icon(
                  Icons.logout,
                  color: selectedIcon == Icons.logout || isHovered
                      ? Colors.orange
                      : const Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              title: Text(
                'LOGOUT',
                style: drawerTextColor,
              ),
              onTap: () {
                Navigator.pushNamed(context, "/Login");
                setState(() {
                  selectedIcon = Icons.logout;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
