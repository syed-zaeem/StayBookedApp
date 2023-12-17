import 'package:bookingapplication2/Screens/About_Us_Page.dart';
import 'package:bookingapplication2/Screens/Add_Room_Admin.dart';
import 'package:bookingapplication2/Screens/Cart_Page.dart';
import 'package:bookingapplication2/Screens/Contact_Us_Page.dart';
import 'package:bookingapplication2/Screens/Detailed_Home_Page.dart';
import 'package:bookingapplication2/Screens/Detailed_Hotel_Page.dart';
import 'package:bookingapplication2/Screens/Home_Page.dart';
import 'package:bookingapplication2/Screens/Home_Page_Customer.dart';
import 'package:bookingapplication2/Screens/LogIn.dart';
import 'package:bookingapplication2/Screens/More_Page.dart';
import 'package:bookingapplication2/Screens/My_Reviews_Page.dart';
import 'package:bookingapplication2/Screens/Price_Display_Page.dart';
import 'package:bookingapplication2/Screens/Room_List.dart';
import 'package:bookingapplication2/Screens/SignUp.dart';
import 'package:bookingapplication2/Screens/SignUp_Manager.dart';
import 'package:bookingapplication2/Screens/Trips_Page_Customer.dart';
import 'package:bookingapplication2/Screens/View_Feedbacks_Manager.dart';
import 'package:bookingapplication2/Screens/View_Hotels_Page.dart';
import 'package:bookingapplication2/Screens/View_Rooms_Customer.dart';
import 'package:bookingapplication2/Screens/View_Homes_Page.dart';
import 'package:bookingapplication2/Screens/View_Rooms_Home.dart';
import 'package:bookingapplication2/util/EditHotelOrHome.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:bookingapplication2/responsive/desktop_body.dart';
import 'package:bookingapplication2/responsive/table_body.dart';
import 'responsive/mobile_body.dart';
import 'responsive/responsive_layout.dart';
import 'package:firebase_database/firebase_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyD6NT1ua0fv8rvsryjWi2Kyn3_roeOJznk",
      appId: "1:996235874041:android:b2d3157ec76ef486985c28",
      messagingSenderId: "996235874041",
      projectId: "staybooked-7ef6a",
      databaseURL: "https://staybooked-7ef6a-default-rtdb.firebaseio.com/",
      storageBucket: "gs://staybooked-7ef6a.appspot.com",
    ),
  );
  await FirebaseStorage.instance;
  print("FIREBASE INITIALIZATION SUCCESSFULL");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
          useMaterial3: true,
        ),
        // home: const AddRoomAdmin(),
         home: LogIn(),
        // home: RoomList(),
        // home: ResponsiveLayout(
        //   mobileBody: const MobileScaffold(),
        //   tabletBody: const TabletScaffold(),
        //   desktopBody: const DesktopScaffold(),
        // ),
        // home: EditHotelHome(),
        // home: ViewHotelsPage(),
        // home: DetailedHotelPage(),
        // home: HomePageCustomer(),
        // initialRoute: '/',
        // home: ViewRooms(),
        // home: ViewFeedbacksManager(),
        routes: {
          "/CustomerHomePage": (context) => const HomePageCustomer(),
          "/Signup": (context) => const SignUp(),
          "/SignupManager": (context) => const SignUpManager(),
          "/Login": (context) => const LogIn(),
          "/RoomsListManager": (context) => RoomList(),
          "/AddRoomManager": (context) => const AddRoomAdmin(),
          "/EditHotelOrHomeManager": (context) => const EditHotelHome(),
          "/MyTrips": (context) => const MyTripPage(),
          "/Cart": (context) => const CartPage(),
          "/More": (context) => const MorePage(),
          "/HelpCenter": (context) => const ContactUsPage(),
          "/AboutUs": (context) => const AboutUsPgae(),
          "/MyReviews": (context) => const MyReviewsPage(),
          "/PriceDisplay": (context) => const PriceDisplayPage(),
          "/ViewHotels": (context) => const ViewHotelsPage(),
          "/ViewHomes": (context) => const ViewHomesPage(),
          "/ViewHotelRooms": (context) => ViewRooms(),
          "/ViewHomeRooms": (context) => ViewRoomsHome(),
          "/ViewFeedbacksManager": (context) => ViewFeedbacksManager(),
          "/DetailedOneHotel": (context) => const DetailedHotelPage(),
          "/DetailedOneHome": (context) => const DetailedHomePage(),
        });
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
