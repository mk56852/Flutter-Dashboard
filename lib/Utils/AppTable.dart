import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:point_of_sales/Models/User.dart';
import 'package:point_of_sales/Screens/Users/widgets/UpdateUserModal.dart';
import 'package:point_of_sales/Services/Api.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:http/http.dart' as http;
import 'package:point_of_sales/Configuration/AppConfig.dart';

class AppDataTable extends StatefulWidget {
  AppDataTable({Key? key}) : super(key: key);

  @override
  AppDataTableState createState() => AppDataTableState();
}

class AppDataTableState extends State<AppDataTable> {
  List<User> users = <User>[];
  UsersDataSource? usersDataSource;
  bool isLoading = true;
  final int rowsPerPage = 7;
  final ValueNotifier<bool> refreshNotifier =
      ValueNotifier(false); // Add notifier

  @override
  void initState() {
    super.initState();
    fetchData();
    refreshNotifier.addListener(() {
      fetchData();
    });
  }

  void refreshData() {
    fetchData();
  }

  Future<void> fetchData() async {
    ApiResponse response = await ApiService.getUsers();
    if (response.status == 200) {
      setState(() {
        users = response.data;
        usersDataSource = UsersDataSource(
            employeeData: users,
            refreshNotifier: refreshNotifier,
            context: context);
        isLoading = false;
      });
    } else {
      setState(() {
        users = [];
        usersDataSource = UsersDataSource(
            employeeData: users,
            refreshNotifier: refreshNotifier,
            context: context);
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black26, width: 0.3),
          borderRadius: BorderRadius.circular(30)),
      child: Column(
        children: [
          // Data grid container
          Expanded(
            child: Stack(
              children: [
                if (isLoading)
                  Center(
                    child: SizedBox(
                        height: 200,
                        width: 200,
                        child: Lottie.asset('assets/animations/loading.json')),
                  )
                else if (usersDataSource != null)
                  SfDataGridTheme(
                    data: SfDataGridThemeData(
                      gridLineStrokeWidth: 0.5,
                      sortIconColor:
                          Colors.black, // Set color for the sort icon
                      sortIcon: Icon(
                        Icons.arrow_downward_outlined,
                        size: 13,
                        color: Colors.black,
                      ),
                      filterIcon: Icon(
                        Icons.settings,
                        size: 13,
                        color: Colors.black,
                      ),
                    ),
                    child: SfDataGrid(
                      source: usersDataSource!,
                      columnWidthMode: ColumnWidthMode.fill,
                      allowColumnsResizing: true,
                      allowFiltering: true,
                      allowSorting: true,
                      gridLinesVisibility: GridLinesVisibility.none,
                      headerGridLinesVisibility: GridLinesVisibility.none,
                      headerRowHeight: 65,
                      selectionMode: SelectionMode.single,
                      columns: <GridColumn>[
                        GridColumn(
                            columnName: 'id',
                            label: Container(
                                padding: EdgeInsets.all(16.0),
                                alignment: Alignment.center,
                                child: Text(
                                  'ID',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ))),
                        GridColumn(
                            columnName: 'firstName',
                            label: Container(
                                padding: EdgeInsets.all(8.0),
                                alignment: Alignment.center,
                                child: Text('First Name',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)))),
                        GridColumn(
                            columnName: 'lastName',
                            label: Container(
                                padding: EdgeInsets.all(8.0),
                                alignment: Alignment.center,
                                child: Text(
                                  'Last Name',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                  overflow: TextOverflow.ellipsis,
                                ))),
                        GridColumn(
                            columnName: 'email',
                            label: Container(
                                padding: EdgeInsets.all(8.0),
                                alignment: Alignment.center,
                                child: Text('Email',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)))),
                        GridColumn(
                            columnName: 'role',
                            label: Container(
                                padding: EdgeInsets.all(8.0),
                                alignment: Alignment.center,
                                child: Text('Role',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)))),
                        GridColumn(
                            columnName: 'actions',
                            label: Container(
                                padding: EdgeInsets.all(8.0),
                                alignment: Alignment.center,
                                child: Text('Actions',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)))),
                      ],
                    ),
                  ),
                // Positioned divider
                Positioned(
                  top: 55, // Position the divider just below the header row
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 1),
                    child: Divider(
                      color: Colors.black26,
                      thickness: 1,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 50,
          ),
          if (isLoading)
            SizedBox()
          else
            SfDataPager(
              delegate: usersDataSource!,
              pageCount: users.length > 0
                  ? (users.length / rowsPerPage).ceilToDouble()
                  : 1,
              direction: Axis.horizontal,
              itemHeight: 35,
              itemWidth: 35,
            ),
        ],
      ),
    );
  }
}

class UsersDataSource extends DataGridSource {
  BuildContext context;
  final ValueNotifier<bool> refreshNotifier;
  UsersDataSource(
      {required List<User> employeeData,
      required this.refreshNotifier,
      required this.context}) {
    _employeeData = employeeData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'id', value: e.id),
              DataGridCell<String>(columnName: 'firstName', value: e.firstName),
              DataGridCell<String>(columnName: 'lastName', value: e.lastName),
              DataGridCell<String>(columnName: 'email', value: e.email),
              DataGridCell<String>(columnName: 'role', value: e.role),
              DataGridCell<String>(columnName: 'actions', value: ""),
            ]))
        .toList();
    paginatedData = _employeeData.getRange(0, _employeeData.length).toList();
  }

  List<DataGridRow> _employeeData = [];
  List<DataGridRow> paginatedData = [];

  @override
  List<DataGridRow> get rows => paginatedData;

  Future<void> deleteUser(int id) async {
    ApiResponse response = await ApiService.deleteUser(id);

    if (response.status == 200) {
      _employeeData.removeWhere((row) => row
          .getCells()
          .any((cell) => cell.columnName == 'id' && cell.value == id));
      paginatedData = _employeeData;
      notifyListeners();
    }
  }

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      if (e.columnName == "id")
        return Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(8),
          child: Container(
            padding: EdgeInsets.all(6.0),
            decoration: BoxDecoration(
                color: Colors.orange, borderRadius: BorderRadius.circular(5)),
            child: Text(
              e.value.toString(),
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      if (e.columnName == "actions")
        return Center(
          child: Container(
            alignment: Alignment.center,
            child: Row(
              children: [
                InkWell(
                  onTap: () async {
                    // Get the user data from the row
                    final id = row
                        .getCells()
                        .firstWhere((cell) => cell.columnName == 'id')
                        .value as int;
                    final firstName = row
                        .getCells()
                        .firstWhere((cell) => cell.columnName == 'firstName')
                        .value as String;
                    final lastName = row
                        .getCells()
                        .firstWhere((cell) => cell.columnName == 'lastName')
                        .value as String;
                    final email = row
                        .getCells()
                        .firstWhere((cell) => cell.columnName == 'email')
                        .value as String;
                    final role = row
                        .getCells()
                        .firstWhere((cell) => cell.columnName == 'role')
                        .value as String;

                    // Show the UpdateUserModal with the current user data
                    showModalBottomSheet<void>(
                      isScrollControlled: true,
                      context: context,
                      builder: (BuildContext context) {
                        return UpdateUserModal(
                          refreshNotifier: refreshNotifier,
                          userId: id.toString(),
                          userData: {
                            'firstName': firstName,
                            'lastName': lastName,
                            'email': email,
                            'role': role,
                          },
                        );
                      },
                    );
                  },
                  child: FaIcon(FontAwesomeIcons.penToSquare),
                ),
                SizedBox(
                  width: 5,
                ),
                InkWell(
                    onTap: () async {
                      final id = row
                          .getCells()
                          .firstWhere((cell) => cell.columnName == 'id')
                          .value as int;
                      await deleteUser(id);
                      refreshNotifier.value = !refreshNotifier.value;
                    },
                    child: FaIcon(FontAwesomeIcons.trash))
              ],
            ),
          ),
        );
      return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(8.0),
        child: Text(e.value.toString()),
      );
    }).toList());
  }

  @override
  Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) async {
    int startIndex = newPageIndex * 6;
    int endIndex = startIndex + 6;

    // Ensure the endIndex does not exceed the length of _employeeData
    endIndex =
        endIndex > _employeeData.length ? _employeeData.length : endIndex;

    // Safely update paginatedData
    paginatedData = _employeeData.getRange(startIndex, endIndex).toList();

    // Notify listeners to rebuild the data grid
    notifyListeners();
    return true;
  }
}
