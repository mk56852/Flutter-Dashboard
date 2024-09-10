import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TransactionsHistory extends StatelessWidget {
  List<HistoryItem> data;
  TransactionsHistory({super.key, required this.data});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Transaction History",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SizedBox(
            height: 20,
          ),
          if (!data.isEmpty)
            Container(
              height: 220,
              child: SingleChildScrollView(
                child: Column(
                  children: [...data],
                ),
              ),
            )
          else
            Center(
              child: SizedBox(
                height: 220,
                width: 200,
                child: Image.asset("assets/images/noData.png"),
              ),
            ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: InkWell(
              onTap: () => print("hello"),
              child: Container(
                width: 200,
                height: 35,
                decoration: BoxDecoration(
                    border: Border.all(width: 0.4),
                    borderRadius: BorderRadius.circular(25)),
                child: Center(child: Text("View all transactions")),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class HistoryItem extends StatelessWidget {
  String title;
  String date;
  String status;
  String amount;
  HistoryItem(
      {super.key,
      required this.title,
      required this.date,
      required this.amount,
      this.status = "success"});
  Color getStatusBadgeColor(String status) {
    if (status == "failed") return Colors.redAccent;
    return Colors.orangeAccent;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: Container(
        constraints: BoxConstraints(minHeight: 50),
        child: Row(
          children: [
            SizedBox(
                height: 25,
                width: 30,
                child: SvgPicture.asset(
                  "assets/images/x.svg",
                  color: Colors.greenAccent,
                )),
            SizedBox(
              width: 15,
            ),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Text(title,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600)),
                    ),
                    Text(
                      amount,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Text(
                        " Date : " + date,
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ),
                    Text(
                      status,
                      style: TextStyle(
                          color: getStatusBadgeColor(status), fontSize: 14),
                    )
                  ],
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
