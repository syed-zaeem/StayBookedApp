import 'package:flutter/material.dart';

class CancelledBookingsForTab extends StatefulWidget {
  const CancelledBookingsForTab({super.key});

  @override
  State<CancelledBookingsForTab> createState() =>
      _CancelledBookingsForTabState();
}

class _CancelledBookingsForTabState extends State<CancelledBookingsForTab> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Center(
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 15),
              child: Text(
                "Cancelled Bookings",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 192, 116, 2)),
              ),
            ),
          ),
          DataTable(
            columnSpacing: (MediaQuery.of(context).size.width / 10) * 0,
            // dataRowHeight: 80,
            columns: const <DataColumn>[
              DataColumn(
                label: Text(
                  'Name',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  'Room Id',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  'Start Date',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  'End Date',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
            rows: [
              DataRow(
                cells: <DataCell>[
                  DataCell(Container(
                      width: (MediaQuery.of(context).size.width / 10) * 3,
                      child: const Text('Muneeb Qureshi'))),
                  DataCell(Container(
                      width: (MediaQuery.of(context).size.width / 10) * 2,
                      child: Text('19'))),
                  DataCell(Container(
                      width: (MediaQuery.of(context).size.width / 10) * 2,
                      child: const Text('20-11-2023'))),
                  DataCell(Container(
                      width: (MediaQuery.of(context).size.width / 10) * 2,
                      child: const Text('23-11-2023'))),
                ],
              ),
              DataRow(
                cells: <DataCell>[
                  DataCell(Container(
                      width: (MediaQuery.of(context).size.width / 10) * 3,
                      child: const Text('Muneeb Qureshi'))),
                  DataCell(Container(
                      width: (MediaQuery.of(context).size.width / 10) * 2,
                      child: Text('20'))),
                  DataCell(Container(
                      width: (MediaQuery.of(context).size.width / 10) * 2,
                      child: const Text('23-11-2023'))),
                  DataCell(Container(
                      width: (MediaQuery.of(context).size.width / 10) * 2,
                      child: const Text('24-11-2023'))),
                ],
              ),
              DataRow(
                cells: <DataCell>[
                  DataCell(Container(
                      width: (MediaQuery.of(context).size.width / 10) * 3,
                      child: const Text('Muneeb Qureshi'))),
                  DataCell(Container(
                      width: (MediaQuery.of(context).size.width / 10) * 2,
                      child: Text('21'))),
                  DataCell(Container(
                      width: (MediaQuery.of(context).size.width / 10) * 2,
                      child: const Text('24-11-2023'))),
                  DataCell(Container(
                      width: (MediaQuery.of(context).size.width / 10) * 2,
                      child: const Text('26-11-2023'))),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
