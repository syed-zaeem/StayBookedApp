import 'package:bookingapplication2/Screens/Carousal.dart';
import 'package:flutter/material.dart';
// import 'package:carousel_slider/carousel_slider.dart';

class ViewHotelsPage extends StatefulWidget {
  const ViewHotelsPage({super.key});

  @override
  State<ViewHotelsPage> createState() => _ViewHotelsPageState();
}

class _ViewHotelsPageState extends State<ViewHotelsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Hotels For You",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.orange,
      ),
      body: ImageCarousal(),
      // body: ListView(
      //   children: <Widget>[Text("data")],
      // ),
    );
  }
}
