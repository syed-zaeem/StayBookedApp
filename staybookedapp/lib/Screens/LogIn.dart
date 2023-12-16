// import 'dart:math';

import 'package:bookingapplication2/Screens/Home_Page_Customer.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

// import 'package:http/http.dart' as http;
import 'package:bookingapplication2/responsive/desktop_body.dart';
// import 'dart:convert';

import 'package:bookingapplication2/responsive/desktop_body.dart';
import 'package:bookingapplication2/responsive/table_body.dart';
import 'package:bookingapplication2/responsive/mobile_body.dart';
import 'package:bookingapplication2/responsive/responsive_layout.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogIn extends StatelessWidget {
  const LogIn({super.key});

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    final FirebaseAuth _auth = FirebaseAuth.instance;
    List<UserData> items = [];

    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    // final String apiUrl = 'http://localhost:8000/login';

    // Future<String> login() async {
    //   // final response = await http.post(
    //   //   Uri.parse(apiUrl),
    //   //   headers: {"Content-Type": "application/json"},
    //   //   body: json.encode({
    //   //     "username": usernameController.text,
    //   //     "password": passwordController.text,
    //   //   }),
    //   // );
    //   // if (response.statusCode == 200) {
    //   //   // If the status code is 200, return 'ok'
    //   //   return 'ok';
    //   // } else {
    //   //   // If the status code is not 200, return 'Failed'
    //   //   return 'Failed';
    //   // }
    // }
    Future<String?> getUserRole(String email) async {
      final usersReference =
          FirebaseDatabase.instance.reference().child('users');
      final snapshot = await usersReference.get();

      for (var childSnapshot in snapshot.children) {
        final usersData = childSnapshot.value as Map<String, dynamic>;

        // Access the email value within the child's data

        //Check if child email matches the provided email
        if (usersData["email"] == email) {
          final role = childSnapshot.child('role').value as String;
          print('User with email: $email has role: $role');
          return role;
        }
      }

      print('User with email: $email not found or has no role assigned.');
      return null;
    }

    Future<void> signIn() async {
      try {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: usernameController.text,
          password: passwordController.text,
        );

        print('User logged in: ${userCredential.user?.email}');

        final userRole = await getUserRole(usernameController.text);

        if (userRole != null) {
          print('User role: $userRole');
        } else {
          print('User role not found.');
        }

        if (userRole == "Manager") {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('userEmail', usernameController.text);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ResponsiveLayout(
                mobileBody: const MobileScaffold(),
                tabletBody: const TabletScaffold(),
                desktopBody: const DesktopScaffold(),
              ),
            ),
          );
        } else if (userRole == "Customer") {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('customerEmail', usernameController.text);
          // print(usernameController.text);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePageCustomer()),
          );
        }

        // Navigate to another screen or perform additional actions after login
      } on FirebaseAuthException catch (e) {
        print('Error during login: ${e.message}');
      }
    }

    double screenWidth = mediaQuery.size.width;
    double screenHeight = mediaQuery.size.height;

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
    double lastlinepaddingleft = screenWidth < 600 ? 0.0 : 20.0;
    double lastlinefontsize = screenWidth < 450 ? 12 : 16;
    double buttonFont = screenWidth < 400 ? 18 : 20;
    double buttonPadding = screenWidth < 400 ? 6 : 8;
    double mainPadding = screenWidth < 400
        ? 30
        : screenWidth < 600
            ? 40
            : screenWidth < 800
                ? 100
                : screenWidth < 1000
                    ? 200
                    : 320;
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
      body: Container(
          width: double.maxFinite,
          child: Padding(
              padding: EdgeInsets.fromLTRB(mainPadding, 60, mainPadding, 0),
              child: Column(
                children: <Widget>[
                  const Text(
                    "StayBooked",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 192, 116, 2)),
                  ),
                  Container(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                        child: Column(
                          children: <Widget>[
                            const Text(
                              "Log In to your Account",
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                0,
                                30,
                                0,
                                10,
                              ),
                              child: TextField(
                                controller: usernameController,
                                decoration: InputDecoration(
                                  hintText: "Enter your Email",
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
                                40,
                              ),
                              child: TextField(
                                controller: passwordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  hintText: "Enter your Password",
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
                                    child: Icon(
                                      Icons.lock,
                                      size: iconSize,
                                    ),
                                  ),
                                ),
                                style: TextStyle(fontSize: fontSize),
                              ),
                            ),
                            // Expanded(
                            Container(
                              width: double.infinity,
                              child: ElevatedButton(
                                  onPressed: signIn,
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.orange)),
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        0, buttonPadding, 0, buttonPadding),
                                    child: Text(
                                      "Log In",
                                      style: TextStyle(
                                          fontSize: buttonFont,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w900),
                                    ),
                                  )),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(
                                  lastlinepaddingleft, 20, 0, 0),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    "Don't have an Account ",
                                    style:
                                        TextStyle(fontSize: lastlinefontsize),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pushNamed(context, "/Signup");
                                      },
                                      child: Text(
                                        "Sign Up Here",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: lastlinefontsize),
                                      ))
                                ],
                              ),
                            )
                            // )
                          ],
                        ),
                      ))
                ],
              ))),
    );
  }
}

class UserData {
  final String? name;
  final String? dateOfBirth;
  final String? gender;
  final String? role;
  final String? username;
  final String? password;
  final String? email;
  final String? contact;
  final String? address;

  UserData({
    required this.email,
    this.dateOfBirth,
    this.gender,
    this.role,
    this.username,
    this.password,
    this.name,
    this.contact,
    this.address,
  });
  factory UserData.fromMap(Map<dynamic, dynamic> map) {
    return UserData(
      name: map['name'],
      dateOfBirth: map['dateOfBirth'],
      gender: map['gender'],
      role: map['role'],
      username: map['username'],
      password: map['password'],
      email: map['email'],
      contact: map['contact'],
      address: map['address'],
    );
  }
  factory UserData.fromJson(Map<String, dynamic> json) {
    var status = json['status'];
    if (status is List) {
      // If 'status' is a list, convert it to a comma-separated string
      status = status.join(', ');
    }
    print("Status");
    print(status);
    var roomType = json['roomType'];
    if (roomType is List) {
      // If 'status' is a list, convert it to a comma-separated string
      roomType = roomType.join(', ');
    }
    var gendertype = json['gendertype'];
    if (gendertype is List) {
      // If 'status' is a list, convert it to a comma-separated string
      gendertype = gendertype.join(', ');
    }

    return UserData(
      name: json['name'],
      dateOfBirth: json['dateOfBirth'],
      gender: gendertype,
      role: json['role'],
      username: json['username'],
      password: json['password'],
      email: json['email'],
      contact: json['contact'],
      address: json['address'],
    );
  }
}
