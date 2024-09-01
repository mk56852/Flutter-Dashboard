import 'package:flutter/material.dart';
import 'package:point_of_sales/Models/CardModel.dart';
import 'package:point_of_sales/Utils/AppColors.dart';
import 'package:point_of_sales/Utils/AppDimension.dart';

class PosRightBar extends StatefulWidget {
  PosRightBar({super.key});

  @override
  State<PosRightBar> createState() => _PosRightBarState();
}

class _PosRightBarState extends State<PosRightBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(color: Colors.white, width: 0.3),
            borderRadius: BorderRadius.circular(15)),
        constraints:
            BoxConstraints.tightForFinite(width: AppDimension.sideBarDimension),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: Text(
                    'Orders',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22),
                  )),
                  InkWell(
                    onTap: () => print("hello"),
                    child: Text(
                      'Clear All',
                      style: TextStyle(color: Appcolors.sideBarTextColor),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Divider(color: Appcolors.sideBarTextColor),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  RightBarItem(
                    card: CardModel(
                      productName: "product ",
                      price: "20.0",
                      image: "assets/images/logo.png",
                      badge: "badge",
                    ),
                  ),
                  RightBarItem(
                    card: CardModel(
                      productName: "product ",
                      price: "20.0",
                      image: "assets/images/logo.png",
                      badge: "badge",
                    ),
                  ),
                  RightBarItem(
                    card: CardModel(
                      productName: "product ",
                      price: "20.0",
                      image: "assets/images/logo.png",
                      badge: "badge",
                    ),
                  ),
                  RightBarItem(
                    card: CardModel(
                      productName: "product ",
                      price: "20.0",
                      image: "assets/images/logo.png",
                      badge: "badge",
                    ),
                  ),
                  RightBarItem(
                    card: CardModel(
                      productName: "product ",
                      price: "20.0",
                      image: "assets/images/logo.png",
                      badge: "badge",
                    ),
                  ),
                  RightBarItem(
                    card: CardModel(
                      productName: "product ",
                      price: "20.0",
                      image: "assets/images/logo.png",
                      badge: "badge",
                    ),
                  ),
                  RightBarItem(
                    card: CardModel(
                      productName: "product ",
                      price: "20.0",
                      image: "assets/images/logo.png",
                      badge: "badge",
                    ),
                  ),
                  RightBarItem(
                    card: CardModel(
                      productName: "product ",
                      price: "20.5",
                      image: "assets/images/logo.png",
                      badge: "badge",
                    ),
                  ),
                ],
              ),
            )),
            Divider(color: Appcolors.sideBarTextColor),
            SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}

class RightBarItem extends StatefulWidget {
  CardModel card;
  RightBarItem({super.key, required this.card});

  @override
  State<RightBarItem> createState() => _RightBarItemState();
}

class _RightBarItemState extends State<RightBarItem> {
  int nb = 1;

  void add() {
    setState(() {
      nb += 1;
    });
  }

  void delete() {
    setState(() {
      nb -= 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
      child: Container(
        height: 90,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
                flex: 2,
                child: AspectRatio(
                    aspectRatio: 1,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(7),
                        child: Image.asset(
                          "assets/images/choco.png",
                          fit: BoxFit.cover,
                        )))),
            SizedBox(
              width: 10,
            ),
            Expanded(
                flex: 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.card.productName,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      widget.card.price + " X " + nb.toString(),
                      style: TextStyle(
                        color: Appcolors.sideBarTextColor,
                        fontSize: 12,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            (double.parse(widget.card.price) * nb).toString() +
                                " DT",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        Expanded(
                            child:
                                Incrementor(nb: nb, add: add, delete: delete))
                      ],
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

class Incrementor extends StatelessWidget {
  int nb;
  Function add;
  Function delete;
  Incrementor(
      {super.key, required this.nb, required this.add, required this.delete});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        InkWell(
          onTap: () => delete(),
          child: Text(
            "-",
            style: TextStyle(
                fontSize: 17, color: Colors.grey, fontWeight: FontWeight.w700),
          ),
        ),
        Text(
          nb.toString(),
          style: TextStyle(color: Colors.white),
        ),
        InkWell(
          onTap: () => add(),
          child: Text(
            "+",
            style: TextStyle(
                fontSize: 17, color: Colors.grey, fontWeight: FontWeight.w700),
          ),
        )
      ],
    );
  }
}
