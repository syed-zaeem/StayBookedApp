import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_database/firebase_database.dart';

class DetailedHotelPage extends StatefulWidget {
  const DetailedHotelPage({super.key});

  @override
  State<DetailedHotelPage> createState() => _DetailedHotelPageState();
}

class _DetailedHotelPageState extends State<DetailedHotelPage> {
  // List<String> images = [
  //   'https://images.unsplash.com/photo-1625244724120-1fd1d34d00f6?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aG90ZWxzfGVufDB8fDB8fHww',
  //   'https://images.unsplash.com/photo-1571896349842-33c89424de2d?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8N3x8aG90ZWxzfGVufDB8fDB8fHww',
  //   'https://images.unsplash.com/photo-1551882547-ff40c63fe5fa?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8aG90ZWxzfGVufDB8fDB8fHww',
  // ];

  String? _selectedRating;
  List<String> ratingOptions = ['1', '2', '3', '4', '5'];

  TextEditingController messageController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  Map<String, dynamic> hotelsData = {};

  Future<void> fetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("SharedPreferences keys: ${prefs.getKeys()}");
    String? hotelsDataString = prefs.getString('detailedHotel');
    print(hotelsDataString);
    print("Good Work");

    if (hotelsDataString != null) {
      Map<String, dynamic> decodedData = jsonDecode(hotelsDataString);
      // List<Map<String, dynamic>> fetchedHotelsData =
      //     List<Map<String, dynamic>>.from(decodedData);

      setState(() {
        hotelsData = decodedData;
      });
    } else {
      // Handle the case when there's no data in SharedPreferences
      // You might want to fetch data from the server here if needed
    }
  }

  Future<void> getData() async {
    await fetchData();
  }

  @override
  void initState() {
    super.initState();
    getData().then((_) {
      print("hotels data In Detailed page");
      print(hotelsData);
    });
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);

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
    double containerPadding = screenWidth < 400
        ? 15
        : screenWidth < 500
            ? 20
            : screenWidth < 600
                ? 30.0
                : screenWidth < 700
                    ? 40.0
                    : 50.0;
    double buttonPaddingLeft = screenWidth < 400
        ? 120
        : screenWidth < 500
            ? 160
            : screenWidth < 600
                ? 200
                : screenWidth < 700
                    ? 240.0
                    : 250.0;
    double buttonPaddingRight = screenWidth < 400
        ? 0
        : screenWidth < 500
            ? 20
            : screenWidth < 600
                ? 30.0
                : screenWidth < 700
                    ? 40.0
                    : 100.0;

    double fontSize = screenWidth < 400
        ? 15.0
        : screenWidth < 600
            ? 16.0
            : 18.0;
    double iconSize = screenWidth < 400
        ? 20.0
        : screenWidth < 600
            ? 24.0
            : 26.0;
    double verticalHeight = screenHeight < 400 ? 8 : 12;
    double buttonFont = screenWidth < 400 ? 18 : 20;
    double buttonPadding = screenWidth < 400 ? 6 : 8;
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

    List<String> images =
        (hotelsData['images'] as List<dynamic>).cast<String>();
    print("Images for detailed page are:");
    print(images);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Hotels For You",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(containerPadding, 20, containerPadding, 0),
        child: ListView(
          children: <Widget>[
            Column(
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
                          // Customize carousel options as needed
                          ),
                      items: images.map((url) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
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
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Text(
                    hotelsData['name'],
                    style: TextStyle(
                        fontSize: fontName, fontWeight: FontWeight.bold),
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
                    hotelsData['location'],
                    style: TextStyle(
                        fontSize: fontLocation, fontWeight: FontWeight.w500),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  buttonPaddingLeft, 0, buttonPaddingRight, 0),
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.orange)),
                  onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setString(
                        'detailedHomeRoomsOwner', hotelsData['owner']);

                    Navigator.pushNamed(context, "/ViewHotelRooms");
                  },
                  child: Text(
                    "See All Rooms",
                    style:
                        TextStyle(fontSize: fontLocation, color: Colors.white),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 50, 0, 10),
              child: Center(
                  child: Text(
                "Send Feedback",
                style: TextStyle(
                    fontSize: fontName + 4, fontWeight: FontWeight.bold),
              )),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                0,
                20,
                0,
                10,
              ),
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: "Enter your Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: verticalHeight),
                  prefixIcon: Padding(
                    padding: EdgeInsets.fromLTRB(
                        iconPaddingLeft, 0, iconPaddingRight, 0),
                    child: Icon(
                      Icons.person,
                      size: iconSize,
                    ),
                  ),
                ),
                style: TextStyle(fontSize: fontSize),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                0,
                0,
                0,
                10,
              ),
              child: TextField(
                controller: messageController,
                decoration: InputDecoration(
                  hintText: "Enter the Message",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: verticalHeight),
                  prefixIcon: Padding(
                    padding: EdgeInsets.fromLTRB(
                        iconPaddingLeft, 0, iconPaddingRight, 0),
                    child: Icon(
                      Icons.message,
                      size: iconSize,
                    ),
                  ),
                ),
                style: TextStyle(fontSize: fontSize),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                0,
                0,
                0,
                10,
              ),
              child: DropdownButtonFormField<String>(
                value: _selectedRating,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                        30), // Adjust the radius value as needed
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: verticalHeight),
                  hintText: "Select the Rating",
                  prefixIcon: Padding(
                    padding: EdgeInsets.fromLTRB(
                        iconPaddingLeft, 0, iconPaddingRight, 0),
                    child: Icon(
                      Icons.star,
                      size: iconSize,
                    ),
                  ),
                ),
                items: ratingOptions.map((String roomtype) {
                  return DropdownMenuItem<String>(
                    value: roomtype,
                    child: Text(roomtype),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedRating = newValue;
                  });
                },
                style: TextStyle(fontSize: fontSize),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 80),
              child: Container(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () async {
                      try {
                        print("Fucntion Called");
                        final prefs = await SharedPreferences.getInstance();
                        print(prefs.getString('customerEmail'));

                        Map<String, dynamic> feedbackData = {
                          "name": nameController.text,
                          "message": messageController.text,
                          "rating": _selectedRating,
                          "hotelForRating": hotelsData['owner'],
                          "customerForRating": prefs.getString('customerEmail'),
                          "date": DateTime.now().toString(),
                        };
                        print(feedbackData);
                        // Add the room data to Firestore
                        DatabaseReference reference =
                            FirebaseDatabase.instance.reference();

                        // Add the room data to Realtime Database
                        await reference
                            .child('Feedbacks')
                            .push()
                            .set(feedbackData);
                        print("Here and there");
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Feedback Send'),
                              content: Text('Feedback Send successfully!'),
                            );
                          },
                        );
                        print("Feedback Send SuccessFully ..... ");

                        nameController.clear();
                        messageController.clear();
                      } catch (e) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Error Error Sending Feedback'),
                              content: Text(
                                  'An error occurred while sending the feedback: $e'),
                            );
                          },
                        );
                      }
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.orange)),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                          0, buttonPadding, 0, buttonPadding),
                      child: Text(
                        "Send Feedback",
                        style: TextStyle(
                            fontSize: buttonFont,
                            color: Colors.white,
                            fontWeight: FontWeight.w900),
                      ),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
