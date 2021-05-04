
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Admin/admin_login.dart';
import 'package:e_shop/Config/config.dart';
import 'package:e_shop/DialogBox/error_dialog.dart';
import 'package:e_shop/DialogBox/loading_dialog.dart';
import 'package:e_shop/Store/home_page.dart';
import 'package:e_shop/Widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}





class _LoginState extends State<Login> {
  final TextEditingController _emailTextController = TextEditingController();
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
                child: Image.asset('images/login.png',
                height: 240.0,
                width: 240.0,
                ),
              ),
              CustomTextField(
                controller: _emailTextController,
                data: Icons.email_outlined,
                hintText: 'Email',
              ),
              CustomTextField(
                controller: _passwordTextController,
                data: Icons.lock_open,
                hintText: 'Password',
                isObsecure: true,
              ),
              SizedBox(height: 20.0,),
              MaterialButton(
                elevation: 0.0,
                height: _screenHeight*0.06,
                minWidth: _screenWidth*0.5,
                color: Colors.deepOrange,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                ),
                onPressed: (){
                   _emailTextController.text.isNotEmpty &&
                  _passwordTextController.text.isNotEmpty?
                       loginUser():
                       displayDialog('Please type your email and password');
                       
                },
                child:Text('Login',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),
                ),

              ),
              SizedBox(height: 20.0,),
              TextButton.icon(
                  onPressed:(){
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context)=>AdminSignInPage()
                      ));
                  },
                 icon: Icon(Icons.nature_people_outlined,
                 color: Colors.white,
                 ),
                label: Text('Admin',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16
                ),
                ),
                 ),
            ],
          ),
        ),
      ),
    );
  }
  displayDialog(String message){
    showDialog(
        context: context,
        builder: (context)=>ErrorAlertDialog(message: message));
  }
  FirebaseAuth _auth = FirebaseAuth.instance;
  loginUser() async{
    showDialog(
        context: context,
        builder: (context){
          return LoadingAlertDialog(message: 'loggin in..  ' ,);
        });
    FirebaseUser firebaseUser;
    await _auth.signInWithEmailAndPassword(email: _emailTextController.text.trim(),
        password: _passwordTextController.text.trim()).then((auth) => firebaseUser = auth.user)
        .catchError((error){
          Navigator.pop(context);
          displayDialog(error.message.toString());
    });
   if(firebaseUser != null){
     readData(firebaseUser).then((value){
       Navigator.pop(context);
       Navigator.pushReplacement(context, MaterialPageRoute(
         builder: (context)=>HomePage()
       ));
     });
   }
  }

  Future readData(FirebaseUser user) async{
       Firestore.instance.collection(Config.collectionUser).document(user.uid).get().then((dataSnapshot)async{
         await Config.sharedPreferences.setString(Config.userUID, dataSnapshot.data[Config.userUID]);
         await Config.sharedPreferences.setString(Config.userEmail, dataSnapshot.data[Config.userEmail]);
         await Config.sharedPreferences.setString(Config.userName, dataSnapshot.data[Config.userName]);
         await Config.sharedPreferences.setString(Config.userAvatarUrl, dataSnapshot.data[Config.userAvatarUrl]);
         List<String> cartItems =dataSnapshot.data[Config.userCartList].cast<String>();
         await Config.sharedPreferences.setStringList(Config.userCartList,cartItems);
       });
  }
}
