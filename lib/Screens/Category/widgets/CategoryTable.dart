import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:point_of_sales/Models/Category.dart';
import 'package:point_of_sales/Models/Transaction.dart';
import 'package:point_of_sales/Services/Api.dart';
import 'package:point_of_sales/Utils/AppColors.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:http/http.dart' as http;
import 'package:point_of_sales/Configuration/AppConfig.dart';

class CategoryTable extends StatefulWidget {
  CategoryTable({Key? key}) : super(key: key);

  @override
  _CategoryTableState createState() => _CategoryTableState();
}

class _CategoryTableState extends State<CategoryTable> {
  ApiService service = new ApiService();
  List<Category> categories = <Category>[];
  List<Category> filteredCategories = <Category>[];
  CategoryDataSource? categoryDataSource;
  bool isLoading = true;
  final int rowsPerPage = 7;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    categories.add(Category.build(12, "product1", "glace"));
    categories.add(Category.build(12, "product1", "glace"));

    categories.add(Category.build(12, "product1", "glace"));

    isLoading = false;
    filteredCategories = categories;
    categoryDataSource = CategoryDataSource(
        categoriesData: filteredCategories, rowsPerPage: rowsPerPage);
    //fetchData();
  }

  Future<void> fetchData() async {
    dynamic response =
        await http.get(Uri.parse(AppConfig.apiBaseUrl + "api/users"));
    print(response.body);
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      Future.delayed(
          Duration(seconds: 2),
          () => setState(() {
                categories = jsonResponse
                    .map((category) => Category.fromJson(category))
                    .toList();
                categoryDataSource = CategoryDataSource(
                    categoriesData: categories, rowsPerPage: rowsPerPage);
                isLoading = false;
              }));
    } else {
      setState(() {
        categories = [];
        categoryDataSource = CategoryDataSource(
            categoriesData: categories, rowsPerPage: rowsPerPage);
        isLoading = false;
      });
    }
  }

  void onSearch(String searchText) {
    setState(() {
      if (searchText.isEmpty) {
        filteredCategories = categories;
      } else {
        filteredCategories = categories
            .where((categ) =>
                categ.name.toLowerCase().contains(searchText.toLowerCase()))
            .toList();
      }
      categoryDataSource = CategoryDataSource(
          categoriesData: filteredCategories, rowsPerPage: rowsPerPage);
    });
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
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Text('Categories Table :',
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge),
                ),
                Expanded(
                  flex: 3,
                  child: TextField(
                    controller: searchController,
                    onChanged: (value) => onSearch(value),
                    decoration: InputDecoration(
                      labelText: 'Search',
                      hintText: 'Search by product name or category',
                      hintStyle: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.normal,
                          color: Appcolors.secondTextColor),
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
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
                else if (categoryDataSource != null)
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
                      allowFiltering: true,
                      source: categoryDataSource!,
                      columnWidthMode: ColumnWidthMode.fill,
                      allowColumnsResizing: true,
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
                            columnName: 'name',
                            label: Container(
                                padding: EdgeInsets.all(8.0),
                                alignment: Alignment.center,
                                child: Text('Name',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)))),
                        GridColumn(
                            columnName: 'imageUrl',
                            label: Container(
                                padding: EdgeInsets.all(8.0),
                                alignment: Alignment.center,
                                child: Text(
                                  'Image Url',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                  overflow: TextOverflow.ellipsis,
                                ))),
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
              delegate: categoryDataSource!,
              pageCount: filteredCategories.length > 0
                  ? (filteredCategories.length / rowsPerPage).ceilToDouble()
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

class CategoryDataSource extends DataGridSource {
  CategoryDataSource(
      {required List<Category> categoriesData, required this.rowsPerPage}) {
    _transactionData = categoriesData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'id', value: e.id),
              DataGridCell<String>(columnName: 'name', value: e.name),
              DataGridCell<String>(columnName: 'imageUrl', value: e.imageUrl),
              DataGridCell<String>(columnName: 'actions', value: ""),
            ]))
        .toList();
  }

  List<DataGridRow> _transactionData = [];
  List<DataGridRow> paginatedData = [];
  int rowsPerPage;
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
                color: Appcolors.thirdBlue,
                borderRadius: BorderRadius.circular(25)),
            child: Text(
              e.value.toString(),
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      if (e.columnName == "price")
        return Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(8.0),
            child: Text(e.value.toString() + " DT"));

      if (e.columnName == "actions")
        return Container(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              FaIcon(
                FontAwesomeIcons.penToSquare,
                size: 18,
              ),
              SizedBox(
                width: 15,
              ),
              FaIcon(
                FontAwesomeIcons.trash,
                size: 18,
              )
            ],
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
    int startIndex = newPageIndex * rowsPerPage;
    int endIndex = startIndex + rowsPerPage;
    if (_transactionData.length < rowsPerPage)
      paginatedData =
          _transactionData.getRange(0, _transactionData.length).toList();
    else
      paginatedData = _transactionData.getRange(startIndex, endIndex).toList();
    notifyListeners();
    return true;
  }
}
