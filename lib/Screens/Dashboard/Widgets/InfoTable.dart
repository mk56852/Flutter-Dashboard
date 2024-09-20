import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_core/core.dart';

/// The home page of the application which hosts the datagrid.
class DashboardInfoTable extends StatefulWidget {
  /// Creates the home page.
  DashboardInfoTable({Key? key}) : super(key: key);

  @override
  _DashboardInfoTableState createState() => _DashboardInfoTableState();
}

class _DashboardInfoTableState extends State<DashboardInfoTable> {
  List<Employee> employees = <Employee>[];
  late EmployeeDataSource employeeDataSource;

  // Rows per page for pagination
  final int rowsPerPage = 5;

  @override
  void initState() {
    super.initState();
    employees = getEmployeeData();
    employeeDataSource = EmployeeDataSource(employeeData: employees);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Data grid container
        Expanded(
          child: SfDataGridTheme(
            data: SfDataGridThemeData(
              gridLineStrokeWidth: 0.5,
            ),
            child: SfDataGrid(
              source: employeeDataSource,
              columnWidthMode: ColumnWidthMode.fill,
              gridLinesVisibility: GridLinesVisibility.none,
              headerGridLinesVisibility: GridLinesVisibility.horizontal,
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
                              fontWeight: FontWeight.bold, fontSize: 14),
                        ))),
                GridColumn(
                    columnName: 'name',
                    label: Container(
                        padding: EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: Text('Name',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14)))),
                GridColumn(
                    columnName: 'designation',
                    label: Container(
                        padding: EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: Text(
                          'Designation',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                          overflow: TextOverflow.ellipsis,
                        ))),
                GridColumn(
                    columnName: 'salary',
                    label: Container(
                        padding: EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: Text('Salary',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14)))),
              ],
            ),
          ),
          // Positioned divider
        ),
        SizedBox(
          height: 20,
        ),
        SfDataPager(
          delegate: employeeDataSource,
          pageCount: (employees.length / rowsPerPage).ceilToDouble(),
          direction: Axis.horizontal,
          itemHeight: 35,
          itemWidth: 35,
        ),
      ],
    );
  }

  List<Employee> getEmployeeData() {
    return [
      Employee(10001, 'James', 'Project Lead', 20000),
      Employee(10002, 'Kathryn', 'Manager', 30000),
      Employee(10003, 'Lara', 'Developer', 15000),
      Employee(10004, 'Michael', 'Designer', 15000),
      Employee(10005, 'Martin', 'Developer', 15000),
      Employee(10006, 'Newberry', 'Developer', 15000),
      Employee(10007, 'Balnc', 'Developer', 15000),
      Employee(10008, 'Perry', 'Developer', 15000),
      Employee(10009, 'Gable', 'Developer', 15000),
      Employee(10010, 'Grimes', 'Developer', 15000)
    ];
  }
}

/// Custom business object class which contains properties to hold the detailed
/// information about the employee which will be rendered in datagrid.
class Employee {
  /// Creates the employee class with required details.
  Employee(this.id, this.name, this.designation, this.salary);

  /// Id of an employee.
  final int id;

  /// Name of an employee.
  final String name;

  /// Designation of an employee.
  final String designation;

  /// Salary of an employee.
  final int salary;
}

/// An object to set the employee collection data source to the datagrid. This
/// is used to map the employee data to the datagrid widget.
class EmployeeDataSource extends DataGridSource {
  /// Creates the employee data source class with required details.
  EmployeeDataSource({required List<Employee> employeeData}) {
    _employeeData = employeeData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'id', value: e.id),
              DataGridCell<String>(columnName: 'name', value: e.name),
              DataGridCell<String>(
                  columnName: 'designation', value: e.designation),
              DataGridCell<int>(columnName: 'salary', value: e.salary),
            ]))
        .toList();
  }

  List<DataGridRow> _employeeData = [];
  List<DataGridRow> paginatedData = [];

  @override
  List<DataGridRow> get rows => paginatedData;

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

      return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(8.0),
        child: Text(e.value.toString()),
      );
    }).toList());
  }

  @override
  Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) async {
    int startIndex = newPageIndex * 5;
    int endIndex = startIndex + 5;
    paginatedData = _employeeData.getRange(startIndex, endIndex).toList();
    notifyListeners();
    return true;
  }
}
