import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:point_of_sales/SharedWidget/AppContainer.dart';
import 'package:point_of_sales/Utils/AppColors.dart';

class StockScreen extends StatelessWidget {
  const StockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [StockInfoBar()],
      ),
    );
  }
}

class StockInfoBar extends StatelessWidget {
  const StockInfoBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Appcolors.borderColor, width: 0.8),
        ),
      ),
      height: 150,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 30),
            child: VerticalDivider(
              color: Appcolors.borderColor,
              thickness: 0.9,
            ),
          ),
          SizedBox(
            width: 34,
          ),
          Expanded(
              child: StockInfoLines(
            totalProduct: 50,
            inStock: 35,
            inLowStock: 10,
            outOfStock: 5,
          ))
        ],
      ),
    );
  }
}

class StockInfoLines extends StatelessWidget {
  int totalProduct;
  int inStock;
  int inLowStock;
  int outOfStock;

  StockInfoLines(
      {super.key,
      required this.totalProduct,
      required this.inStock,
      required this.inLowStock,
      required this.outOfStock});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Text(
                totalProduct.toString(),
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
              ),
              SizedBox(
                width: 16,
              ),
              Text(
                "product",
                style: TextStyle(color: Appcolors.secondTextColor),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: Appcolors.thirdBlue,
                ),
                width: 150,
                height: 7,
              ),
              SizedBox(
                width: 5,
              ),
              Container(
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: Appcolors.secondTextColor,
                ),
                height: 7,
              ),
              SizedBox(
                width: 5,
              ),
              Container(
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: Colors.red,
                ),
                height: 7,
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              InfoLegend(
                color: Appcolors.thirdBlue,
                txt: "in stock",
                number: 12,
              ),
              SizedBox(
                width: 20,
              ),
              InfoLegend(
                color: Appcolors.secondTextColor,
                txt: "low stock",
                number: 12,
              ),
              SizedBox(
                width: 20,
              ),
              InfoLegend(
                color: Colors.redAccent,
                txt: "out of stock",
                number: 12,
              ),
            ],
          )
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
