import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';

class SignUpManager extends StatefulWidget {
  const SignUpManager({super.key});

  @override
  State<SignUpManager> createState() => _SignUpManagerState();
}

class _SignUpManagerState extends State<SignUpManager> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _selectedGender;
  String? _selectedAccomodation;
  List<String> genderOptions = ['Male', 'Female', 'Other'];
  List<String> roleOptions = ['Seller', 'Customer'];
  List<String> accomodationOptions = ['Hotel', 'Home & Appartment'];

  DateTime? _selectedDate;

  TextEditingController dateController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController accomodationController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  // final String apiUrl = 'http://localhost:8000/signup';

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        dateController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  Future<void> signUp() async {
    if (_formKey.currentState!.validate()) {
      try {
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          password: passwordController.text,
          email: emailController.text,
        );
        await _saveUserDataToFirestore(userCredential.user);

        // Add your code here to store additional user data if needed
        // For example, you can use Firestore to store user details.

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Sign Up'),
              content: Text(
                  'Success! User registered with email: ${userCredential.user?.email}'),
            );
          },
        );

        // Clear the text fields// nameController.clear();
        //  dateController.clear();
        //  genderController.clear();
        //  roleController.clear();
        //  usernameController.clear();
        //  passwordController.clear();
        // emailController.clear();
        //  contactController.clear();
        // addressController.clear();
        // ... other controllers ...
      } on FirebaseAuthException catch (e) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Sign Up'),
              content: Text('Error: ${e.message}'),
            );
          },
        );
      }
    }
  }

  Future<void> CreateHotel(String? owner, User? user) async {
    if (user != null) {
      Map<String, dynamic> AccommodationData = {
        "type": _selectedAccomodation,
        "name": "",
        "location": "",
        "status": "",
        "images": "",
        "owner": owner
      };

      DatabaseReference reference = FirebaseDatabase.instance.reference();

      // Add the room data to Realtime Database
      await reference.child('Accommodations').push().set(AccommodationData);
    }
  }

  Future<void> _saveUserDataToFirestore(User? user) async {
    if (user != null) {
      try {
        // Create a map to represent the user data in JSON format
        Map<String, dynamic> userData = {
          "name": nameController.text,
          "dateOfBirth": dateController.text,
          "gender": _selectedGender,
          "role": "Manager", // You can customize the role as needed
          "username": usernameController.text,
          "password": passwordController.text,
          "email": emailController.text,
          "contact": contactController.text,
          "address": addressController.text,
          "selectAccomudation": _selectedAccomodation
          // Add more fields as needed
        };

        // Reference to the 'users' node in the Realtime Database
        DatabaseReference userRef = FirebaseDatabase.instance
            .reference()
            .child('users')
            .child(user.uid);

        // Set the user data in the Realtime Database
        await userRef.set(userData);
        CreateHotel(emailController.text, user);
        print('User data stored successfully in Realtime Database');
      } catch (e) {
        print('Error storing Manager data: $e');
      }
    } else {
      print('Error: Manager is null');
    }
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);

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
      body: SingleChildScrollView(
        child: Container(
            width: double.maxFinite,
            child: Padding(
                padding: EdgeInsets.fromLTRB(mainPadding, 50, mainPadding, 0),
                child: Column(
                  children: <Widget>[
                    const Text(
                      "StayBooked",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 192, 116, 2)),
                    ),
                    Form(
                      key: _formKey,
                      child: Container(
                          width: double.infinity,
                          // decoration: BoxDecoration(border: Border.all()),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                            child: Column(
                              children: <Widget>[
                                const Text(
                                  "Create New Account",
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
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
                                      hintText: "Enter your Full Name",
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
                                    10,
                                  ),
                                  child: TextField(
                                    controller: usernameController,
                                    decoration: InputDecoration(
                                      hintText: "Enter your Username",
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
                                        child: Icon(Icons.account_circle,
                                            size: iconSize),
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
                                    controller: emailController,
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
                                          Icons.email,
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
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                    0,
                                    0,
                                    0,
                                    10,
                                  ),
                                  child: TextField(
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      hintText: "Confirm your Password",
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
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                    0,
                                    0,
                                    0,
                                    10,
                                  ),
                                  child: DropdownButtonFormField<String>(
                                    value: _selectedGender,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                            30), // Adjust the radius value as needed
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: verticalHeight),
                                      hintText: "Select your Gender",
                                      prefixIcon: Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            iconPaddingLeft,
                                            0,
                                            iconPaddingRight,
                                            0),
                                        child: Icon(
                                          Icons.male,
                                          size: iconSize,
                                        ),
                                      ),
                                    ),
                                    items: genderOptions.map((String gender) {
                                      return DropdownMenuItem<String>(
                                        value: gender,
                                        child: Text(gender),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        _selectedGender = newValue;
                                      });
                                    },
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
                                  child: TextFormField(
                                    controller: dateController,
                                    readOnly: true,
                                    decoration: InputDecoration(
                                      hintText: "Select your Date of Birth",
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
                                          Icons.date_range,
                                          size: iconSize,
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      _selectDate(context);
                                    },
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
                                    controller: contactController,
                                    decoration: InputDecoration(
                                      hintText: "Enter your Contact",
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
                                          Icons.phone,
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
                                    controller: addressController,
                                    decoration: InputDecoration(
                                      hintText: "Enter your Address",
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
                                          Icons.location_on,
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
                                  child: DropdownButtonFormField<String>(
                                    value: _selectedAccomodation,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                            30), // Adjust the radius value as needed
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: verticalHeight),
                                      hintText: "What you want to Register",
                                      prefixIcon: Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            iconPaddingLeft,
                                            0,
                                            iconPaddingRight,
                                            0),
                                        child: Icon(
                                          Icons.male,
                                          size: iconSize,
                                        ),
                                      ),
                                    ),
                                    items:
                                        accomodationOptions.map((String acc) {
                                      return DropdownMenuItem<String>(
                                        value: acc,
                                        child: Text(acc),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        _selectedAccomodation = newValue;
                                      });
                                    },
                                    style: TextStyle(fontSize: fontSize),
                                  ),
                                ),

                                // Expanded(
                                Container(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                      onPressed: () async {
                                        const AlertDialog(
                                            title: Text('Sing up '),
                                            content: Text('Sucess'));
                                        signUp();
                                      },
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.orange)),
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            0, buttonPadding, 0, buttonPadding),
                                        child: Text(
                                          "Create Account",
                                          style: TextStyle(
                                              fontSize: buttonFont,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w900),
                                        ),
                                      )),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      lastlinepaddingleft, 20, 0, 300),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "Already have an Account ",
                                        style: TextStyle(
                                            fontSize: lastlinefontsize),
                                      ),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pushNamed(
                                                context, "/Login");
                                          },
                                          child: Text(
                                            "Log In Here",
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
                          )),
                    )
                  ],
                ))),
      ),
    );
  }
}
