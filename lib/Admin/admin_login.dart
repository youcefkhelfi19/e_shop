import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Admin/upload_items.dart';
import 'package:e_shop/DialogBox/error_dialog.dart';
import 'package:e_shop/Widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class AdminSignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
      ),
      body: AdminSignInScreen(),
    );
  }
}

class AdminSignInScreen extends StatefulWidget {
  @override
  _AdminSignInScreenState createState() => _AdminSignInScreenState();
}

class _AdminSignInScreenState extends State<AdminSignInScreen> {
  final TextEditingController _idTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    double _screenHeight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Container(
        child: Form(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                alignment: Alignment.bottomCenter,
                child: Image.asset(
                  'images/admin.png',
                  height: 240.0,
                  width: 240.0,
                ),
              ),
              CustomTextField(
                controller: _idTextController,
                data: Icons.account_box_outlined,
                hintText: 'Admin Id',
              ),
              CustomTextField(
                controller: _passwordTextController,
                data: Icons.lock_open,
                hintText: 'Admin Password',
                isObsecure: true,
              ),
              SizedBox(
                height: 20.0,
              ),
              MaterialButton(
                elevation: 0.0,
                height: _screenHeight * 0.06,
                minWidth: _screenWidth * 0.5,
                color: Colors.deepOrange,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                onPressed: () {
                  _idTextController.text.isNotEmpty &&
                          _passwordTextController.text.isNotEmpty
                      ? loginAdmin()
                      : displayDialog('Please type your email and password');
                },
                child: Text(
                  'Login',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  displayDialog(String message) {
    showDialog(
        context: context,
        builder: (context) => ErrorAlertDialog(message: message));
  }

  loginAdmin() async {
    Firestore.instance.collection('admins').getDocuments().then((snapshot) {
      snapshot.documents.forEach((result) {
        if (result.data['id'] != _idTextController.text.trim() &&
            result.data['password'] != _passwordTextController.text.trim()) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text('Incorrect id or password',style: TextStyle(color: Colors.white),),
          ));
        }else{
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.orange,
              content: Text('Welcome ${result.data['name']}',style: TextStyle(color: Colors.white),),),);
          setState(() {
            _passwordTextController.text = "";
            _idTextController.text =  "";
          });
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>UploadPage()),);
        }
      });
    });
  }
}
