import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:point_of_sales/SharedWidget/AppContainer.dart';
import 'package:point_of_sales/SharedWidget/SearchBar.dart';
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
      child: Card(
        color: Colors.white,
        child: Column(
          children: [
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 35),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'User Information',
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: "Arial",
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: AppSearchBar(
                      hintText: "search",
                      onChange: (value) {
                        _data.updateFilter(value);
                      },
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
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    numeric: true,
                    onSort: (columnIndex, ascending) {
                      _data.sort('id', ascending);
                    },
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Center(
                        child: Text(
                          'Name',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    onSort: (columnIndex, ascending) {
                      _data.sort('name', ascending);
                    },
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Center(
                        child: Text(
                          'Age',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    numeric: true,
                    onSort: (columnIndex, ascending) {
                      _data.sort('age', ascending);
                    },
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Center(
                        child: Text('Profession',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ),
                    onSort: (columnIndex, ascending) {
                      _data.sort('profession', ascending);
                    },
                  ),
                ],
                source: _data,
                columnSpacing: 12,
                horizontalMargin: 12,
                rowsPerPage: 5,
                showCheckboxColumn: false,
                wrapInCard: false,
                dataRowHeight: 60,
              ),
            ),
          ],
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
  String _sortColumn = 'id'; // Default sort column
  bool _sortAscending = true; // Default sort direction

  MyData()
      : _filteredData = List.from(List.generate(
          100,
          (index) => {
            "id": index,
            "name": "User $index",
            "age": 20 + index % 50,
            "profession": "Profession $index"
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
    _sortData(); // Apply sorting after filtering
    notifyListeners();
  }

  void _sortData() {
    _filteredData.sort((a, b) {
      int compareResult;
      if (_sortColumn == 'id') {
        compareResult = (a['id'] as int).compareTo(b['id'] as int);
      } else if (_sortColumn == 'name') {
        compareResult = (a['name'] as String).compareTo(b['name'] as String);
      } else if (_sortColumn == 'age') {
        compareResult = (a['age'] as int).compareTo(b['age'] as int);
      } else {
        compareResult =
            (a['profession'] as String).compareTo(b['profession'] as String);
      }
      return _sortAscending ? compareResult : -compareResult;
    });
  }

  void sort(String columnName, bool ascending) {
    _sortColumn = columnName;
    _sortAscending = ascending;
    _sortData();
    notifyListeners();
  }

  @override
  DataRow? getRow(int index) {
    if (index >= _filteredData.length) return null;
    final user = _filteredData[index];

    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Center(child: Text(user['id'].toString()))),
        DataCell(Center(child: Text(user['name']))),
        DataCell(Center(child: Text(user['age'].toString()))),
        DataCell(Center(child: Text(user['profession']))),
      ],
      color: MaterialStateProperty.resolveWith<Color>((states) {
        if (states.contains(MaterialState.selected)) {
          return Appcolors.lastBlue; // Selected row color
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
