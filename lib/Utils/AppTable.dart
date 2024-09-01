import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:point_of_sales/SharedWidget/AppContainer.dart';
import 'package:point_of_sales/Utils/AppColors.dart';

class PaginatedDataTableExample extends StatefulWidget {
  @override
  _PaginatedDataTableExampleState createState() =>
      _PaginatedDataTableExampleState();
}

class _PaginatedDataTableExampleState extends State<PaginatedDataTableExample> {
  final _data = MyData();
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      child: Theme(
        data: ThemeData(
          primarySwatch: Colors.blue, // Pagination arrows color
          brightness: Brightness.dark, // Overall dark mode
          textTheme: TextTheme(
            bodySmall: TextStyle(color: Colors.white), // General text color
          ),
          iconTheme: IconThemeData(
            color: Colors.white, // Color for icons, including pagination arrows
          ),
          dividerColor: Colors.white54, // Divider color
        ),
        child: Card(
          color: Colors.transparent, // Dark background for the card
          child: Column(
            children: [
              Container(
                color:
                    Appcolors.sideBarColor, // Background color for the header
                padding: EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'User Information',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontFamily: "Arial"),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 40.0),
                        child: TextField(
                          onChanged: (query) {
                            setState(() {
                              _searchQuery = query;
                              _data.updateFilter(query);
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'Search',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.search, color: Colors.white),
                            filled: true,
                            fillColor: Colors.black54,
                          ),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: PaginatedDataTable2(
                  dividerThickness: 0.5,

                  columns: [
                    DataColumn(
                      label: Expanded(
                        child: Center(
                          child: Text(
                            'ID',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight:
                                    FontWeight.bold), // Header text color
                          ),
                        ),
                      ),
                      numeric: true,
                    ),
                    DataColumn(
                      label: Expanded(
                        child: Center(
                          child: Text(
                            'Name',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight:
                                    FontWeight.bold), // Header text color
                          ),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Expanded(
                        child: Center(
                          child: Text(
                            'Age',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight:
                                    FontWeight.bold), // Header text color
                          ),
                        ),
                      ),
                      numeric: true,
                    ),
                    DataColumn(
                      label: Expanded(
                        child: Center(
                          child: Text('Profession',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight:
                                      FontWeight.bold) // Header text color
                              ),
                        ),
                      ),
                    ),
                  ],
                  source: _data,
                  columnSpacing: 12,
                  horizontalMargin: 12,
                  rowsPerPage: 5,
                  showCheckboxColumn: false,
                  wrapInCard: false,
                  dataRowHeight: 60, // Optional: adjust row height
                  headingRowColor: MaterialStateProperty.resolveWith<Color>(
                      (states) => Color(0xff1e272e)), // Header row color
                  headingTextStyle: TextStyle(color: Colors.white),
                  // Header text color
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyData extends DataTableSource {
  final List<Map<String, dynamic>> _allData = List.generate(
    100,
    (index) => {
      "id": index,
      "name": "User $index",
      "age": 20 + index % 50,
      "profession": "Profession $index"
    },
  );
  List<Map<String, dynamic>> _filteredData;

  MyData()
      : _filteredData = List.from(List.generate(
          100,
          (index) => {
            "id": index,
            "name": "User $index",
            "age": 20 + index % 50,
            "profession": "Profession 00000000000000000000000000000000 $index"
          },
        ));

  void updateFilter(String query) {
    if (query.isEmpty) {
      _filteredData = List.from(_allData);
    } else {
      _filteredData = _allData.where((row) {
        return row['name'].toLowerCase().contains(query.toLowerCase()) ||
            row['profession'].toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    notifyListeners(); // Notify the table to update
  }

  @override
  DataRow? getRow(int index) {
    if (index >= _filteredData.length) return null;
    final user = _filteredData[index];

    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(
          Center(
              child: Text(user['id'].toString(),
                  style: TextStyle(color: Colors.white))),
        ),
        DataCell(Center(
            child: Text(user['name'], style: TextStyle(color: Colors.white)))),
        DataCell(Center(
          child: Text(user['age'].toString(),
              style: TextStyle(color: Colors.white)),
        )),
        DataCell(Center(
            child: Text(user['profession'],
                style: TextStyle(color: Colors.white)))),
      ],
      color: MaterialStateProperty.resolveWith<Color>((states) {
        if (states.contains(MaterialState.selected)) {
          return Appcolors.sideBarColor; // Selected row color
        }
        return Colors.transparent; // Alternating row colors
      }),
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _filteredData.length;

  @override
  int get selectedRowCount => 0;
}

class CustomPaginationControls extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final void Function(int) onPageChanged;

  CustomPaginationControls({
    required this.currentPage,
    required this.totalPages,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(Icons.chevron_left, color: Colors.white),
          onPressed:
              currentPage > 0 ? () => onPageChanged(currentPage - 1) : null,
        ),
        Text(
          'Page ${currentPage + 1} of $totalPages',
          style: TextStyle(color: Colors.white),
        ),
        IconButton(
          icon: Icon(Icons.chevron_right, color: Colors.white),
          onPressed: currentPage < totalPages - 1
              ? () => onPageChanged(currentPage + 1)
              : null,
        ),
      ],
    );
  }
}
