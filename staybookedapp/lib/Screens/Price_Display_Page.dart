import 'package:flutter/material.dart';

class PriceDisplayPage extends StatefulWidget {
  const PriceDisplayPage({super.key});

  @override
  State<PriceDisplayPage> createState() => _PriceDisplayPageState();
}

class _PriceDisplayPageState extends State<PriceDisplayPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Price Display",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.orange,
      ),
      body: Column(
        children: <Widget>[
          // const Padding(
          //   padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
          //   child: Text(
          //     "My Account",
          //     style: TextStyle(color: Color.fromARGB(239, 95, 94, 94)),
          //   ),
          // ),
          const Text(
            'Price For Display',
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 192, 116, 2)),
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
              children: const <Widget>[
                ListTile(
                  title: Text(
                    'Pakistan Rupee (\u20A8)',
                    style: TextStyle(color: Color.fromARGB(239, 95, 94, 94)),
                  ),
                ),
                ListTile(
                  title: Text(
                    'British Pound (\u00A3)',
                    style: TextStyle(color: Color.fromARGB(239, 95, 94, 94)),
                  ),
                ),
                ListTile(
                  title: Text(
                    'Afghani (AFN)',
                    style: TextStyle(color: Color.fromARGB(239, 95, 94, 94)),
                  ),
                ),
                ListTile(
                  title: Text(
                    'Arab Emirates Dirham (AED)',
                    style: TextStyle(color: Color.fromARGB(239, 95, 94, 94)),
                  ),
                ),
                ListTile(
                  title: Text(
                    'Australian Dollar (AUD)',
                    style: TextStyle(color: Color.fromARGB(239, 95, 94, 94)),
                  ),
                ),
                ListTile(
                  title: Text(
                    'Bangladeshi Taka (BDT)',
                    style: TextStyle(color: Color.fromARGB(239, 95, 94, 94)),
                  ),
                ),
                ListTile(
                  title: Text(
                    'Brazilian Real (BRL)',
                    style: TextStyle(color: Color.fromARGB(239, 95, 94, 94)),
                  ),
                ),
                ListTile(
                  title: Text(
                    'Canadian Dollar (CAD)',
                    style: TextStyle(color: Color.fromARGB(239, 95, 94, 94)),
                  ),
                ),
                ListTile(
                  title: Text(
                    'Euro (EUR)',
                    style: TextStyle(color: Color.fromARGB(239, 95, 94, 94)),
                  ),
                ),
                ListTile(
                  title: Text(
                    'Indian Rupee (INR)',
                    style: TextStyle(color: Color.fromARGB(239, 95, 94, 94)),
                  ),
                ),
                ListTile(
                  title: Text(
                    'US Dollar (USD)',
                    style: TextStyle(color: Color.fromARGB(239, 95, 94, 94)),
                  ),
                ),
                ListTile(
                  title: Text(
                    'Ukranian Grivna (UAD)',
                    style: TextStyle(color: Color.fromARGB(239, 95, 94, 94)),
                  ),
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
