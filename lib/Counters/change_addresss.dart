
import 'package:flutter/foundation.dart';

class AddressChanger extends ChangeNotifier{
  int _count = 0 ;
  int get count => _count ;
  displayResult(int n){
    _count = n ;
    notifyListeners();
  }
}