import 'package:bookingapplication2/constant.dart';
import 'package:bookingapplication2/util/chart.dart';
import 'package:bookingapplication2/util/my_title.dart';
import 'package:bookingapplication2/util/showTotalRooms.dart';
import 'package:bookingapplication2/util/viewRoom.dart';
import 'package:flutter/material.dart';
import '../util/my_box.dart';
import 'package:bookingapplication2/util/addRoom.dart';

class TabletScaffold extends StatefulWidget {
  const TabletScaffold({Key? key}) : super(key: key);

  @override
  State<TabletScaffold> createState() => _TabletScaffoldState();
}

class _TabletScaffoldState extends State<TabletScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: defaultBackgroundColor,
      appBar: myAppBar,
      drawer: MyDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // first 4 boxes in grid
            AspectRatio(
              aspectRatio: 4,
              child: SizedBox(
                width: double.infinity,
                child: GridView.builder(
                  itemCount: 4,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
    );
  }
}
