import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Store/Search.dart';

class SearchBoxDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
          BuildContext context, double shrinkOffset, bool overlapsContent) =>
      InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchProduct(),));
        },
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
        alignment: Alignment.center,
          height: 80.0,
          width: MediaQuery.of(context).size.width,
          child: InkWell(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              //width: MediaQuery.of(context).size.width*0.95,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  SizedBox(width: 10,),
                  Icon(Icons.search_outlined,color: Colors.deepOrange,),
                  Text('Search from here ...',
                  style: TextStyle(color: Colors.orange),
                  )
                ],
              ),
            ),
          ),
        ),
      );

  @override
  double get maxExtent => 80;

  @override
  double get minExtent => 80;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
