import 'package:flutter/material.dart';
import 'package:point_of_sales/Layout/Layout.dart';
import 'package:point_of_sales/Screens/Dashboard/Dashbaord.dart';
import 'package:point_of_sales/Screens/POS/CardNotifier/CardNotifier.dart';
import 'package:point_of_sales/Utils/AppColors.dart';

import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CardNotifier()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'roboto',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        textTheme: TextTheme(
          titleLarge: TextStyle(fontWeight: FontWeight.w700, fontSize: 19),
          titleMedium: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
          titleSmall: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
          labelLarge: TextStyle(fontSize: 17, color: Appcolors.secondTextColor),
          labelMedium:
              TextStyle(fontSize: 15, color: Appcolors.secondTextColor),
          labelSmall: TextStyle(fontSize: 13, color: Appcolors.secondTextColor),

          // You can add more text styles as needed
        ),
      ),
      home: Layout(body: Dashbaord()),
    );
  }
}
