import 'package:flutter/material.dart';
// import 'package:bookingapplication2/Screens/Room_List.dart';

class viewRoom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);

    double screenWidth = mediaQuery.size.width;
    double screenHeight = mediaQuery.size.height;

    double fontSizeViewRooms = screenWidth < 400
        ? 15.0 // Font size for screen width less than 400
        : screenWidth < 600
            ? 16.0 // Font size for screen width less than 600
            : 25.0; // Default

    return Padding(
      padding: const EdgeInsets.all(16.0), // Adjust the padding as needed
      child: Stack(
        children: <Widget>[
          // Background Image
          Image.network(
            'https://images.unsplash.com/photo-1455587734955-081b22074882?auto=format&fit=crop&q=80&w=1740&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', // Replace with the path to your background image
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          // Text on top of the background
          Padding(
            padding: const EdgeInsets.all(8),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, "/RoomsListManager");
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey[400]
                      ?.withOpacity(0.7), // Adjust opacity as needed
                ),
                child: Center(
                  child: Text(
                    "View Rooms",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: fontSizeViewRooms,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                // child: const Padding(
                //   padding: EdgeInsets.fromLTRB(41, 30, 41, 30),
                //   child: Text(
                //     "View Rooms",
                //     style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                //   ),
                // ),
                // child: Center(
                //   child: ElevatedButton(
                //     onPressed: () {
                //       // Perform your action when the button is pressed
                //       // For example, you can navigate to the next page
                //       Navigator.push(
                //         context,
                //         MaterialPageRoute(builder: (context) => RoomList()),
                //       );
                //     },
                //     child: Text('View Rooms'),
                //   ),
                // ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
