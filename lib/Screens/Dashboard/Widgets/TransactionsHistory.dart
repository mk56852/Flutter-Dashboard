import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:point_of_sales/Utils/AppColors.dart';

class TransactionsHistory extends StatelessWidget {
  final List<HistoryItem> data;

  TransactionsHistory({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              "Transaction History",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          SizedBox(height: 20),
          if (data.isNotEmpty)
            Container(
              height: 300,
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return data[index]; // Display each HistoryItem
                },
              ),
            )
          else
            Center(
              child: SizedBox(
                height: 300,
                width: 250,
                child: Image.asset("assets/images/noData.png"),
              ),
            ),
          SizedBox(height: 20),
          Center(
            child: InkWell(
              onTap: () => print("hello"),
              child: Container(
                width: 200,
                height: 35,
                decoration: BoxDecoration(
                  border: Border.all(width: 0.4),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Center(child: Text("View all transactions")),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HistoryItem extends StatelessWidget {
  final String title;
  final String date;
  final String status;
  final String amount;

  HistoryItem({
    super.key,
    required this.title,
    required this.date,
    required this.amount,
    this.status = "success",
  });

  // Method to get status badge color
  Color getStatusBadgeColor(String status) {
    if (status == "failed") return Colors.redAccent;
    return Appcolors.mainGreen;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Appcolors.backgroundColor,
      elevation: 2, // Adds shadow effect to make it look elevated
      margin: EdgeInsets.symmetric(vertical: 8), // Margin between cards
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Rounded corners
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            SizedBox(
              height: 40,
              width: 40,
              child: SvgPicture.asset(
                "assets/images/x.svg",
                color: Appcolors.mainGreen,
              ),
            ),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Text(
                        amount,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          "Date: $date",
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                        decoration: BoxDecoration(
                          color: getStatusBadgeColor(status).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          status,
                          style: TextStyle(
                            color: getStatusBadgeColor(status),
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
