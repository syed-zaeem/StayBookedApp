import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double imageWidthPercentage = 0.4; // 20%

    // double screenWidth = mediaQuery.size.width;
    // double screenHeight = mediaQuery.size.height;

    double hotelsPadding = screenWidth >= 300 && screenWidth < 500
        ? 12
        : screenWidth >= 500 && screenWidth < 700
            ? 15
            : 25;

    double hotelsFontSize = screenWidth >= 300 && screenWidth < 500
        ? 18
        : screenWidth >= 500 && screenWidth < 700
            ? 20
            : 22;

    double firstImagePadding = screenWidth >= 300 && screenWidth < 350
        ? 75
        : screenWidth >= 350 && screenWidth < 400
            ? 106
            : screenWidth >= 400 && screenWidth < 450
                ? 135
                : screenWidth >= 450 && screenWidth < 500
                    ? 163
                    : screenWidth >= 500 && screenWidth < 550
                        ? 187
                        : screenWidth >= 550 && screenWidth < 600
                            ? 216
                            : screenWidth >= 600 && screenWidth < 650
                                ? 245
                                : screenWidth >= 650 && screenWidth < 700
                                    ? 275
                                    : 290;
    double secondImagePadding = screenWidth >= 300 && screenWidth < 350
        ? 12
        : screenWidth >= 350 && screenWidth < 400
            ? 42
            : screenWidth >= 400 && screenWidth < 450
                ? 72
                : screenWidth >= 450 && screenWidth < 500
                    ? 100
                    : screenWidth >= 500 && screenWidth < 550
                        ? 116
                        : screenWidth >= 550 && screenWidth < 600
                            ? 146
                            : screenWidth >= 600 && screenWidth < 650
                                ? 174
                                : screenWidth >= 650 && screenWidth < 700
                                    ? 204
                                    : 213;

    return Scaffold(
      // appBar: AppBar(
      //   title: const Text(
      //     "StayBooked",
      //     style: TextStyle(color: Colors.white),
      //   ),
      //   backgroundColor: Colors.blue,
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 30, 18, 0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, "/ViewHotels");
                },
                child: Container(
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.transparent),
                      color: Colors.orange[300],
                      borderRadius: BorderRadius.circular(30)),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(hotelsPadding, 0, 0, 50),
                        child: Text(
                          "Hotels",
                          style: TextStyle(
                              fontSize: hotelsFontSize,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.fromLTRB(firstImagePadding, 0, 0, 0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30.0),
                          child: Image.asset(
                            'assets/OIP.jpg',
                            width: screenWidth * imageWidthPercentage,
                            height: 110,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 15, 18, 0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/ViewHomes');
                },
                child: Container(
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.transparent),
                      color: Colors.orange[300],
                      borderRadius: BorderRadius.circular(30)),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(hotelsPadding, 0, 0, 50),
                        child: Text(
                          "Homes & Apts",
                          style: TextStyle(
                              fontSize: hotelsFontSize,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.fromLTRB(secondImagePadding, 0, 0, 0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30.0),
                          child: Image.asset(
                            'assets/th.jpg',
                            width: screenWidth * imageWidthPercentage,
                            height: 110,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
