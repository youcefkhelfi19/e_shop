
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Config/config.dart';
import 'package:e_shop/DialogBox/error_dialog.dart';
import 'package:e_shop/DialogBox/loading_dialog.dart';
import 'package:e_shop/Store/home_page.dart';
import 'package:e_shop/Widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}



class _RegisterState extends State<Register> {
   final TextEditingController _nameTextController = TextEditingController();
   final TextEditingController _emailTextController = TextEditingController();
   final TextEditingController _passwordTextController = TextEditingController();
   final TextEditingController _cPasswordTextController = TextEditingController();
   FirebaseAuth _auth = FirebaseAuth.instance;
   String userImageUrl ="";
   File _imageFile;
   GlobalKey<FormState> _formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    double _screenHeight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment:MainAxisAlignment.center,
          children: [
             InkWell(
               onTap: (){
                 _addProfilePicture();
               },
               child: CircleAvatar(
                 radius: _screenWidth*0.15,
                 backgroundColor: Colors.white,
                 backgroundImage: _imageFile == null ? null:FileImage(_imageFile),
                 child: _imageFile == null?
                 Icon(Icons.add_a_photo,
                 size:_screenWidth*0.15 ,
                 ):
                 null,


               ),
             ),
            SizedBox(height:20.0),
            Form(
              key: _formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      validator: (value){
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      controller: _nameTextController,
                      data: Icons.person_outline,
                      hintText: 'User name',
                    ),
                    CustomTextField(
                      validator: (value){
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      controller: _emailTextController,
                      data: Icons.email_outlined,
                      hintText: 'Email',
                    ),
                    CustomTextField(
                      validator: (value){
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      controller: _passwordTextController,
                      data: Icons.lock_open,
                      hintText: 'Password',
                      isObsecure: true,
                    ),
                    CustomTextField(

                      controller: _cPasswordTextController,
                      data: Icons.lock_open,
                      isObsecure: true,
                      hintText: 'Confirm password',
                      validator: (value){
                        if (value != _passwordTextController.text) {
                          return 'password not the same';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                   MaterialButton(
                     elevation: 0.0,
                     height: _screenHeight*0.06,
                        minWidth: _screenWidth*0.5,
                        color: Colors.deepOrange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                        ),
                        onPressed: (){
                       if(_formKey.currentState.validate()){
                         uploadToStorage();
                       }

                        },
                        child:Text('Register Now',
                         style: TextStyle(
                           color: Colors.white,
                           fontSize: 20,
                           fontWeight: FontWeight.bold
                         ),
                        ),

                    ),
                  ],
                )
            )
          ],
        ),
      ),
    );
  }

  Future<void> _addProfilePicture()async{
    File imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = imageFile;
    });
  }
  Future<void> uploadImage()async{
    if(_imageFile == null){
      showDialog(context: context,
          builder: (context)=>ErrorAlertDialog(message: 'Please select picture',));
    }else{
        _passwordTextController.text == _cPasswordTextController.text?

           uploadToStorage():
           displayDialog('Error password confirmation');

    }
  }
  displayDialog(String message){
    showDialog(
        context: context,
        builder: (context)=>ErrorAlertDialog(message: message));
  }

  uploadToStorage()async{
    showDialog(
        context: context,
        builder: (context)=>LoadingAlertDialog(message: 'Wait a second ...',));
    String imageName = DateTime.now().microsecondsSinceEpoch.toString();
    StorageReference storageReference = FirebaseStorage.instance.ref().child(imageName);
    StorageUploadTask storageUploadTask = storageReference.putFile(_imageFile);
    StorageTaskSnapshot storageTaskSnapshot = await storageUploadTask.onComplete;
    await storageTaskSnapshot.ref.getDownloadURL().then((urlImage){
      userImageUrl = urlImage;
      _registerUser();
    });
  }
  void _registerUser()async{
    FirebaseUser firebaseUser ;
    await _auth.createUserWithEmailAndPassword(
        email: _emailTextController.text.trim(), password: _passwordTextController.text.trim()).
    then((auth) => firebaseUser = auth.user
    ).catchError((error){
      Navigator.pop(context);
      displayDialog(error.message.toString());
    });
     if(firebaseUser != null){
         saveInfoToFirestore(firebaseUser).then((value){
           Navigator.pop(context);
           Navigator.pushReplacement(context, MaterialPageRoute(
               builder: (context)=>HomePage()));
         });
     }
  }
   saveInfoToFirestore(FirebaseUser fUser)async{
    Firestore.instance.collection(Config.collectionUser).document(fUser.uid).setData({
      Config.userUID: fUser.uid,
      Config.userEmail : fUser.email,
      Config.userName : _nameTextController.text.trim(),
      Config.userAvatarUrl: userImageUrl,
      Config.userCartList : ["garbageValue"]
    });
    await Config.sharedPreferences.setString(Config.userUID, fUser.uid);
    await Config.sharedPreferences.setString(Config.userEmail, fUser.email);
    await Config.sharedPreferences.setString(Config.userName, _nameTextController.text.trim());
    await Config.sharedPreferences.setString(Config.userAvatarUrl, userImageUrl);
    await Config.sharedPreferences.setStringList(Config.userCartList, ['garbageValue']);
   }
}

