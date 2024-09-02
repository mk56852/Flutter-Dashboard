import 'package:flutter/material.dart';
import 'package:point_of_sales/Models/CardModel.dart';

class CardNotifier extends ChangeNotifier {
  List<CardModel> cards = [];
  double total = 0;

  void add(CardModel newModel) {
    cards.add(newModel);
    total += double.parse(newModel.price);
    notifyListeners();
  }

  void delete(CardModel newModel) {
    cards.remove(newModel);
    total -= double.parse(newModel.price);
    notifyListeners();
  }

  void deleteAll() {
    cards = [];
    total = 0;
    notifyListeners();
  }

  void addPrice(String price) {
    total += double.parse(price);
    notifyListeners();
  }

  void deletePrice(String price) {
    total -= double.parse(price);
    notifyListeners();
  }
}
