import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:point_of_sales/Models/Product.dart';
import 'package:point_of_sales/Screens/Product/widgets/UpdateProductModal.dart';
import 'package:point_of_sales/Services/Api.dart';
import 'package:point_of_sales/Utils/AppColors.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:http/http.dart' as http;
import 'package:point_of_sales/Configuration/AppConfig.dart';

class ProductsTable extends StatefulWidget {
  ProductsTable({Key? key}) : super(key: key);

  @override
  ProductsTableState createState() => ProductsTableState();
}

class ProductsTableState extends State<ProductsTable> {
  ApiService service = new ApiService();
  List<Product> products = <Product>[];
  List<Product> filteredProducts = <Product>[];
  ProductDataSource? productDataSource;
  bool isLoading = true;
  final int rowsPerPage = 7;
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
    ApiResponse response = await ApiService.getProducts();

    if (response.status == 200) {
      setState(() {
        products = response.data;
        productDataSource = ProductDataSource(
            context: context,
            refreshNotifier: refreshNotifier,
            productData: products,
            rowsPerPage: rowsPerPage);
        isLoading = false;
      });
    } else {
      setState(() {
        products = [];
        productDataSource = ProductDataSource(
            refreshNotifier: refreshNotifier,
            productData: products,
            rowsPerPage: rowsPerPage,
            context: context);
        isLoading = false;
      });
    }
  }

  void onSearch(String searchText) {
    setState(() {
      if (searchText.isEmpty) {
        filteredProducts = products;
      } else {
        filteredProducts = products
            .where((product) =>
                product.name.toLowerCase().contains(searchText.toLowerCase()) ||
                product.categoryName
                    .toLowerCase()
                    .contains(searchText.toLowerCase()))
            .toList();
      }
      productDataSource = ProductDataSource(
          refreshNotifier: refreshNotifier,
          context: context,
          productData: filteredProducts,
          rowsPerPage: rowsPerPage);
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
                  child: Text('Products Table :',
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
                else if (productDataSource != null)
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
                      source: productDataSource!,
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
                            columnName: 'price',
                            label: Container(
                                padding: EdgeInsets.all(8.0),
                                alignment: Alignment.center,
                                child: Text(
                                  'Price',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                  overflow: TextOverflow.ellipsis,
                                ))),
                        GridColumn(
                            columnName: 'status',
                            label: Container(
                                padding: EdgeInsets.all(8.0),
                                alignment: Alignment.center,
                                child: Text('Status',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)))),
                        GridColumn(
                            columnName: 'category',
                            label: Container(
                                padding: EdgeInsets.all(8.0),
                                alignment: Alignment.center,
                                child: Text('Category',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)))),
                        GridColumn(
                            columnName: 'stock',
                            label: Container(
                                padding: EdgeInsets.all(8.0),
                                alignment: Alignment.center,
                                child: Text('Stock',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)))),
                        GridColumn(
                            columnName: 'minimumStock',
                            label: Container(
                                padding: EdgeInsets.all(8.0),
                                alignment: Alignment.center,
                                child: Text('Min Stock',
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
              delegate: productDataSource!,
              pageCount: filteredProducts.length > 0
                  ? (filteredProducts.length / rowsPerPage).ceilToDouble()
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

class ProductDataSource extends DataGridSource {
  BuildContext context;
  final ValueNotifier<bool> refreshNotifier;
  ProductDataSource(
      {required List<Product> productData,
      required this.refreshNotifier,
      required this.rowsPerPage,
      required this.context}) {
    _productData = productData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'id', value: e.id),
              DataGridCell<String>(columnName: 'name', value: e.name),
              DataGridCell<double>(columnName: 'price', value: e.price),
              DataGridCell<Productstatus>(
                  columnName: 'status', value: e.status),
              DataGridCell<String>(
                  columnName: 'category', value: e.categoryName),
              DataGridCell<int>(columnName: 'stock', value: e.stock),
              DataGridCell<int>(
                  columnName: 'minimumStock', value: e.minimumStock),
              DataGridCell<String>(columnName: 'actions', value: ""),
            ]))
        .toList();
  }

  List<DataGridRow> _productData = [];
  List<DataGridRow> paginatedData = [];
  int rowsPerPage;
  @override
  List<DataGridRow> get rows => paginatedData;

  Widget getStatusBadge(Productstatus status) {
    Color color = Colors.redAccent;
    if (status == Productstatus.InStock)
      color = Appcolors.thirdBlue;
    else if (status == Productstatus.LowStock)
      color = Appcolors.mainBlue;
    else if (status == Productstatus.NoStockable) color = Appcolors.mainBlue;

    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.all(8),
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(15)),
      child: Text(
        status.name,
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Future<void> deleteProd(int id) async {
    ApiResponse response = await ApiService.deleteProduct(id);

    if (response.status == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Product is deleted!")),
      );
      // notifyListeners();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to delete product!")),
      );
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

      if (e.columnName == "status") return getStatusBadge(e.value);

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

                  final price = row
                      .getCells()
                      .firstWhere((cell) => cell.columnName == 'price')
                      .value as double;

                  final stock = row
                      .getCells()
                      .firstWhere((cell) => cell.columnName == 'stock')
                      .value as int;

                  final minS = row
                      .getCells()
                      .firstWhere((cell) => cell.columnName == 'minimumStock')
                      .value as int;

                  showModalBottomSheet<void>(
                    isScrollControlled: true,
                    context: context,
                    builder: (BuildContext context) {
                      return UpdateProductModal(
                        refreshNotifier: refreshNotifier,
                        id: id.toString(),
                        categData: {
                          'name': name,
                          "price": price,
                          "stock": stock,
                          "minimumStock": minS,
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
                    await deleteProd(id);
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

  @override
  Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) async {
    int startIndex = newPageIndex * rowsPerPage;
    int endIndex = startIndex + rowsPerPage;
    if (_productData.length < rowsPerPage)
      paginatedData = _productData.getRange(0, _productData.length).toList();
    else
      paginatedData = _productData.getRange(startIndex, endIndex).toList();
    notifyListeners();
    return true;
  }
}
