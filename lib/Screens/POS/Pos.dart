import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:point_of_sales/Models/CardModel.dart';
import 'package:point_of_sales/Screens/POS/widgets/PosCardWidget.dart';
import 'package:point_of_sales/Screens/POS/widgets/RightBar.dart';
import 'package:point_of_sales/SharedWidget/AppContainer.dart';
import 'package:point_of_sales/Utils/Breakpoint.dart';

class Pos extends StatelessWidget {
  const Pos({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double width = constraints.maxWidth;
      if (width > Breakpoint.md) {
        return Row(
          children: [
            Expanded(
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
                gridDelegate: SliverSimpleGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 400),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            PosRightBar(),
          ],
        );
      } else {
        return Scaffold(
          backgroundColor: Colors.transparent,
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.black38,
            onPressed: () => print("hello"),
            child: Text(
              "Orders",
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: Container(
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
              gridDelegate: SliverSimpleGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 400),
            ),
          ),
        );
      }
    });
  }
}
