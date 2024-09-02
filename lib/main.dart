import 'package:flutter/material.dart';
import 'package:point_of_sales/Layout/Layout.dart';
import 'package:point_of_sales/Screens/Dashboard/Dashbaord.dart';
import 'package:point_of_sales/Screens/POS/CardNotifier/CardNotifier.dart';
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Layout(body: Dashbaord()),
    );
  }
}
