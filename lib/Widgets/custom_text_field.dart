import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget
{
  final TextEditingController controller;
  final IconData data;
  final String hintText;
   final bool isObsecure;
  final Function validator;


  CustomTextField(
      {Key key, this.controller,this.validator, this.data, this.hintText,this.isObsecure = false}
      ) : super(key: key);



  @override
  Widget build(BuildContext context)
  {
    return Container(
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: TextFormField(
        validator: validator,
        controller: controller,
        obscureText: isObsecure,
        cursorColor: Theme.of(context).primaryColor,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
          prefixIcon: Icon(data,
          color:Theme.of(context).primaryColor ,
          ),
          focusColor: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
