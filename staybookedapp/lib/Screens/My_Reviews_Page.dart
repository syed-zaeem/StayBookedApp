import 'package:flutter/material.dart';

class MyReviewsPage extends StatefulWidget {
  const MyReviewsPage({super.key});

  @override
  State<MyReviewsPage> createState() => _MyReviewsPageState();
}

class _MyReviewsPageState extends State<MyReviewsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Reviews",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
              child: Text(
                "My Reviews",
                style: TextStyle(
                  color: Color.fromARGB(255, 192, 116, 2),
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            DataTable(
              columnSpacing: (MediaQuery.of(context).size.width / 10) * 0,
              dataRowHeight: 100,
              columns: const <DataColumn>[
                DataColumn(
                  label: Text(
                    'Name',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Message',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Rating',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Date',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
              rows: [
                DataRow(
                  cells: <DataCell>[
                    DataCell(Container(
                        width: (MediaQuery.of(context).size.width / 10) * 2,
                        child: const Text('Ammar Zaidi'))),
                    DataCell(Container(
                        width: (MediaQuery.of(context).size.width / 10) * 3,
                        child: Text(
                            'This is a very good service for all the people.'))),
                    DataCell(Container(
                        width: (MediaQuery.of(context).size.width / 10) * 2,
                        child: const Text('4'))),
                    DataCell(Container(
                        width: (MediaQuery.of(context).size.width / 10) * 2,
                        child: const Text('23-11-2023'))),
                  ],
                ),
                DataRow(
                  cells: <DataCell>[
                    DataCell(Container(
                        width: (MediaQuery.of(context).size.width / 10) * 3,
                        child: const Text('Ammar Zaidi'))),
                    DataCell(Container(
                        width: (MediaQuery.of(context).size.width / 10) * 2,
                        child: Text(
                            'This is a very good service for all the people.'))),
                    DataCell(Container(
                        width: (MediaQuery.of(context).size.width / 10) * 2,
                        child: const Text('5'))),
                    DataCell(Container(
                        width: (MediaQuery.of(context).size.width / 10) * 2,
                        child: const Text('24-11-2023'))),
                  ],
                ),
                DataRow(
                  cells: <DataCell>[
                    DataCell(Container(
                        width: (MediaQuery.of(context).size.width / 10) * 3,
                        child: const Text('Ammar Zaidi'))),
                    DataCell(Container(
                        width: (MediaQuery.of(context).size.width / 10) * 2,
                        child: Text(
                            'This is a very good service for all the people.'))),
                    DataCell(Container(
                        width: (MediaQuery.of(context).size.width / 10) * 2,
                        child: const Text('3'))),
                    DataCell(Container(
                        width: (MediaQuery.of(context).size.width / 10) * 2,
                        child: const Text('26-11-2023'))),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
