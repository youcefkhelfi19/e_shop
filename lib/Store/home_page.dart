import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Config/config.dart';
import 'package:e_shop/Counters/cart_item_counter.dart';
import 'package:e_shop/Models/item.dart';
import 'package:e_shop/Store/cart.dart';
import 'package:e_shop/Store/product_page.dart';
import 'package:e_shop/Widgets/custom_app_bar.dart';
import 'package:e_shop/Widgets/my_drawer.dart';
import 'package:e_shop/Widgets/search_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

double width;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: MyAppBar(),
        drawer: MyDrawer(),
        body: CustomScrollView(
          slivers: [
            SliverPersistentHeader(pinned: true, delegate: SearchBoxDelegate()),
            StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance
                  .collection('items')
                  .limit(15)
                  .orderBy('publishedDate', descending: true)
                  .snapshots(),
              builder: (context, dataSnapshot) {
                return !dataSnapshot.hasData
                    ? SliverToBoxAdapter(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : SliverStaggeredGrid.countBuilder(
                        crossAxisCount: 2,
                        staggeredTileBuilder: (context) => StaggeredTile.fit(1),
                        itemCount: dataSnapshot.data.documents.length,
                        itemBuilder: (context, index) {
                          ItemModel model = ItemModel.fromJson(
                              dataSnapshot.data.documents[index].data);
                          return sourceInfo(model, context,);
                        },
                      );
              },
            )
          ],
        ),
      ),
    );
  }
}

Widget sourceInfo(ItemModel model, BuildContext context,
    {Color background, removeCartFunction}) {
  return InkWell(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProductPage(
                    itemModel: model,
                  )));
    },
    splashColor: Colors.orange,
    child: Column(
      children: [
        Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.width * 0.5,
              margin: EdgeInsets.only(right: 10, top: 10, left: 10),
              decoration: BoxDecoration(
                color: Colors.grey,
                image: DecorationImage(
                  image: NetworkImage(
                    model.thumbnailUrl,
                  ),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Positioned(
              top: 15,
              left: 15,
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    color: Colors.red, borderRadius: BorderRadius.circular(3)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '20%',
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      'OFF',
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              top: 5.0,
              right: 5.0,
              child: removeCartFunction == null
                  ? IconButton(
                      icon: Icon(
                        Icons.add_shopping_cart,
                        color: Colors.deepOrange,
                      ),
                      onPressed: () {
                        checkItemInCart(model.shortInfo, context);
                      },
                    )
                  : IconButton(
                      icon: Icon(
                      Icons.add_shopping_cart,
                      color: Colors.deepOrange,
                    ),
                     onPressed: (){

                     },
              ),
            )
          ],
        ),
        Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.only(right: 10, left: 10),
          height: MediaQuery.of(context).size.width * 0.20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    model.title,
                    style: TextStyle(
                      color: Colors.deepOrange,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    '${model.price.toString()}DA',
                    style: TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'New price',
                    style: TextStyle(
                        color: Colors.green, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${model.price * 0.8}DA',
                    style: TextStyle(
                        color: Colors.green, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Text(
                model.shortInfo,
                maxLines: 1,
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        )
      ],
    ),
  );
}

Widget card({Color primaryColor = Colors.redAccent, String imgPath}) {
  return Container();
}

void checkItemInCart(String productID, BuildContext context) {
  Config.sharedPreferences.getStringList(Config.userCartList).contains(productID)?
      Fluttertoast.showToast(msg: 'Item already Added'):
      addItemToCart(productID,context);

}

addItemToCart(String productID, BuildContext context) {
    List tempList = Config.sharedPreferences.getStringList(Config.userCartList);
    tempList.add(productID);
    Config.firestore.collection(Config.collectionUser).
    document(Config.sharedPreferences.getString(Config.userUID)).
    updateData({
      Config.userCartList : tempList
    }).then((value){
      Fluttertoast.showToast(msg: 'Item Added successfully');
      Config.sharedPreferences.setStringList(Config.userCartList,tempList);
      Provider.of<CartItemCounter>(context,listen: false).displayResult();
    });

}
