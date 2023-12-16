import 'package:bookingapplication2/constant.dart';
import 'package:bookingapplication2/util/my_title.dart';
import 'package:bookingapplication2/Screens/Add_Room_Admin.dart';
import 'package:bookingapplication2/util/addRoom.dart';
import 'package:bookingapplication2/util/chart.dart';
import 'package:bookingapplication2/util/showTotalRooms.dart';
import 'package:bookingapplication2/util/viewRoom.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';
import '../util/my_box.dart';

class DesktopScaffold extends StatefulWidget {
  const DesktopScaffold({Key? key}) : super(key: key);

  @override
  State<DesktopScaffold> createState() => _DesktopScaffoldState();
}

class _DesktopScaffoldState extends State<DesktopScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: defaultBackgroundColor,
      appBar: myAppBar,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // open drawer
            MyDrawer(),

            // first half of page
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  // first 4 boxes in grid
                  AspectRatio(
                    aspectRatio: 4,
                    child: SizedBox(
                      width: double.infinity,
                      child: GridView.builder(
                        itemCount: 4,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4),
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return addRoom();
                          } else if (index == 1) {
                            return viewRoom();
                          } else if (index == 2) {
                            return const ShowTotalRooms();
                          } else {
                            return MyBox();
                          }
                        },
                      ),
                    ),
                  ),

                  // list of previous days
                  Expanded(child: pieChartDisplay()),
                ],
              ),
            ),
            // second half of page
            // Expanded(
            //   child: Column(
            //     children: [
            //       Padding(
            //         padding: const EdgeInsets.all(8.0),
            //         child: Container(
            //           height: 400,
            //           decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(8),
            //             color: Colors.grey[400],
            //           ),
            //         ),
            //       ),
            //       // list of stuff
            //       Expanded(
            //         child: Padding(
            //           padding: const EdgeInsets.all(8.0),
            //           child: Container(
            //             decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular(8),
            //               color: Colors.grey[200],
            //             ),
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
