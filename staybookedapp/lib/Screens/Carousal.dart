import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ImageCarousal extends StatefulWidget {
  const ImageCarousal({super.key});

  @override
  State<ImageCarousal> createState() => _ImageCarousalState();
}

class _ImageCarousalState extends State<ImageCarousal> {
  List<Map<String, dynamic>> hotelsData = [];
  late Future<List<Map<String, dynamic>>> hotelsDataFuture;

  Future<void> fetchData() async {
    print("FETCHDATA CALLED");
    final databaseReference = FirebaseDatabase.instance.reference();
    final snapshot = await databaseReference.child('Accommodations').get();

    if (snapshot.exists) {
      Map<String, dynamic> hotelsMap = snapshot.value as Map<String, dynamic>;
      List<Map<String, dynamic>> ho = [];

      hotelsMap.forEach((key, value) {
        if (value['type'] == 'Hotel') {
          ho.add(value as Map<String, dynamic>);
        } else {}
      });

      setState(() {
        hotelsData = ho;
      }); // Initialize hotelsData with the collected data
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('hotelsData', jsonEncode(hotelsData));
      print("hotels data");
      print(hotelsData);
    }
  }

  // final response = await http.get(Uri.parse(widget.apiUrl));
  // print(response.statusCode);
  // print("FETCHED");
  // print(response.body);
  // if (response.statusCode == 200) {
  //   final List<dynamic> responseData = json.decode(response.body);
  //   setState(() {
  //     widget.items = responseData.map((item) => Item.fromJson(item)).toList();
  //   });
  // }

  // final List<String> images = [
  // 'https://images.unsplash.com/photo-1625244724120-1fd1d34d00f6?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aG90ZWxzfGVufDB8fDB8fHww',
  // 'https://images.unsplash.com/photo-1571896349842-33c89424de2d?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8N3x8aG90ZWxzfGVufDB8fDB8fHww',
  // 'https://images.unsplash.com/photo-1551882547-ff40c63fe5fa?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8aG90ZWxzfGVufDB8fDB8fHww',
  //   // Add more image URLs as needed
  // ];

  @override
  void initState() {
    super.initState();
    fetchData().then((_) {
      print("hotels data");
      print(hotelsData);
    });
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);

    TextEditingController searchNameController = TextEditingController();
    TextEditingController searchLocationController = TextEditingController();

    double screenWidth = mediaQuery.size.width;
    double screenHeight = mediaQuery.size.height;

    double fontName = screenWidth < 400
        ? 18.0 // Font size for screen width less than 400
        : screenWidth < 500
            ? 20.0
            : screenWidth < 600
                ? 22.0 // Font size for screen width less than 600
                : 22.0; // Default
    double fontLocation = screenWidth < 400
        ? 14.0 // Font size for screen width less than 400
        : screenWidth < 500
            ? 16.0
            : screenWidth < 600
                ? 18.0 // Font size for screen width less than 600
                : 18.0; // Default
    double containerPadding = screenWidth < 400
        ? 15
        : screenWidth < 500
            ? 20
            : screenWidth < 600
                ? 30.0
                : screenWidth < 700
                    ? 40.0
                    : 50.0;
    double buttonsPadding = screenWidth < 400
        ? 1
        : screenWidth < 500
            ? 15
            : screenWidth < 600
                ? 30.0
                : screenWidth < 700
                    ? 40.0
                    : 50.0;
    double containerHeight = screenWidth < 400
        ? 180.0 // Font size for screen width less than 400
        : screenWidth < 500
            ? 200.0
            : screenWidth < 600
                ? 220.0
                : 220.0;
    double imageHeight = screenWidth < 400
        ? 160.0 // Font size for screen width less than 400
        : screenWidth < 500
            ? 180.0
            : screenWidth < 600
                ? 200.0
                : 200.0;
    double fontSize = screenWidth < 400
        ? 15.0 // Font size for screen width less than 400
        : screenWidth < 600
            ? 16.0 // Font size for screen width less than 600
            : 18.0; // Default
    double iconSize = screenWidth < 400
        ? 20.0 // Font size for screen width less than 400
        : screenWidth < 600
            ? 24.0
            : 26.0;
    double verticalHeight = screenHeight < 400 ? 8 : 12;
    double iconPaddingLeft = screenWidth < 400
        ? 0
        : screenWidth < 600
            ? 8
            : screenWidth < 800
                ? 12
                : screenWidth < 1000
                    ? 16
                    : 20;
    double iconPaddingRight = screenWidth < 400
        ? 0
        : screenWidth < 600
            ? 8
            : screenWidth < 800
                ? 12
                : screenWidth < 1000
                    ? 16
                    : 20;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(containerPadding, 20, containerPadding, 0),
        child: ListView(
          children: [
            Padding(
              padding:
                  EdgeInsets.fromLTRB(buttonsPadding, 0, buttonsPadding, 20),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color.fromARGB(255, 128, 126, 126)),
                    borderRadius: BorderRadius.circular(20)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                child: Column(
                                  // mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    ListTile(
                                      leading: const Icon(Icons.close),
                                      title: const Text('Cancel'),
                                      onTap: () {
                                        Navigator.pop(
                                            context); // Close the bottom sheet
                                      },
                                    ),
                                    Divider(),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                        30,
                                        40,
                                        30,
                                        10,
                                      ),
                                      child: TextField(
                                        controller: searchNameController,
                                        decoration: InputDecoration(
                                          hintText: "Enter the name of Hotel",
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                                30), // Adjust the radius value as needed
                                          ),
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: verticalHeight),
                                          prefixIcon: Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                iconPaddingLeft,
                                                0,
                                                iconPaddingRight,
                                                0),
                                            child: Icon(Icons.search,
                                                size: iconSize),
                                          ),
                                        ),
                                        style: TextStyle(fontSize: fontSize),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 20, 0, 0),
                                      child: ElevatedButton(
                                          onPressed: () {},
                                          child: const Text(
                                            "Search Hotel",
                                            style: TextStyle(fontSize: 20),
                                          )),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        child: Text(
                          'Search By Name',
                          style: TextStyle(fontSize: fontLocation - 2),
                        )),
                    Container(
                      height: 30, // Adjust the height as needed
                      child: const VerticalDivider(),
                    ),
                    TextButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              child: Column(
                                // mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  ListTile(
                                    leading: const Icon(Icons.close),
                                    title: const Text('Cancel'),
                                    onTap: () {
                                      Navigator.pop(
                                          context); // Close the bottom sheet
                                    },
                                  ),
                                  Divider(),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                      30,
                                      40,
                                      30,
                                      10,
                                    ),
                                    child: TextField(
                                      controller: searchLocationController,
                                      decoration: InputDecoration(
                                        hintText: "Enter the location",
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              30), // Adjust the radius value as needed
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: verticalHeight),
                                        prefixIcon: Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              iconPaddingLeft,
                                              0,
                                              iconPaddingRight,
                                              0),
                                          child: Icon(Icons.search,
                                              size: iconSize),
                                        ),
                                      ),
                                      style: TextStyle(fontSize: fontSize),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 20, 0, 0),
                                    child: ElevatedButton(
                                        onPressed: () {},
                                        child: const Text(
                                          "Search Hotel",
                                          style: TextStyle(fontSize: 20),
                                        )),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: Text(
                        'Search By Location',
                        style: TextStyle(fontSize: fontLocation - 2),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Column(
              children: hotelsData?.map((hotel) {
                    print("i am here");
                    print(hotel['images']);
                    // List<String> images = hotel['images'] as List<String>;
                    List<String> images =
                        (hotel['images'] as List<dynamic>).cast<String>();

                    print("i am at next hotels of images");
                    print(hotel);
                    return GestureDetector(
                      onTap: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setString('detailedHotel', jsonEncode(hotel));

                        Navigator.pushNamed(context, "/DetailedOneHotel");
                      },
                      child: Column(
                        children: [
                          Container(
                            height: containerHeight,
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                color: Colors.grey[200]),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(40),
                              clipBehavior: Clip.antiAlias,
                              child: CarouselSlider(
                                options: CarouselOptions(
                                  height: containerHeight,
                                ),
                                items: images.map((url) {
                                  return Builder(
                                    builder: (BuildContext context) {
                                      return Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: const BoxDecoration(),
                                        child: Column(
                                          children: [
                                            Image.network(
                                              url,
                                              fit: BoxFit.cover,
                                              height: imageHeight,
                                              width: double.maxFinite,
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Text(
                                  hotel['name'],
                                  style: TextStyle(
                                      fontSize: fontName,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                            child: Row(
                              children: [
                                Text(
                                  hotel['location'],
                                  style: TextStyle(
                                      fontSize: fontLocation,
                                      fontWeight: FontWeight.w500),
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  })?.toList() ??
                  [],
            )
          ],
        ),
      ),
    );
  }
}
