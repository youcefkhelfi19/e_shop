import 'package:e_shop/Authentication/login.dart';
import 'package:e_shop/Authentication/register.dart';
import 'package:flutter/material.dart';
class AuthenticationScreen extends StatefulWidget {
  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.orange,Colors.orangeAccent],
                begin: FractionalOffset(0.0,0.0),
                end: FractionalOffset(1.0,0.0),
                stops: [0.0,1.0],
                tileMode: TileMode.clamp,
              ),
            ),
          ),
          title: Text('E-Shop',
          style: TextStyle(
            fontSize: 30,
            color: Colors.white,
            fontFamily: 'regular'
          ),
          ),
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.lock,color: Colors.white,),
                text: 'Login',
              ),
              Tab(
                icon: Icon(Icons.perm_contact_calendar,color: Colors.white,),
                text: 'Register',
              ),
            ],
            indicatorColor:Colors.deepOrange ,
            indicatorWeight: 5.0,
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.orange,Colors.orangeAccent],
              begin: FractionalOffset(0.0,0.0),
              end: FractionalOffset(1.0,0.0),
              stops: [0.0,1.0],
              tileMode: TileMode.clamp,
            ),

          ),
          child: TabBarView(
            children: [
              Login(),
              Register()
            ],
          ),
        ),
      ),
    );
  }
}
