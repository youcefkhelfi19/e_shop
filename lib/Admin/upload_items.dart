
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Admin/admin_shift_orders.dart';
import 'package:e_shop/Widgets/loading_widget.dart';
import 'package:e_shop/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';



class UploadPage extends StatefulWidget
{
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> with AutomaticKeepAliveClientMixin<UploadPage> {
  bool get wantKeepAlive => true;
  File image;
  TextEditingController _titleTextController = TextEditingController();
  TextEditingController _descriptionTextController = TextEditingController();
  TextEditingController _priceTextController = TextEditingController();
  TextEditingController _shortTextController = TextEditingController();
  String productId = DateTime.now().microsecondsSinceEpoch.toString();
  bool isUploading = false;
  @override
  Widget build(BuildContext context) {
    return image == null ? displayAdminPage() : displayAdminFormPage();
  }

  displayAdminPage() {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text('Admin',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.orange, Colors.orangeAccent],
              begin: FractionalOffset(0.0, 0.0),
              end: FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            ),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.push(context,
              MaterialPageRoute(builder: (context) => AdminShiftOrders(),),);
          },
          icon: Icon(Icons.border_color,
            color: Colors.white,

          ),
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => SplashScreen(),),);
              },
              child: Text('Logout',
                style: TextStyle(color: Colors.white),
              )
          )
        ],
      ),
      body: displayAdminPageBody(),
    );
  }

  displayAdminPageBody() {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shop_two_outlined, color: Colors.deepOrange, size: 100,),
            MaterialButton(
                elevation: 0.0,
                color: Colors.deepOrange,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Text('Add new item',
                  style: TextStyle(
                      color: Colors.white
                  ),
                ),
                onPressed: () {
                  selectPicture(context);
                })
          ],
        ),
      ),
    );
  }

  selectPicture(context) {
    showDialog(context: context, builder: (context) {
      return SimpleDialog(
        title: Text('Upload Picture'),
        children: [
          SimpleDialogOption(
            child: Text('Open Camera',
              style: TextStyle(
                  color: Colors.deepOrange,
                  fontSize: 18,
                  fontWeight: FontWeight.bold
              ),
            ),
            onPressed: () {
              takePhotoWithCamera();

            },
          ),
          SimpleDialogOption(
            child: Text('From gallery',
              style: TextStyle(
                  color: Colors.deepOrange,
                  fontSize: 18,
                  fontWeight: FontWeight.bold
              ),
            ),
            onPressed: () {
              selectPhotoFromGallery();

            },
          ),
          SimpleDialogOption(
            child: Text('Cancel',
              style: TextStyle(
                  color: Colors.deepOrange,
                  fontSize: 18,
                  fontWeight: FontWeight.bold
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      );
    });
  }

  void takePhotoWithCamera() async {
    File imageFile = await ImagePicker.pickImage(
        source: ImageSource.camera, maxHeight: 900, maxWidth: 650);
    Navigator.pop(context);

    setState(() {
      image = imageFile;
    });

  }

  void selectPhotoFromGallery() async {
    File imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    Navigator.pop(context);
    setState(() {
      image = imageFile;
    });

  }

  displayAdminFormPage() {
    return Scaffold(
      appBar:  AppBar(
        elevation: 0.0,
        title: Text('New Item',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.orange, Colors.orangeAccent],
              begin: FractionalOffset(0.0, 0.0),
              end: FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            ),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.white,),
          onPressed: (){
            clearForm();
          },
        ),
        actions: [
         TextButton(
             onPressed: (){
              isUploading ? null : saveImageProductData();
             },
             child: Text('Save',
             style: TextStyle(color: Colors.white),
             ),)
        ],
      ),
      body: ListView(
        children: [
         isUploading ? linearProgress():Text(''),
          Container(
            height: 230,
              width: MediaQuery.of(context).size.width*0.8,
            child: Center(
              child: AspectRatio(
                aspectRatio: 16/9,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: FileImage(image),
                      fit: BoxFit.fill
                    )
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10,),
          ListTile(
            leading: Icon(Icons.title,color: Colors.orange,),
            title: Container(
              width: MediaQuery.of(context).size.width*0.8,
               child: TextFormField(
                 style: TextStyle(color: Colors.deepOrange),
                 controller: _titleTextController,
                 decoration: InputDecoration(
                   border: InputBorder.none,
                   hintText: 'Product name',

                 ),
               ),

            ),
          ),
          Divider(color: Colors.orange,),
          ListTile(
            leading: Icon(Icons.perm_device_info_outlined,color: Colors.orange,),
            title: Container(
              width: MediaQuery.of(context).size.width*0.8,
              child: TextFormField(
                style: TextStyle(color: Colors.deepOrange),
                 controller:_shortTextController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Add short info',

                ),
              ),

            ),
          ),
          Divider(color: Colors.orange,),
          ListTile(
            leading: Icon(Icons.attach_money,color: Colors.orange,),
            trailing: Text('DA'),
            title: Container(
              width: MediaQuery.of(context).size.width*0.8,
              child: TextFormField(
                keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.deepOrange),
                controller: _priceTextController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Price',

                ),
              ),

            ),
          ),
          Divider(color: Colors.orange,),
          ListTile(
            leading: Icon(Icons.text_fields,color: Colors.orange,),
            title: Container(
              width: MediaQuery.of(context).size.width*0.8,
              child: TextFormField(
                style: TextStyle(color: Colors.deepOrange),
                controller: _descriptionTextController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Description',

                ),
              ),

            ),
          ),
        ],
      ),
    );
  }

  void clearForm() {
    setState(() {
      image = null ;
      _titleTextController.clear();
      _descriptionTextController.clear();
      _shortTextController.clear();
      _priceTextController.clear();
    });
  }
  saveImageProductData()async{
    setState(() {
      isUploading = true;
    });
    String imageUrl = await uploadingProductImage(image);
    saveProductInfo(imageUrl);
  }
  Future<String> uploadingProductImage(imageFile) async{
     final StorageReference reference = FirebaseStorage.instance.ref().child('Items');
     StorageUploadTask uploadTask = reference.child('product$productId.jpg').putFile(imageFile);
     StorageTaskSnapshot snapshot =await uploadTask.onComplete;
     String downloadUrl =await snapshot.ref.getDownloadURL();
     return downloadUrl;
  }
  saveProductInfo(String url)async{
    final itemReference = Firestore.instance.collection('items');
    itemReference.document(productId).setData(
      {
        'shortInfo' : _shortTextController.text.trim(),
        'longDescription' : _descriptionTextController.text.trim(),
        'price' : int.parse(_priceTextController.text),
        'publishedDate' : DateTime.now(),
        'thumbnailUrl' : url,
        'status' : 'available' ,
        'title' :_titleTextController.text.trim(),
      });
    setState(() {
      setState(() {
        isUploading = false ;
        productId = DateTime.now().microsecondsSinceEpoch.toString();
        image = null ;
        _titleTextController.clear();
        _descriptionTextController.clear();
        _shortTextController.clear();
        _priceTextController.clear();
      });
    });
  }
}