import 'package:flutter/material.dart';
import 'package:point_of_sales/Models/CardModel.dart';
import 'package:point_of_sales/Screens/POS/CardNotifier/CardNotifier.dart';
import 'package:point_of_sales/SharedWidget/AppButton.dart';
import 'package:point_of_sales/Utils/AppColors.dart';
import 'package:point_of_sales/Utils/AppDimension.dart';
import 'package:provider/provider.dart';

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
            border: Border.all(color: Appcolors.borderColor),
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
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  )),
                  InkWell(
                    onTap: () =>
                        Provider.of<CardNotifier>(context, listen: false)
                            .deleteAll(),
                    child: Text(
                      'Clear All',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Divider(color: Appcolors.borderColor),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: Provider.of<CardNotifier>(context)
                    .cards
                    .map((item) =>
                        RightBarItem(card: item)) // Use => to return widgets
                    .toList(),
              ),
            )),
            Divider(color: Appcolors.borderColor),
            Container(
              height: 100,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total",
                        style: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.w700),
                      ),
                      Text(
                        Provider.of<CardNotifier>(context).total.toString() +
                            " DT",
                        style: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Expanded(
                    child: AppButton(
                        title: "Order Now",
                        bgColor: Appcolors.mainBlue,
                        textColor: Colors.white,
                        borderColor: Appcolors.borderColor,
                        onTap: () {
                          print("ello");
                        }),
                  )
                ],
              ),
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
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      widget.card.price + " X " + nb.toString(),
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            (double.parse(widget.card.price) * nb).toString() +
                                " DT",
                          ),
                        ),
                        Expanded(
                            child: Incrementor(
                                nb: nb,
                                add: add,
                                delete: delete,
                                price: widget.card.price))
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
  String price;
  Incrementor(
      {super.key,
      required this.nb,
      required this.add,
      required this.delete,
      required this.price});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        InkWell(
          onTap: () {
            delete();
            Provider.of<CardNotifier>(context, listen: false)
                .deletePrice(price);
          },
          child: Text(
            "-",
            style: TextStyle(
                fontSize: 17, color: Colors.grey, fontWeight: FontWeight.w700),
          ),
        ),
        Text(
          nb.toString(),
        ),
        InkWell(
          onTap: () {
            add();
            Provider.of<CardNotifier>(context, listen: false).addPrice(price);
          },
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
