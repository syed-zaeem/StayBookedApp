import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditHotelHome extends StatefulWidget {
  const EditHotelHome({super.key});

  @override
  State<EditHotelHome> createState() => _EditHotelHomeState();
}

class _EditHotelHomeState extends State<EditHotelHome> {
  Map<String, dynamic>? _selectAccommodation;
  String? _selectedStatus;
  String _loginedUser = "";

  List<String> statusOptions = [
    'Available',
    'Not Available',
  ];

  TextEditingController accommodationLocationController =
      TextEditingController();
  TextEditingController accommodationNameController = TextEditingController();
  TextEditingController accommodationImageAdd = TextEditingController();

  List<String> images = [
    // 'https://images.unsplash.com/photo-1625244724120-1fd1d34d00f6?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aG90ZWxzfGVufDB8fDB8fHww',
    // 'https://images.unsplash.com/photo-1571896349842-33c89424de2d?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8N3x8aG90ZWxzfGVufDB8fDB8fHww',
    // 'https://images.unsplash.com/photo-1551882547-ff40c63fe5fa?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8aG90ZWxzfGVufDB8fDB8fHww',
    // Add more image URLs as needed
  ];
  Future<String?> getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userEmail');
  }

  void _editAccommodation() async {
    print("EDIT function called");
    await updateItem(_loginedUser);
  }

  Future<String?> getUserId(String email) async {
    final hotelReference =
        FirebaseDatabase.instance.reference().child('Accommodations');
    final snapshot = await hotelReference.get();

    for (var childSnapshot in snapshot.children) {
      final HotelsData = childSnapshot.value as Map<String, dynamic>;

      // Access the email value within the child's data

      //Check if child email matches the provided email
      if (HotelsData["owner"] == email) {
        final id = childSnapshot.key;
        print('User with email: $email has id: $id');

        // final prefs = await SharedPreferences.getInstance();
        // await prefs.setString('accommodationId', id ?? '');

        return id;
      }
    }

    print('User with email: $email not found or has no role assigned.');
    return null;
  }

  Future<void> updateItem(email) async {
    print("I am here");
    final id = await getUserId(email);
    final databaseReference =
        FirebaseDatabase.instance.reference().child('Accommodations/$id');
    final castedData = _selectAccommodation as Map<String, Object?>;
    await databaseReference.update(castedData);
  }

  @override
  void initState() {
    super.initState();
    getUserEmail().then((email) {
      if (email != null) {
        setState(() {
          _loginedUser = email;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);

    double screenWidth = mediaQuery.size.width;
    double screenHeight = mediaQuery.size.height;

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
      appBar: AppBar(
        title: const Text(
          "Edit Accomodation",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        children: [
          Container(
              width: double.maxFinite,
              child: Padding(
                  padding: EdgeInsets.fromLTRB(mainPadding, 10, mainPadding, 0),
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
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                    0,
                                    20,
                                    0,
                                    10,
                                  ),
                                  child: TextField(
                                    controller: accommodationNameController,
                                    decoration: InputDecoration(
                                      hintText: "Enter the Name",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
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
                                    controller: accommodationLocationController,
                                    decoration: InputDecoration(
                                      hintText: "Enter the Location",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
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
                                    10,
                                  ),
                                  child: DropdownButtonFormField<String>(
                                    value: _selectedStatus,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                            30), // Adjust the radius value as needed
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: verticalHeight),
                                      hintText: "Select the Status",
                                      prefixIcon: Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            iconPaddingLeft,
                                            0,
                                            iconPaddingRight,
                                            0),
                                        child: Icon(
                                          Icons.check,
                                          size: iconSize,
                                        ),
                                      ),
                                    ),
                                    items: statusOptions.map((String roomtype) {
                                      return DropdownMenuItem<String>(
                                        value: roomtype,
                                        child: Text(roomtype),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        _selectedStatus = newValue;
                                      });
                                    },
                                    style: TextStyle(fontSize: fontSize),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 20),
                                  child: Container(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: const Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            0, 30, 0, 0),
                                                    child: Center(
                                                        child: Text(
                                                      'Upload Image',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 28),
                                                    )),
                                                  ),
                                                  content:
                                                      SingleChildScrollView(
                                                    child: Column(
                                                      children: <Widget>[
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .fromLTRB(
                                                            0,
                                                            10,
                                                            0,
                                                            10,
                                                          ),
                                                          child: TextField(
                                                            controller:
                                                                accommodationImageAdd,
                                                            decoration:
                                                                InputDecoration(
                                                              hintText:
                                                                  "Enter the Imge Link",
                                                              contentPadding:
                                                                  EdgeInsets.symmetric(
                                                                      vertical:
                                                                          verticalHeight),
                                                            ),
                                                            style: TextStyle(
                                                                fontSize:
                                                                    fontSize),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  actions: <Widget>[
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(
                                                        0,
                                                        0,
                                                        50,
                                                        100,
                                                      ),
                                                      child: ElevatedButton(
                                                        onPressed: () {
                                                          // Code to execute when the "Cancel" button is pressed
                                                          Navigator.of(context)
                                                              .pop(); // Close the dialog
                                                        },
                                                        child: const Text(
                                                            'Cancel'),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(
                                                          0, 0, 18, 100),
                                                      child: ElevatedButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            // Add the new image link to the array
                                                            images.add(
                                                                accommodationImageAdd
                                                                    .text);
                                                            // Clear the text field after adding the image
                                                            accommodationImageAdd
                                                                .clear();
                                                          });
                                                          Navigator.of(context)
                                                              .pop(); // Close the dialog
                                                        },
                                                        child: const Text(
                                                            'Upload Image'),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              });
                                        },
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.orange)),
                                        child: Padding(
                                          padding: EdgeInsets.fromLTRB(0,
                                              buttonPadding, 0, buttonPadding),
                                          child: Text(
                                            "Upload Image",
                                            style: TextStyle(
                                                fontSize: buttonFont,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w900),
                                          ),
                                        )),
                                  ),
                                ),

                                Column(
                                  children: images.map((img) {
                                    return Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 0, 20, 0),
                                      child: Column(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 20),
                                            child: Container(
                                                child: Column(
                                              children: [
                                                ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    child: Image.network(
                                                      img,
                                                      // height: 150,
                                                      // width: ,
                                                    )),
                                                TextButton(
                                                    onPressed: () {
                                                      // print(img);
                                                      setState(() {
                                                        images.remove(img);
                                                      });
                                                    },
                                                    child: const Icon(
                                                      Icons.delete,
                                                      size: 30,
                                                    ))
                                              ],
                                            )),
                                          )
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                ),

                                // Expanded(
                                Container(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                      onPressed: () async {
                                        _selectAccommodation = {
                                          'name':
                                              accommodationNameController.text,
                                          'location':
                                              accommodationLocationController
                                                  .text,
                                          'images': images,
                                          'owner': _loginedUser,
                                          'status': _selectedStatus
                                        };
                                        _editAccommodation();
                                      },
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.orange)),
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            0, buttonPadding, 0, buttonPadding),
                                        child: Text(
                                          "Edit Accomodation",
                                          style: TextStyle(
                                              fontSize: buttonFont,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w900),
                                        ),
                                      )),
                                ),
                              ],
                            ),
                          ))
                    ],
                  ))),
        ],
      ),
    );
  }
}
