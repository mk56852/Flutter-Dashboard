import 'package:flutter/material.dart';
import 'package:point_of_sales/Models/CardModel.dart';
import 'package:point_of_sales/Screens/POS/CardNotifier/CardNotifier.dart';
import 'package:point_of_sales/SharedWidget/AppButton.dart';
import 'package:point_of_sales/SharedWidget/AppContainer.dart';
import 'package:point_of_sales/Utils/AppColors.dart';

import 'package:provider/provider.dart';

class PosCard extends StatelessWidget {
  CardModel card;
  PosCard({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      elevation: 1,
      height: 360,
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(13),
                child: Image.asset(
                  card.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    card.productName,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 3, vertical: 1),
                        decoration: BoxDecoration(
                            color: Appcolors.mainGreen,
                            borderRadius: BorderRadius.circular(6)),
                        child: Text(
                          card.badge,
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                      Text(
                        card.price + " DT",
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                      child: AppButton(
                    title: "Order",
                    bgColor: Colors.white,
                    textColor: Colors.black,
                    borderColor: Appcolors.borderColor,
                    onTap: () {
                      Provider.of<CardNotifier>(context, listen: false)
                          .add(card);
                    },
                  ))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
