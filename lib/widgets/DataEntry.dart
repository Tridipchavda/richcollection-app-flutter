

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:richcollection/models/ProductModel.dart';

class DataEntry extends StatefulWidget{

  @override
  State<DataEntry> createState() => _DataEntryState();
}

class _DataEntryState extends State<DataEntry> {
  final _fromKey = GlobalKey<FormState>();
  bool load = false;

  TextEditingController category = new TextEditingController();

  TextEditingController desc =new TextEditingController();

  TextEditingController discount = new TextEditingController();

  TextEditingController image = new TextEditingController();

  TextEditingController name = new TextEditingController();

  TextEditingController popular = new TextEditingController();

  TextEditingController price = new TextEditingController();

  TextEditingController productKey = new TextEditingController();

  TextEditingController wodPrice = new TextEditingController();

  var valid = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 50),
              child: Text("Add Your Product",style: TextStyle(fontFamily: 'Quicko',color: Colors.purple,fontWeight: FontWeight.bold,fontSize: 24)),
            ),
            const SizedBox(
              width: double.infinity,
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(top:20),
              child: SizedBox(
                width: 280,
                height: 50,
                child: TextField(
                  controller: name,
                  style: TextStyle(fontFamily: 'Quicko',color: Colors.purple),
                  decoration: InputDecoration(
                      suffix: Text("  "),
                      prefixIcon: const Icon(Icons.face,color: Colors.purple),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.deepPurple,
                          )
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.purple,
                          )
                      ),
                      hintText: "Enter Product Name",
                      hintStyle: TextStyle(color: Colors.purple),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.purple,
                          )
                      )
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:20),
              child: SizedBox(
                width: 280,
                height: 50,
                child: TextField(
                  controller: desc,
                  style: TextStyle(fontFamily: 'Quicko',color: Colors.purple),
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.timeline,color: Colors.purple),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.deepPurple,
                          )
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.purple,
                          )
                      ),
                      hintText: "Enter desc",
                      hintStyle: TextStyle(color: Colors.purple),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.purple,
                          )
                      )
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:20),
              child: SizedBox(
                width: 280,
                height: 50,
                child: TextField(
                  controller: price,
                  style: TextStyle(fontFamily: 'Quicko',color: Colors.purple),
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.boy,color: Colors.purple),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.deepPurple,
                          )
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.purple,
                          )
                      ),
                      hintText: "Enter Price",
                      hintStyle: TextStyle(color: Colors.purple),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.purple,
                          )
                      )
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:20),
              child: SizedBox(
                width: 280,
                height: 50,

                child: TextField(
                  controller: wodPrice,
                  style: TextStyle(fontFamily: 'Quicko',color: Colors.deepPurple),
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.email,color: Colors.purple),
                      contentPadding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.deepPurple,
                          )
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.purple,
                          )
                      ),
                      hintText: "Enter wodPrice",
                      hintStyle: TextStyle(color: Colors.purple),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.purple,
                          )
                      )
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:20),
              child: SizedBox(
                width: 280,
                height: 50,
                child: TextField(
                  controller: category,
                  style: TextStyle(fontFamily: 'Quicko',color: Colors.purple),
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.phone,color: Colors.purple),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.deepPurple,
                          )
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.purple,
                          )
                      ),
                      hintText: "Enter category",
                      hintStyle: TextStyle(color: Colors.purple),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.purple,
                          )
                      )
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:20),
              child: SizedBox(
                width: 280,
                height: 50,
                child: TextField(
                  controller: productKey,
                  style: TextStyle(fontFamily: 'Quicko',color: Colors.purple),
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock,color: Colors.purple),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.deepPurple,
                          )
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.purple,
                          )
                      ),
                      hintText: "Enter Product Key",
                      hintStyle: TextStyle(color: Colors.purple),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.purple,
                          )
                      )
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:20),
              child: SizedBox(
                width: 280,
                height: 50,
                child: TextField(
                  controller: discount,
                  style: TextStyle(fontFamily: 'Quicko',color: Colors.purple),
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.pin,color: Colors.purple),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.deepPurple,
                          )
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.purple,
                          )
                      ),
                      hintText: "Enter Discount",
                      hintStyle: TextStyle(color: Colors.purple),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.purple,
                          )
                      )
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:20),
              child: SizedBox(
                width: 280,
                height: 50,
                child: TextField(
                  controller: popular,
                  style: TextStyle(fontFamily: 'Quicko',color: Colors.purple),
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.home_work_outlined,color: Colors.purple),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.deepPurple,
                          )
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.purple,
                          )
                      ),
                      hintText: "Enter Popularity",
                      hintStyle: TextStyle(color: Colors.purple),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.purple,
                          )
                      )
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:20),
              child: SizedBox(
                width: 280,
                height: 70,
                child: TextField(
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                  controller: image,
                  style: TextStyle(fontFamily: 'Quicko',color: Colors.purple),
                  decoration: InputDecoration(

                      prefixIcon: const Icon(Icons.local_shipping_outlined,color: Colors.purple),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.deepPurple,
                          )
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.purple,
                          )
                      ),
                      hintText: "Enter Image Link",
                      hintStyle: TextStyle(color: Colors.purple),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.purple,
                          )
                      )
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:40,top:10,right: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(" ",style: TextStyle(color: Colors.purple),),
                  InkWell(
                      onTap: (){

                      },
                      child: Text("Back to Log In",style: TextStyle(color: Colors.purple,fontSize: 14),
                      )
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:20,bottom: 300),
              child: !load ? ElevatedButton(
                onPressed: ()async {
                  // String c_category = category.text.toString();
                  // String c_desc = desc.text.toString();
                  // String c_discount = discount.text.toString();
                  // String c_image = image.text.toString();
                  // String c_name = name.text.toString();
                  // String c_popular = popular.text.toString();
                  // String c_wodPrice = wodPrice.text.toString();
                  // String c_price = price.text.toString();
                  // String c_productKey = productKey.text.toString();
                  //
                  // setState(() { load = true; });
                  FirebaseFirestore f = FirebaseFirestore.instance;

                  // final FirebaseAuth auth = FirebaseAuth.instance;
                  // final User? user = auth.currentUser;
                  // final uid = c_productKey;
                  //
                  // ProductModel product = new ProductModel();
                  //
                  // product.productKey = c_productKey;
                  // product.price = c_price;
                  // product.wodPrice = c_wodPrice;
                  // product.popular = c_popular;
                  // product.discount = c_discount;
                  // product.desc = c_desc;
                  // product.category = c_category;
                  // product.name = c_name;
                  // product.image = c_image;
                  // var sizes = ["S","M","L","XL","XXL"];
                  var colors = ["black","blue","red","white","green","yellow"];
                  // // //
                  for(var i=1;i<=40;i++){
                    await f
                            .collection("products")
                            .doc(i.toString())
                            .update({"color":colors});
                  }
                  //
                    print("Done");
                    Fluttertoast.showToast(msg: "Added Product Successfully",toastLength: Toast.LENGTH_SHORT);
                  //
                  // setState(() { load = false; });
                },
                child: const Text('Sign In',style: TextStyle(color: Colors.white,fontSize: 16),),
              ): CircularProgressIndicator(
                color: Colors.purple,
              ),
            )
          ],
        ),
      ),
    );
  }
}