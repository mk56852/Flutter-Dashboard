import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:point_of_sales/Models/CardModel.dart';
import 'package:point_of_sales/Models/Category.dart';
import 'package:point_of_sales/Models/Product.dart';
import 'package:point_of_sales/Screens/POS/CardNotifier/CardNotifier.dart';
import 'package:point_of_sales/Screens/POS/widgets/CategoryList.dart';
import 'package:point_of_sales/Screens/POS/widgets/PosCardWidget.dart';
import 'package:point_of_sales/Screens/POS/widgets/RightBar.dart';
import 'package:point_of_sales/Services/Api.dart';
import 'package:point_of_sales/SharedWidget/PageTitle.dart';
import 'package:point_of_sales/SharedWidget/SearchBar.dart';
import 'package:point_of_sales/Utils/AppColors.dart';
import 'package:point_of_sales/Utils/Breakpoint.dart';
import 'package:provider/provider.dart';

class Pos extends StatefulWidget {
  const Pos({super.key});

  @override
  State<Pos> createState() => _PosState();
}

class _PosState extends State<Pos> {
  late Future<List<Product>> _productsFuture;
  late Future<List<Category>> _categories;

  @override
  void initState() {
    super.initState();
    _categories = fetchCategories();
    _productsFuture = fetchProducts();
  }

  Future<List<Product>> fetchProducts() async {
    ApiResponse response = await ApiService.getProducts();
    if (response.status == 200) {
      return response.data;
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<List<Category>> fetchCategories() async {
    ApiResponse response = await ApiService.getCategories();
    if (response.status == 200) {
      return response.data;
    } else {
      throw Exception('Failed to load categories');
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double width = constraints.maxWidth;
      if (width > Breakpoint.md) {
        return _buildDesktopLayout();
      } else {
        return _buildMobileLayout();
      }
    });
  }

  Widget _buildDesktopLayout() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              flex: 2,
              child: Pagetitle(
                title: "Point of Sales",
                path: "Home > Point of Sales",
              ),
            ),
            Expanded(
              flex: 1,
              child: AppSearchBar(
                hintText: "Search Product",
                onChange: () => print("changed"),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      FutureBuilder<List<Category>>(
                          future: _categories,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(
                                  child: Text("Error: ${snapshot.error}"));
                            } else if (snapshot.hasData &&
                                snapshot.data!.isEmpty) {
                              return const Center(
                                  child: Text("No Category found"));
                            } else {
                              return CategoryList(categories: snapshot.data!);
                            }
                          }),
                      const SizedBox(height: 10),
                      FutureBuilder<List<Product>>(
                        future: _productsFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text("Error: ${snapshot.error}"));
                          } else if (snapshot.hasData &&
                              snapshot.data!.isEmpty) {
                            return const Center(
                                child: Text("No products found"));
                          } else {
                            return _buildProductGrid(snapshot.data!);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Provider.of<CardNotifier>(context).cards.isEmpty
                  ? const SizedBox()
                  : PosRightBar(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Appcolors.secondBlue,
        onPressed: () => print("hello"),
        child: const Text(
          "Orders",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          AppSearchBar(
            hintText: "Search Product",
            onChange: () => print("changed"),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: FutureBuilder<List<Product>>(
              future: _productsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else if (snapshot.hasData && snapshot.data!.isEmpty) {
                  return const Center(child: Text("No products found"));
                } else {
                  return _buildProductGrid(snapshot.data!);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductGrid(List<Product> products) {
    return AlignedGridView.custom(
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      itemCount: products.length,
      shrinkWrap: true,
      gridDelegate: const SliverSimpleGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 350,
      ),
      itemBuilder: (context, index) {
        final product = products[index];
        return PosCard(
          card: CardModel(
            productName: product.name,
            price: product.price.toString(),
            image: product.imageUrl,
            badge: product.categoryName,
          ),
        );
      },
    );
  }
}
