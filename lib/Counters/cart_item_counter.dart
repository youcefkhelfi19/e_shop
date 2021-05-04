import 'package:flutter/foundation.dart';
import 'package:e_shop/Config/config.dart';

class CartItemCounter extends ChangeNotifier{
  int _counter = 0;
  int get counter => _counter;
 Future<void> displayResult()async{
    _counter = Config.sharedPreferences.getStringList(Config.userCartList).length-1;
   await Future.delayed(const Duration(milliseconds: 100),(){
     notifyListeners();
   });
 }
}