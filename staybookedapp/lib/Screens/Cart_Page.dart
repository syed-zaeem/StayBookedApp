import 'dart:math';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:responsive_table/responsive_table.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.reference();

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

  List<Map<String, dynamic>> _generateData() {
    List<Map<String, dynamic>> temps = cartsData;
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

  List<Map<String, dynamic>> cartsData = [];

  Future<void> fetchData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  print("SharedPreferences keys: ${prefs.getKeys()}");
  String? cartsDataString = prefs.getString('cart');

  if (cartsDataString != null) {
    List<dynamic> decodedData = jsonDecode(cartsDataString);
    List<Map<String, dynamic>> fetchedCartsData =
        List<Map<String, dynamic>>.from(decodedData);

    setState(() {
      cartsData = fetchedCartsData;
    });

    print(cartsData);
  } else {
    // Handle the case when there's no data in SharedPreferences
    // You might want to fetch data from the server here if needed
  }
}
 Future<void> saveSelectedCartItemsToFirebase(List<Map<String, dynamic>> selectedItems) async {
    // Get a reference to a new child location
    DatabaseReference newChildRef = _databaseReference.child('CartItems').push();

    // Save the selected items to Firebase Realtime Database
    await newChildRef.set(selectedItems);
  }
  Future<void> _showSuccessMessage() async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Selected items successfully saved to Firebase!'),
        duration: Duration(seconds: 3),
      ),
    );
  }
Future<void> getData() async {
 await fetchData();
}

  @override
  void initState() {
    super.initState();

    getData();

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
          text: "Number Of Beds",
          value: "numberOfBeds",
          show: true,
          sortable: true,
          textAlign: TextAlign.left),
      DatatableHeader(
          text: "Price",
          value: "price",
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "CART",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      // drawer: Drawer(
      //   child: ListView(
      //     children: [
      //       ListTile(
      //         leading: Icon(Icons.home),
      //         title: Text("home"),
      //         onTap: () {},
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
                         onPressed: () async {
                // Save selected cart items to Firebase
                await saveSelectedCartItemsToFirebase(_selecteds);
                 _showSuccessMessage();
              },
                          icon: Icon(Icons.check),
                          label: Text("Confirm Accomodation"),
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
                    print("$value  $item ");
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
                      icon: Icon(
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
