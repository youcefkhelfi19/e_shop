import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


circularProgress() {
  return Center(
    child: Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(top:12.0),
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(
          Colors.orange
        ),
      ),
    ),
  );
}

linearProgress() {
  return Center(
    child: Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(top:12.0),
      child: LinearProgressIndicator(
        valueColor: AlwaysStoppedAnimation(
            Colors.orange
        ),
      ),
    ),
  );

}
