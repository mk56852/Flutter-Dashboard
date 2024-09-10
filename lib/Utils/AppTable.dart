import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:point_of_sales/Data/AppData.dart';
import 'package:point_of_sales/SharedWidget/AppContainer.dart';
import 'package:point_of_sales/SharedWidget/SearchBar.dart';

class AppPaginatedDataTable extends StatefulWidget {
  List<dynamic> allData;
  List<Comparable<dynamic> Function(dynamic)> getFieldFunctions;
  List<String Function(dynamic)> getColumnValueFunctions;

  AppPaginatedDataTable(
      {required this.allData,
      required this.getColumnValueFunctions,
      required this.getFieldFunctions});

  @override
  _AppPaginatedDataTableState createState() => _AppPaginatedDataTableState();
}

class _AppPaginatedDataTableState extends State<AppPaginatedDataTable> {
  late AppDataSource _data;
  String _searchQuery = '';
  bool _sortAscending = true;
  int? _sortColumnIndex;

  @override
  void initState() {
    _data = AppDataSource(
        allData: widget.allData,
        getFieldFunctions: widget.getFieldFunctions,
        getColumnValueFunctions: widget.getColumnValueFunctions);
    super.initState();
  }

  void sort<T>(
    int columnIndex,
    bool ascending,
  ) {
    _data.sort(columnIndex, ascending);
  }

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
                sortArrowAlwaysVisible: true,
                sortColumnIndex: _sortColumnIndex,
                sortAscending: _sortAscending,
                sortArrowIcon: Icons.keyboard_arrow_up, // custom arrow
                sortArrowAnimationDuration: const Duration(milliseconds: 200),
                dividerThickness: 0.5,
                columns: AppData.userTableColumns
                    .map(
                      (item) => DataColumn(
                        headingRowAlignment: MainAxisAlignment.center,
                        label: Center(
                          child: Text(
                            item["name"],
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        numeric: item["isNumeric"],
                        onSort: (columnIndex, ascending) {
                          sort(AppData.userTableColumns.indexOf(item),
                              ascending);
                        },
                      ),
                    )
                    .toList(),

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

class AppDataSource<T> extends DataTableSource {
  final List<T> _allData;
  List<T> _filteredData;
  int _sortColumnIndex = 0; // Default sort column index
  bool _sortAscending = true; // Default sort direction

  final List<Comparable Function(T)> _getFieldFunctions;
  final List<String Function(T)> _getColumnValueFunctions;

  AppDataSource({
    required List<T> allData,
    required List<Comparable Function(T)> getFieldFunctions,
    required List<String Function(T)> getColumnValueFunctions,
  })  : _allData = List.from(allData),
        _filteredData = List.from(allData),
        _getFieldFunctions = getFieldFunctions,
        _getColumnValueFunctions = getColumnValueFunctions;

  void updateFilter(String query) {
    if (query.isEmpty) {
      _filteredData = List.from(_allData);
    } else {
      _filteredData = _allData.where((item) {
        return _getColumnValueFunctions.any(
            (func) => func(item).toLowerCase().contains(query.toLowerCase()));
      }).toList();
    }
    _sortData();
    notifyListeners();
  }

  void _sortData() {
    _filteredData.sort((a, b) {
      final compareResult = _getFieldFunctions[_sortColumnIndex](a).compareTo(
        _getFieldFunctions[_sortColumnIndex](b),
      );
      return _sortAscending ? compareResult : -compareResult;
    });
  }

  void sort(int columnIndex, bool ascending) {
    _sortColumnIndex = columnIndex;
    _sortAscending = ascending;
    _sortData();
    notifyListeners();
  }

  @override
  DataRow? getRow(int index) {
    if (index >= _filteredData.length) return null;
    final item = _filteredData[index];

    return DataRow.byIndex(
      index: index,
      cells: _getColumnValueFunctions
          .map((func) => DataCell(Center(child: Text(func(item)))))
          .toList(),
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _filteredData.length;

  @override
  int get selectedRowCount => 0;
}
