
import 'package:e_shop/Counters/cart_item_counter.dart';
import 'package:e_shop/Store/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyAppBar extends StatelessWidget with PreferredSizeWidget
{
  final PreferredSizeWidget bottom;
  MyAppBar({this.bottom});


  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      title: Text('E-Shop',
        style: TextStyle(
            fontSize: 30,
            color: Colors.white,
            fontFamily: 'regular'
        ),
      ),
      centerTitle: true,
      actions: [
        Stack(
          children: [
            IconButton(
                icon: Icon(Icons.shopping_cart_outlined,
                  color: Colors.deepOrange,
                ),
                onPressed:(){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>CartPage()),);

                }),
            Positioned(
                child:Stack(
                  children: [
                    Icon(
                      Icons.brightness_1,
                      size: 20,
                      color: Colors.red,
                    ),
                    Positioned(
                      top: 2,

                      left: 5.0,
                      child:Consumer<CartItemCounter>(
                        builder: (context, counter , _){
                          return Text(
                            counter.counter.toString(),
                            style: TextStyle(
                                color: Colors.white
                            ),
                          );
                        },
                      ),
                    )
                  ],
                )
            )
          ],
        )
      ],
      iconTheme: IconThemeData(
        color: Colors.white,

      ),
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
    );
  }


  Size get preferredSize => bottom==null?Size(56,AppBar().preferredSize.height):Size(56, 80+AppBar().preferredSize.height);
}
