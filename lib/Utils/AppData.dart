import 'package:point_of_sales/Screens/Dashboard/Widgets/TransactionsHistory.dart';

class AppData {
  static List<dynamic> userTableColumns = [
    {"name": "id", "isNumeric": true},
    {"name": "name", "isNumeric": false},
    {"name": "age", "isNumeric": true},
    {"name": "profession", "isNumeric": false},
    {"name": "role", "isNumeric": false},
  ];

  static List<HistoryItem> histData = [
    HistoryItem(
      title: "Transaction #089653",
      date: "07/07/2024",
      amount: "45 DT",
    ),
    HistoryItem(
      title: "Transaction #1458963",
      date: "17/07/2024",
      amount: "25 DT",
    ),
    HistoryItem(
      title: "Transaction #0147653",
      date: "06/07/2024",
      amount: "42 DT",
    ),
    HistoryItem(
      title: "Transaction #0147653",
      date: "06/07/2024",
      amount: "42 DT",
    ),
  ];
}
