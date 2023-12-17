import 'package:flutter/material.dart';
import 'package:bookingapplication2/Util/numberInput.dart';
import 'package:responsive_table/responsive_table.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:math';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

class Room {
  final String roomNumber;
  final String roomType;
  final String capacity;
  final String price;
  final String status;
  final String numberOfBeds;
  final String id;

  Room({
    required this.roomNumber,
    required this.roomType,
    required this.capacity,
    required this.price,
    required this.status,
    required this.numberOfBeds,
    required this.id,
  });
}

class RoomList extends StatefulWidget {
  late DatabaseReference _roomRef;
  List<Map<dynamic, dynamic>> _rooms = [];
  // final String apiUrl = 'http://localhost:8000/rooms';

  List<Item> items = [];

  @override
  _RoomListState createState() => _RoomListState();
}

class _RoomListState extends State<RoomList> {
 final databaseReference = FirebaseDatabase.instance.reference().child('rooms');
  List<Room> rooms = [];
  String? _SelectedItem;
  Map<String, dynamic>? _SelectRoom;
  final TextEditingController roomNumberController = TextEditingController();

  final TextEditingController capacityController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  late List<DatatableHeader> _headers;

  List<int> _perPages = [10, 20, 50, 100];
  int _total = 100;
  int? _currentPerPage = 10;
  List<bool>? _expanded;
  String? _searchKey = "id";

  int _currentPage = 1;
  bool _isSearch = false;
  List<Map<String, dynamic>> _sourceOriginal = [];
  List<Map<String, dynamic>> _sourceFiltered = [];
  List<Map<String, dynamic>> _source = [];
  List<Map<String, dynamic>> _selecteds = [];
  // ignore: unused_field
  String _selectableKey = "id";

  String? _sortColumn;
  bool _sortAscending = true;
  bool _isLoading = true;
  bool _showSelect = true;
  var random = new Random();
    List<Item> temps = [];

  Future<void> fetchData() async {
    print("FETCHDATA CALLED");
   final databaseReference = FirebaseDatabase.instance.reference();
  final snapshot = await databaseReference.child('rooms').get();
  if (snapshot.exists) {
    Map<String, dynamic> roomMap = snapshot.value as Map<String, dynamic>;
    for (var entry in roomMap.entries) {
      final roomData = entry.value as Map<String, dynamic>;
      print(roomData);
      // Create a new Room object with data from the map
      final room = Item(
        roomNumber: roomData['roomNumber'],
        capacity: roomData['capacity'],
        numberOfBeds: roomData['numberOfBeds'],
        price: roomData['price'],
        roomType: roomData['roomType'],
        status: roomData['status'],
        id: entry.key
        
      );
      // Add the room to the list
      widget.items.add(room);
    }
  
    // Process all rooms data
    print('All rooms data: $temps');
  } else {
    print('No rooms found in the database.');
  }

    // final response = await http.get(Uri.parse(widget.apiUrl));
    // print(response.statusCode);
    // print("FETCHED");
    // print(response.body);
    // if (response.statusCode == 200) {
    //   final List<dynamic> responseData = json.decode(response.body);
    //   setState(() {
    //     widget.items = responseData.map((item) => Item.fromJson(item)).toList();
    //   });
    // }
  }

  
 
 
  
  

  List<Map<String, dynamic>> _generateData() {
    List<Map<String, dynamic>> temps = [];
    // print("INITIAL");

    for (Item item in widget.items) {
      print(item.status);
      temps.add({
        "roomNumber": item.roomNumber,
        "roomType": item.roomType,
        "capacity": item.capacity,
        "price": item.price,
        "status": item.status,
        "numberOfBeds": item.numberOfBeds,
        "id": item.id,
      });
    }
    Future<void> deleteItem(String id) async {
      // final String delUrl = 'http://localhost:8000/room';
      // final response = await http.delete(Uri.parse('$delUrl/$id'));

      // if (response.statusCode == 200) {
      //   fetchData();
      // }
    }
    print(temps);
    print("END");

    return temps;
  }

  _initializeData() async {
    _mockPullData();
  }

  _mockPullData() async {
    _expanded = List.generate(_currentPerPage!, (index) => false);

    setState(() => _isLoading = true);
    Future.delayed(Duration(seconds: 3)).then((value) {
      _sourceOriginal.clear();
      _sourceOriginal.addAll(_generateData());
      _sourceFiltered = _sourceOriginal;
      _total = _sourceFiltered.length;
      _source = _sourceFiltered
          .getRange(
              0,
              _currentPerPage! < _sourceFiltered.length
                  ? _currentPerPage!
                  : _sourceFiltered.length)
          .toList();
      setState(() => _isLoading = false);
    });
  }

  _resetData({start = 0}) async {
    setState(() => _isLoading = true);
    var _expandedLen =
        _total - start < _currentPerPage! ? _total - start : _currentPerPage;
    Future.delayed(Duration(seconds: 0)).then((value) {
      _expanded = List.generate(_expandedLen as int, (index) => false);
      _source.clear();
      _source = _sourceFiltered.getRange(start, start + _expandedLen).toList();
      setState(() => _isLoading = false);
    });
  }

  _filterData(value) {
    setState(() => _isLoading = true);

    try {
      if (value == "" || value == null) {
        _sourceFiltered = _sourceOriginal;
      } else {
        _sourceFiltered = _sourceOriginal
            .where((data) => data[_searchKey!]
                .toString()
                .toLowerCase()
                .contains(value.toString().toLowerCase()))
            .toList();
      }

      _total = _sourceFiltered.length;
      var _rangeTop = _total < _currentPerPage! ? _total : _currentPerPage!;
      _expanded = List.generate(_rangeTop, (index) => false);
      _source = _sourceFiltered.getRange(0, _rangeTop).toList();
    } catch (e) {
      print(e);
    }
    setState(() => _isLoading = false);
  }

  void _editRoom() async {
    print("EDIT function called");
    await updateItem(_SelectedItem);
    print(_SelectedItem);
    print("SECLECT ROOM");
    print(_SelectRoom);
  }

  Future<void> updateItem(editItemId) async {
    final databaseReference = FirebaseDatabase.instance.reference().child('rooms/$editItemId');
    _SelectRoom?.remove("id");
    final castedData = _SelectRoom as Map<String, Object?>;
     await databaseReference.update(castedData);
     fetchData();
  }

  @override
  void initState() {
    super.initState();
    fetchData();
    
    /// set headers
    _headers = [
      DatatableHeader(
          text: "Room Number",
          value: "roomNumber",
          show: true,
          sortable: true,
          textAlign: TextAlign.center),
      DatatableHeader(
          text: "Room Type",
          value: "roomType",
          show: true,
          flex: 2,
          sortable: true,
          editable: true,
          textAlign: TextAlign.left),
      DatatableHeader(
          text: "Capacity",
          value: "capacity",
          show: true,
          sortable: true,
          textAlign: TextAlign.center),
      DatatableHeader(
          text: "Price",
          value: "price",
          show: true,
          sortable: true,
          textAlign: TextAlign.left),
      DatatableHeader(
          text: "Occupancy Status",
          value: "status",
          show: true,
          sortable: true,
          textAlign: TextAlign.left),
      DatatableHeader(
          text: "Number of Beds",
          value: "numberOfBeds",
          show: true,
          sortable: true,
          textAlign: TextAlign.left),
    ];

    _initializeData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _deleteRoom(id) async {
    try {
    final databaseReference = FirebaseDatabase.instance.reference().child('rooms/$id');
    await databaseReference.remove();
    print('Room with ID: $id deleted successfully!');
  } catch (error) {
    print('Error deleting room: $error');
  }
  }

  void _addRoom() {
    // Implement the logic to add a new room here.
    // You can open a form or dialog for adding a new room.
  }

  @override
  Widget build(BuildContext context) {
    String? _selectedRoomtype;
    String? _selectedOccupancyStatus;

    List<String> roomtypeOptions = [
      'Single',
      'Double',
      'Suite',
      'Deluxe',
      'Family'
    ];

    List<String> occupancystatusOptions = [
      'Vacant',
      'Occupied',
      'Reserved',
      'Cleaning in Progress'
    ];

    TextEditingValue formatEditUpdate(
        TextEditingValue oldValue, TextEditingValue newValue) {
      // Use a regular expression to allow only numeric input
      final RegExp regExp = RegExp(r'[0-9]');
      String newString = '';

      for (int i = 0; i < newValue.text.length; i++) {
        if (regExp.hasMatch(newValue.text[i])) {
          newString += newValue.text[i];
        }
      }

      return TextEditingValue(
        text: newString,
        selection:
            TextSelection.fromPosition(TextPosition(offset: newString.length)),
      );
    }

    MediaQueryData mediaQuery = MediaQuery.of(context);

    double screenWidth = mediaQuery.size.width;
    double screenHeight = mediaQuery.size.height;

    double fontSize = screenWidth < 400
        ? 15.0 // Font size for screen width less than 400
        : screenWidth < 600
            ? 16.0 // Font size for screen width less than 600
            : 18.0; // Default
    double verticalHeight = screenHeight < 400 ? 8 : 12;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "List of Rooms",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      // drawer: Drawer(
      //   child: ListView(
      //     children: [
      //       ListTile(
      //         leading: Icon(Icons.home),
      //         title: Text("home"),
      //         onTap: () {
      //           print("DONE");
      //         },
      //       ),
      //       ListTile(
      //         leading: Icon(Icons.storage),
      //         title: Text("data"),
      //         onTap: () {},
      //       )
      //     ],
      //   ),
      // ),
      body: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(0),
              constraints: BoxConstraints(
                maxHeight: 700,
              ),
              child: Card(
                elevation: 1,
                shadowColor: Colors.black,
                clipBehavior: Clip.none,
                child: ResponsiveDatatable(
                  title: Wrap(
                      direction: Axis.vertical,
                      alignment: WrapAlignment.spaceBetween,
                      children: [
                        TextButton.icon(
                          onPressed: () => {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Padding(
                                      padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                                      child: Center(
                                          child: Text(
                                        'Edit the Room',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 28),
                                      )),
                                    ),
                                    content: SingleChildScrollView(
                                      child: Column(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                              0,
                                              10,
                                              0,
                                              10,
                                            ),
                                            child: TextField(
                                              controller: roomNumberController,
                                              decoration: InputDecoration(
                                                hintText:
                                                    "Enter the Room Number",
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        vertical:
                                                            verticalHeight),
                                              ),
                                              style:
                                                  TextStyle(fontSize: fontSize),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                              0,
                                              0,
                                              0,
                                              10,
                                            ),
                                            child:
                                                DropdownButtonFormField<String>(
                                              value: _selectedRoomtype,
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        vertical:
                                                            verticalHeight),
                                                hintText:
                                                    "Select the Room Type",
                                              ),
                                              items: roomtypeOptions
                                                  .map((String roomtype) {
                                                return DropdownMenuItem<String>(
                                                  value: roomtype,
                                                  child: Text(roomtype),
                                                );
                                              }).toList(),
                                              onChanged: (String? newValue) {
                                                setState(() {
                                                  _selectedRoomtype = newValue;
                                                });
                                              },
                                              style:
                                                  TextStyle(fontSize: fontSize),
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
                                              controller: capacityController,
                                              inputFormatters: [
                                                NumericInputFormatter()
                                              ],
                                              decoration: InputDecoration(
                                                hintText:
                                                    "Enter the Capacity of people",
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        vertical:
                                                            verticalHeight),
                                              ),
                                              style:
                                                  TextStyle(fontSize: fontSize),
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
                                              controller: priceController,
                                              inputFormatters: [
                                                NumericInputFormatter()
                                              ],
                                              decoration: InputDecoration(
                                                hintText:
                                                    "Enter the Price per night",
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        vertical:
                                                            verticalHeight),
                                              ),
                                              style:
                                                  TextStyle(fontSize: fontSize),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                              0,
                                              0,
                                              0,
                                              10,
                                            ),
                                            child:
                                                DropdownButtonFormField<String>(
                                              value: _selectedOccupancyStatus,
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        vertical:
                                                            verticalHeight),
                                                hintText:
                                                    "Select the Occupancy Status",
                                              ),
                                              items: occupancystatusOptions.map(
                                                  (String occupancystatus) {
                                                return DropdownMenuItem<String>(
                                                  value: occupancystatus,
                                                  child: Text(occupancystatus),
                                                );
                                              }).toList(),
                                              onChanged: (String? newValue) {
                                                setState(() {
                                                  _selectedOccupancyStatus =
                                                      newValue;
                                                });
                                              },
                                              style:
                                                  TextStyle(fontSize: fontSize),
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
                                              // keyboardType: TextInputType.number,
                                              inputFormatters: [
                                                NumericInputFormatter()
                                              ],
                                              decoration: InputDecoration(
                                                hintText:
                                                    "Enter the Number of Beds",
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        vertical:
                                                            verticalHeight),
                                              ),
                                              style:
                                                  TextStyle(fontSize: fontSize),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    actions: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
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
                                          child: const Text('Cancel'),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 18, 100),
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            _SelectRoom = {
                                              'roomNumber':
                                                  roomNumberController.text,
                                              'roomType': _selectedRoomtype,
                                              'capacity':
                                                  capacityController.text,
                                              'price': priceController.text,
                                              'status':
                                                  _selectedOccupancyStatus,
                                              "id": _SelectedItem
                                            };
                                            _editRoom();
                                            Navigator.of(context)
                                                .pop(); // Close the dialog
                                          },
                                          child: const Text('Edit Room'),
                                        ),
                                      ),
                                    ],
                                  );
                                })
                          },
                          icon: Icon(Icons.edit),
                          label: Text("Edit item"),
                        ),
                        TextButton.icon(
                          onPressed: () => {
                            print("YEs"),
                            print(_SelectedItem),
                            _deleteRoom(_SelectedItem),
                          },
                          icon: Icon(Icons.delete),
                          label: Text("delete item"),
                        ),
                      ]),
                  reponseScreenSizes: [ScreenSize.xs],
                  actions: [
                    if (_isSearch)
                      Expanded(
                          child: TextField(
                        decoration: InputDecoration(
                            hintText: 'Enter search term based on ' +
                                _searchKey!
                                    .replaceAll(new RegExp('[\\W_]+'), ' ')
                                    .toUpperCase(),
                            prefixIcon: IconButton(
                                icon: Icon(Icons.cancel),
                                onPressed: () {
                                  setState(() {
                                    _isSearch = false;
                                  });
                                  _initializeData();
                                }),
                            suffixIcon: IconButton(
                                icon: Icon(Icons.search), onPressed: () {})),
                        onSubmitted: (value) {
                          _filterData(value);
                        },
                      )),
                    if (!_isSearch)
                      IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () {
                            setState(() {
                              _isSearch = true;
                            });
                          })
                  ],
                  headers: _headers,
                  source: _source,
                  selecteds: _selecteds,
                  showSelect: _showSelect,
                  autoHeight: false,
                  dropContainer: (data) {
                    if (int.tryParse(data['id'].toString())!.isEven) {
                      return Text("is Even");
                    }
                    return _DropDownContainer(data: data);
                  },
                  onChangedRow: (value, header) {
                    /// print(value);
                    /// print(header);
                  },
                  onSubmittedRow: (value, header) {
                    /// print(value);
                    /// print(header);
                  },
                  onTabRow: (data) {
                    print(data);
                  },
                  onSort: (value) {
                    setState(() => _isLoading = true);

                    setState(() {
                      _sortColumn = value;
                      _sortAscending = !_sortAscending;
                      if (_sortAscending) {
                        _sourceFiltered.sort((a, b) =>
                            b["$_sortColumn"].compareTo(a["$_sortColumn"]));
                      } else {
                        _sourceFiltered.sort((a, b) =>
                            a["$_sortColumn"].compareTo(b["$_sortColumn"]));
                      }
                      var _rangeTop = _currentPerPage! < _sourceFiltered.length
                          ? _currentPerPage!
                          : _sourceFiltered.length;
                      _source = _sourceFiltered.getRange(0, _rangeTop).toList();
                      _searchKey = value;

                      _isLoading = false;
                    });
                  },
                  expanded: _expanded,
                  sortAscending: _sortAscending,
                  sortColumn: _sortColumn,
                  isLoading: _isLoading,
                  onSelect: (value, item) {
                    print(item);
                    _SelectedItem = item['id'];
                    print("SKI");
                    print(_SelectedItem);
                    if (value!) {
                      setState(() => _selecteds.add(item));
                    } else {
                      setState(
                          () => _selecteds.removeAt(_selecteds.indexOf(item)));
                    }
                  },
                  onSelectAll: (value) {
                    if (value!) {
                      setState(() => _selecteds =
                          _source.map((entry) => entry).toList().cast());
                    } else {
                      setState(() => _selecteds.clear());
                    }
                  },
                  footers: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Text("Rows per page:"),
                    ),
                    if (_perPages.isNotEmpty)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: DropdownButton<int>(
                          value: _currentPerPage,
                          items: _perPages
                              .map((e) => DropdownMenuItem<int>(
                                    child: Text("$e"),
                                    value: e,
                                  ))
                              .toList(),
                          onChanged: (dynamic value) {
                            setState(() {
                              _currentPerPage = value;
                              _currentPage = 1;
                              _resetData();
                            });
                          },
                          isExpanded: false,
                        ),
                      ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child:
                          Text("$_currentPage - $_currentPerPage of $_total"),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        size: 16,
                      ),
                      onPressed: _currentPage == 1
                          ? null
                          : () {
                              var _nextSet = _currentPage - _currentPerPage!;
                              setState(() {
                                _currentPage = _nextSet > 1 ? _nextSet : 1;
                                _resetData(start: _currentPage - 1);
                              });
                            },
                      padding: EdgeInsets.symmetric(horizontal: 15),
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_forward_ios, size: 16),
                      onPressed: _currentPage + _currentPerPage! - 1 > _total
                          ? null
                          : () {
                              var _nextSet = _currentPage + _currentPerPage!;

                              setState(() {
                                _currentPage = _nextSet < _total
                                    ? _nextSet
                                    : _total - _currentPerPage!;
                                _resetData(start: _nextSet - 1);
                              });
                            },
                      padding: EdgeInsets.symmetric(horizontal: 15),
                    )
                  ],
                ),
              ),
            ),
          ])),
      floatingActionButton: FloatingActionButton(
        onPressed: _initializeData,
        child: Icon(Icons.refresh_sharp),
      ),
    );
  }
}

class _DropDownContainer extends StatelessWidget {
  final Map<String, dynamic> data;
  const _DropDownContainer({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> _children = data.entries.map<Widget>((entry) {
      Widget w = Row(
        children: [
          Text(entry.key.toString()),
          Spacer(),
          Text(entry.value.toString()),
        ],
      );
      return w;
    }).toList();

    return Container(
      /// height: 100,
      child: Column(
        /// children: [
        ///   Expanded(
        ///       child: Container(
        ///     color: Colors.red,
        ///     height: 50,
        ///   )),

        /// ],
        children: _children,
      ),
    );
  }
}

class Item {
  final String roomNumber;
  final String? roomType;
  final String? capacity;
  final String? price;
  final String? status;
  final String? numberOfBeds;
  final String? id;

  Item(
      {required this.roomNumber,
      this.roomType,
      this.capacity,
      this.price,
      this.status,
      this.numberOfBeds,
      this.id});
   factory Item.fromMap(Map<dynamic, dynamic> map) {
    return Item(
      

      roomType: map['roomType'] ?? '',
      roomNumber: map['roomNumber'] ?? '',
      capacity: map['capacity'] ?? '',
      price: map['price']??'',
      status: map['status'] ?? '',
      numberOfBeds: map['numberOfBeds'] ?? '',
      id: map['id'] ?? '',


    );
  }
  factory Item.fromJson(Map<String, dynamic> json) {
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
    
    return Item(
      roomNumber: json['roomNumber'],
      roomType: roomType,
      capacity: json['capacity'],
      price: json['price'],
      status: status,
      numberOfBeds: json['numberOfBeds'],
      id: json['id'],
    );



    
  }
}
