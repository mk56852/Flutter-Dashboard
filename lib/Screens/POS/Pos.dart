import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:point_of_sales/Models/CardModel.dart';
import 'package:point_of_sales/Screens/POS/CardNotifier/CardNotifier.dart';
import 'package:point_of_sales/Screens/POS/widgets/CategoryList.dart';
import 'package:point_of_sales/Screens/POS/widgets/PosCardWidget.dart';
import 'package:point_of_sales/Screens/POS/widgets/RightBar.dart';
import 'package:point_of_sales/SharedWidget/AppContainer.dart';
import 'package:point_of_sales/SharedWidget/PageTitle.dart';
import 'package:point_of_sales/SharedWidget/SearchBar.dart';
import 'package:point_of_sales/Utils/AppColors.dart';
import 'package:point_of_sales/Utils/Breakpoint.dart';
import 'package:provider/provider.dart';

class Pos extends StatelessWidget {
  const Pos({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double width = constraints.maxWidth;
      if (width > Breakpoint.md) {
        return Column(
          children: [
            Row(
              children: [
                Expanded(
                    flex: 2,
                    child: Pagetitle(
                        title: "Point of sales",
                        path: "home    Point of sales")),
                Expanded(
                  flex: 1,
                  child: AppSearchBar(
                    hintText: "Search Product",
                    onChange: () => print("changed"),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            child: CategoryList(),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          AlignedGridView.custom(
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            itemCount: 8,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return PosCard(
                                  card: CardModel(
                                productName: "product " + index.toString(),
                                price: index.toString(),
                                image: "assets/images/choco.png",
                                badge: "badge",
                              ));
                            },
                            shrinkWrap: true,
                            gridDelegate:
                                SliverSimpleGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 350),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Provider.of<CardNotifier>(context).cards.isEmpty
                      ? SizedBox()
                      : PosRightBar()
                ],
              ),
            ),
          ],
        );
      } else {
        return Scaffold(
          backgroundColor: Colors.transparent,
          floatingActionButton: FloatingActionButton(
            backgroundColor: Appcolors.secondBlue,
            onPressed: () => print("hello"),
            child: Text(
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
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: Container(
                  constraints: BoxConstraints(maxWidth: width),
                  child: AlignedGridView.custom(
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    itemCount: 8,
                    itemBuilder: (context, index) {
                      return PosCard(
                          card: CardModel(
                        productName: "product " + index.toString(),
                        price: index.toString() + " DT",
                        image: "assets/images/choco.png",
                        badge: "badge",
                      ));
                    },
                    shrinkWrap: true,
                    gridDelegate:
                        SliverSimpleGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 400),
                  ),
                ),
              ),
            ],
          ),
        );
      }
    });
  }
}
