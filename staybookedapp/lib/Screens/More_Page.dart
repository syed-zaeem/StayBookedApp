import 'dart:js_util';

import 'package:flutter/material.dart';

class MorePage extends StatefulWidget {
  const MorePage({super.key});

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Welcome Ammar Zaidi",
          style: TextStyle(color: Color.fromARGB(255, 192, 116, 2)),
        ),
        // backgroundColor: Colors.grey[350],
      ),
      body: Column(
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Text(
              "My Account",
              style: TextStyle(color: Color.fromARGB(239, 95, 94, 94)),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Divider(
              color:
                  Color.fromARGB(239, 95, 94, 94), // Adjust the color as needed
              height: 1, // Adjust the height as needed
              thickness: 1, // Adjust the thickness as needed
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                ListTile(
                  leading: const Icon(
                    Icons.star_outline_rounded,
                    color: Color.fromARGB(239, 95, 94, 94),
                  ),
                  title: const Text(
                    'My Reviews',
                    style: TextStyle(color: Color.fromARGB(239, 95, 94, 94)),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/MyReviews');
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.monetization_on_outlined,
                    color: Color.fromARGB(239, 95, 94, 94),
                  ),
                  title: const Text(
                    'Price Display',
                    style: TextStyle(color: Color.fromARGB(239, 95, 94, 94)),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/PriceDisplay');
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.help_center_outlined,
                    color: Color.fromARGB(239, 95, 94, 94),
                  ),
                  title: const Text(
                    'Help Center',
                    style: TextStyle(color: Color.fromARGB(239, 95, 94, 94)),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/HelpCenter');
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.person_pin,
                    color: Color.fromARGB(239, 95, 94, 94),
                  ),
                  title: const Text(
                    'About Us',
                    style: TextStyle(color: Color.fromARGB(239, 95, 94, 94)),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/AboutUs');
                  },
                ),
                // Add more ListTiles as needed
              ],
            ),
          ),
          // Padding(
          //   padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
          //   child: Row(
          //     children: <Widget>[
          //       Icon(
          //         Icons.star_outline_rounded,
          //         color: Color.fromARGB(239, 95, 94, 94),
          //       ),
          //       Padding(
          //         padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
          //         child: Text(
          //           "My Reviews",
          //           style: TextStyle(color: Color.fromARGB(239, 95, 94, 94)),
          //         ),
          //       )
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }
}
