import 'package:e_shop/Widgets/custom_app_bar.dart';
import 'package:e_shop/Widgets/my_drawer.dart';
import 'package:e_shop/Models/item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:e_shop/Store/home_page.dart';


class ProductPage extends StatefulWidget {
  final ItemModel itemModel;
  ProductPage({this.itemModel});
  @override
  _ProductPageState createState() => _ProductPageState();
}



class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context)
  {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: MyAppBar(),
        drawer: MyDrawer(),
        body: ListView(
          children: [
            Container(
              padding: EdgeInsets.all(8.0),
              width: double.infinity,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Center(
                        child: Image.network(widget.itemModel.thumbnailUrl),
                      ),
                      Container(
                        color: Colors.grey,
                        child: SizedBox(
                          height: 1,
                          width: double.infinity,
                        ),
                      )
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.itemModel.title,
                              style:boldTextStyle ,
                            ),
                            Text(
                              '${widget.itemModel.price}DA',
                              style:boldTextStyle ,
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        SizedBox(
                          height: 150,
                          child: SingleChildScrollView(
                            child: Text(widget.itemModel.longDescription,
                            style: largeTextStyle,
                            ),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(top: 20),
                           child: Center(
                             child: InkWell(
                               onTap: (){

                               },
                               child: GestureDetector(
                                 onTap: (){
                                   checkItemInCart(widget.itemModel.shortInfo, context);
                                 },
                                 child: Container(
                                  width: MediaQuery.of(context).size.width-40.0,
                                   height: 50,
                                   padding: EdgeInsets.all(10),
                                   decoration: BoxDecoration(
                                     borderRadius: BorderRadius.circular(3),
                                     gradient: LinearGradient(
                                       colors: [Colors.orange,Colors.orangeAccent],
                                       begin: FractionalOffset(0.0,0.0),
                                       end: FractionalOffset(1.0,0.0),
                                       stops: [0.0,1.0],
                                       tileMode: TileMode.clamp,
                                     ),
                                   ),
                                   child: Center(
                                      child : Text(
                                         'Add To Cart',
                                         style: TextStyle(
                                             color: Colors.white,
                                             fontSize: 20.0,
                                             fontWeight: FontWeight.bold
                                         ),
                                       )
                                     ),
                                   ),
                               ),
                               ),
                             ),
                           ),

                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

}

const boldTextStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 25,color: Colors.orange);
const largeTextStyle = TextStyle(fontWeight: FontWeight.normal, fontSize: 18);
