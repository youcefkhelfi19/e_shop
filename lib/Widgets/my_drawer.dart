import 'package:e_shop/Address/address.dart';
import 'package:e_shop/Authentication/authenication.dart';
import 'package:e_shop/Config/config.dart';
import 'package:e_shop/Address/add_address.dart';
import 'package:e_shop/Store/Search.dart';
import 'package:e_shop/Store/cart.dart';
import 'package:e_shop/Orders/my_orders.dart';
import 'package:e_shop/Store/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.orange,Colors.orangeAccent],
                  begin: FractionalOffset(0.0,0.0),
                  end: FractionalOffset(1.0,0.0),
                  stops: [0.0,1.0],
                  tileMode: TileMode.clamp,
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Material(
                      borderRadius: BorderRadius.circular(80),
                      child: Container(
                        height: 100,
                        width: 100,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                            Config.sharedPreferences.getString(Config.userAvatarUrl,
                            ),

                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text(
                    Config.sharedPreferences.getString(Config.userName,
                    ),
                    style: TextStyle(
                      fontSize: 35,
                      color: Colors.white,

                    ),
                  ),

                ],
              ),
            ),
            SizedBox(height: 10,),
            Container(
              decoration: BoxDecoration(

              ),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.home_outlined , color: Colors.deepOrange,),
                    title: Text('Home',style: TextStyle(color: Colors.deepOrange),),
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()),);
                    },
                  ),
                  Divider(color: Colors.deepOrange,thickness: 1,height: 2,),
                  ListTile(
                    leading: Icon(Icons.add_shopping_cart , color: Colors.deepOrange,),
                    title: Text('My Orders',style: TextStyle(color: Colors.deepOrange),),
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyOrders()),);
                    },
                  ),
                  Divider(color: Colors.deepOrange,thickness: 1,height: 2,),
                  ListTile(
                    leading: Icon(Icons.shopping_cart_outlined , color: Colors.deepOrange,),
                    title: Text('Cart',style: TextStyle(color: Colors.deepOrange),),
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>CartPage()),);
                    },
                  ),
                  Divider(color: Colors.deepOrange,thickness: 1,height: 2,),
                  ListTile(
                    leading: Icon(Icons.search, color: Colors.deepOrange,),
                    title: Text('search',style: TextStyle(color: Colors.deepOrange),),
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SearchProduct()),);
                    },
                  ),
                  Divider(color: Colors.deepOrange,thickness: 1,height: 2,),
                  ListTile(
                    leading: Icon(Icons.add_location_outlined , color: Colors.deepOrange,),
                    title: Text('Add new address',style: TextStyle(color: Colors.deepOrange),),
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AddAddress()),);
                    },
                  ),
                  Divider(color: Colors.deepOrange,thickness: 1,height: 2,),
                  ListTile(
                    leading: Icon(Icons.settings_outlined , color: Colors.deepOrange,),
                    title: Text('Settings',style: TextStyle(color: Colors.deepOrange),),
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AddAddress()),);
                    },
                  ),
                  Divider(color: Colors.deepOrange,thickness: 1,height: 2,),
                  ListTile(
                    leading: Icon(Icons.logout , color: Colors.deepOrange,),
                    title: Text('Sign out',style: TextStyle(color: Colors.deepOrange),),
                    onTap: (){
                      Config.auth.signOut().then((value){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AuthenticationScreen()));
                      });
                      
                    },
                  ),
                  Divider(color: Colors.deepOrange,thickness: 1,height: 2,),
                ],
              ),
            )
          ],
      ),
    );
  }
}
