import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:point_of_sales/Models/Category.dart';
import 'package:point_of_sales/Screens/Category/widgets/UpdateCategoryModal.dart';
import 'package:point_of_sales/Services/Api.dart';
import 'package:point_of_sales/Utils/AppColors.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:http/http.dart' as http;
import 'package:point_of_sales/Configuration/AppConfig.dart';

class CategoryTable extends StatefulWidget {
  CategoryTable({Key? key}) : super(key: key);

  @override
  CategoryTableState createState() => CategoryTableState();
}

class CategoryTableState extends State<CategoryTable> {
  ApiService service = new ApiService();
  List<Category> categories = <Category>[];
  List<Category> filteredCategories = <Category>[];
  CategoryDataSource? categoryDataSource;
  bool isLoading = true;
  final int rowsPerPage = 5;
  TextEditingController searchController = TextEditingController();
  final ValueNotifier<bool> refreshNotifier = ValueNotifier(false);

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
    ApiResponse response = await ApiService.getCategories();
    if (response.status == 200) {
      setState(() {
        categories = response.data;
        categoryDataSource = CategoryDataSource(
            context: context,
            categoriesData: categories,
            rowsPerPage: rowsPerPage,
            refreshNotifier: refreshNotifier);
        isLoading = false;
      });
    } else {
      setState(() {
        categories = [];
        categoryDataSource = CategoryDataSource(
            context: context,
            categoriesData: categories,
            rowsPerPage: rowsPerPage,
            refreshNotifier: refreshNotifier);
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
          context: context,
          categoriesData: filteredCategories,
          rowsPerPage: rowsPerPage,
          refreshNotifier: refreshNotifier);
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
              pageCount: categories.length > 0
                  ? (categories.length / rowsPerPage).ceilToDouble()
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
  BuildContext context;
  final ValueNotifier<bool> refreshNotifier;
  CategoryDataSource({
    required this.context,
    required List<Category> categoriesData,
    required this.rowsPerPage,
    required this.refreshNotifier,
  }) {
    _transactionData = categoriesData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'id', value: e.id),
              DataGridCell<String>(columnName: 'name', value: e.name),
              DataGridCell<String>(columnName: 'imageUrl', value: e.imageUrl),
              DataGridCell<String>(columnName: 'actions', value: ""),
            ]))
        .toList();

    // Initialize paginated data based on the first page and rowsPerPage
    int endIndex = rowsPerPage < _transactionData.length
        ? rowsPerPage
        : _transactionData.length;
    paginatedData = _transactionData.getRange(0, endIndex).toList();
  }

  List<DataGridRow> _transactionData = [];
  List<DataGridRow> paginatedData = [];
  final int rowsPerPage;

  @override
  List<DataGridRow> get rows => paginatedData;

  @override
  Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) async {
    int startIndex = newPageIndex * rowsPerPage;
    int endIndex = startIndex + rowsPerPage;

    // Ensure the endIndex does not exceed the length of _transactionData
    endIndex =
        endIndex > _transactionData.length ? _transactionData.length : endIndex;

    // Update paginatedData based on new indices
    paginatedData = _transactionData.getRange(startIndex, endIndex).toList();

    // Notify listeners to rebuild the data grid
    notifyListeners();
    return true;
  }

  Future<void> deleteCateg(int id) async {
    ApiResponse response = await ApiService.deleteCategory(id);
    if (response.status == 200) {
      print('category deleted successfully');

      _transactionData.removeWhere((row) => row
          .getCells()
          .any((cell) => cell.columnName == 'id' && cell.value == id));
      paginatedData = _transactionData;
      notifyListeners();
    } else {
      print('Failed to delete Category');
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
              InkWell(
                onTap: () async {
                  // Get the user data from the row
                  final id = row
                      .getCells()
                      .firstWhere((cell) => cell.columnName == 'id')
                      .value as int;
                  final name = row
                      .getCells()
                      .firstWhere((cell) => cell.columnName == 'name')
                      .value as String;

                  showModalBottomSheet<void>(
                    isScrollControlled: true,
                    context: context,
                    builder: (BuildContext context) {
                      return UpdateCategoryModal(
                        refreshNotifier: refreshNotifier,
                        categId: id.toString(),
                        categData: {
                          'name': name,
                        },
                      );
                    },
                  );
                },
                child: FaIcon(FontAwesomeIcons.penToSquare),
              ),
              SizedBox(
                width: 15,
              ),
              InkWell(
                  onTap: () async {
                    final id = row
                        .getCells()
                        .firstWhere((cell) => cell.columnName == 'id')
                        .value as int;
                    await deleteCateg(id);
                    refreshNotifier.value = !refreshNotifier.value;
                  },
                  child: FaIcon(FontAwesomeIcons.trash))
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
}
