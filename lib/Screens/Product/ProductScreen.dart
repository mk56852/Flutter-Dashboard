import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:point_of_sales/Models/Category.dart';
import 'package:point_of_sales/Screens/Dashboard/Widgets/PieChart.dart';
import 'package:point_of_sales/Screens/Product/widgets/AddProductModal.dart';
import 'package:point_of_sales/Screens/Product/widgets/AppRowBarCharts.dart';
import 'package:point_of_sales/Screens/Product/widgets/ProductsTable.dart';
import 'package:point_of_sales/Services/Api.dart';
import 'package:point_of_sales/SharedWidget/AppButton.dart';
import 'package:point_of_sales/SharedWidget/AppContainer.dart';
import 'package:point_of_sales/SharedWidget/NumberWidget.dart';
import 'package:point_of_sales/SharedWidget/PageTitle.dart';
import 'package:point_of_sales/Utils/AppColors.dart';

class ProductScreen extends StatelessWidget {
  final GlobalKey<ProductsTableState> _prodGlobalKey =
      GlobalKey<ProductsTableState>();
  ProductScreen({super.key});
  void _refreshTable() {
    _prodGlobalKey.currentState?.refreshData();
  }

  Future<List<Category>> fetchProductTypes() async {
    ApiResponse response = await ApiService.getCategories();

    if (response.status == 200) {
      return response.data;
    } else {
      throw Exception("Failed to fetch product types");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                  child: Pagetitle(
                      title: "Product Management",
                      path: "Home  >  Product Management  >  Dashboard")),
              Expanded(
                  child: Align(
                alignment: Alignment.centerRight,
                child: Wrap(
                  spacing: 10,
                  runSpacing: 8,
                  children: [
                    SizedBox(
                      width: 160,
                      child: AppButtonWithIcon(
                        text: "Add Product",
                        onPress: () => showModalBottomSheet<void>(
                          isScrollControlled: true,
                          context: context,
                          builder: (BuildContext context) {
                            return FutureBuilder<List<Category>>(
                                future: fetchProductTypes(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return CircularProgressIndicator();
                                  }

                                  return AddProductModal(
                                      onAddingCateg: _refreshTable,
                                      categories: snapshot.data!);
                                });
                          },
                        ),
                        icon: Icons.add_box_outlined,
                      ),
                    ),
                    SizedBox(
                      width: 150,
                      child: AppButtonWithIcon(
                        text: "Export",
                        onPress: () => print("hello"),
                        icon: Icons.data_exploration_outlined,
                      ),
                    ),
                  ],
                ),
              ))
            ],
          ),
          SizedBox(
            height: 20,
          ),
          ProductInfoBar(),
          SizedBox(
            height: 30,
          ),
          SizedBox(
            height: 600,
            child: ProductsTable(
              key: _prodGlobalKey,
            ),
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}

class ProductInfoBar extends StatelessWidget {
  const ProductInfoBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child: AppContainer(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Total Product",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(
                  height: 20,
                ),
                Text("70 Products are available"),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [ChartLogo(color: Appcolors.thirdBlue)],
                )
              ],
            ),
          )),
          SizedBox(
            width: 10,
          ),
          Expanded(flex: 2, child: AppContainer(child: AppPieChart())),
          SizedBox(
            width: 10,
          ),
          Expanded(flex: 2, child: AppContainer(child: AppRowBarChart()))
        ],
      ),
    );
  }
}

class InfoLegend extends StatelessWidget {
  Color color;
  String txt;
  int number;
  InfoLegend(
      {super.key,
      required this.color,
      required this.txt,
      required this.number});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          height: 10,
          width: 10,
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          txt + ": ",
          style: TextStyle(color: color, fontSize: 13),
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          number.toString(),
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        )
      ],
    );
  }
}
