import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:point_of_sales/SharedWidget/AppContainer.dart';
import 'package:point_of_sales/SharedWidget/NumberWidget.dart';
import 'package:point_of_sales/Utils/AppColors.dart';

class MoneyBadget extends StatelessWidget {
  bool isOut;
  double amount;
  String title;
  MoneyBadget(
      {super.key, required this.amount, this.title = "", this.isOut = false});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        aspectRatio: 1.9,
        child: AppContainer(
          elevation: 4,
          bgColor: Appcolors.thirdBlue,
          alignment: Alignment.center,
          padding: EdgeInsets.all(5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    title,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  FaIcon(
                    isOut
                        ? FontAwesomeIcons.moneyBillTransfer
                        : FontAwesomeIcons.moneyBillTrendUp,
                    color: Colors.white,
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                amount.toString() + " DT",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(child: ChartLogo(color: Colors.white)),
                ],
              )
            ],
          ),
        ));
  }
}
