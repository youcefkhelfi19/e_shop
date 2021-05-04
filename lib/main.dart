import 'dart:async';
import 'package:e_shop/Config/config.dart';
import 'package:e_shop/Counters/cart_item_counter.dart';
import 'package:e_shop/Counters/item_quantity.dart';
import 'package:e_shop/Counters/total_money.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Authentication/authenication.dart';
import 'Counters/change_addresss.dart';
import 'Store/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Config.auth = FirebaseAuth.instance;
  Config.sharedPreferences = await SharedPreferences.getInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=> CartItemCounter() ),
        ChangeNotifierProvider(create: (context)=> ItemQuantity() ),
        ChangeNotifierProvider(create: (context)=> AddressChanger() ),
        ChangeNotifierProvider(create: (context)=> TotalAmount() ),
      ],
      child: MaterialApp(
          title: 'e-Shop',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Colors.orange,
          ),

          home: SplashScreen()),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 3), () async {
      if (Config.auth.currentUser() != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => AuthenticationScreen(),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => AuthenticationScreen(),
          ),
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.orange,Colors.orangeAccent],
            begin: FractionalOffset(0.0,0.0),
            end: FractionalOffset(1.0,0.0),
            stops: [0.0,1.0],
            tileMode: TileMode.clamp,
          ),

        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
              children: [
               Image.asset('images/welcome.png'),
                SizedBox(height: 20,),
                Text('Easy online shopping',
                style: TextStyle(
                  fontFamily: 'regular',
                  color: Colors.white,
                  fontSize: 25
                ),
                )
              ],
          ),
        ),
      )
    );
  }
}
