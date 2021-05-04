import 'package:flutter/foundation.dart';

class ItemQuantity with ChangeNotifier {
  int _itemsNumber = 0;
  int get itemsNumber => _itemsNumber;
  displayNumber(int n){
    _itemsNumber = n ;
    notifyListeners();
  }
}
