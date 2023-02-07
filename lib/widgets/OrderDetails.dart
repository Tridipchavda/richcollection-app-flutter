
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:richcollection/components/OrderContainer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/CartContainer.dart';

class OrderDetails extends StatefulWidget{
  @override
  State<OrderDetails> createState() => _OrderDetails();
}

class _OrderDetails extends State<OrderDetails> {

  late List<String> name=[];
  late List<String> price=[];
  late List<String> status=[];
  late List<String> orderId=[];
  late List<String> productKey=[];
  late List<String> color=[];
  late List<String> size=[];
  late List<String> paymentType=[];
  late List<String> images=[];

  bool orderProductsFound = false;

  @override
  void initState() {
    setState((){
      getOrders();
    });

    super.initState();
  }
  void getOrders() async{
    setState((){
      orderProductsFound = true;
      print(orderProductsFound);
    });

    var prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString("username");


    FirebaseFirestore.instance.collection("orders").get().then((QuerySnapshot q) => {
      q.docs.forEach((doc) {

        if (doc["cId"] == email) {
          print(doc["cId"]);
          FirebaseFirestore.instance.collection("products").doc(doc["pId"]).get().then((value){
            setState(() {
              name.add(value["name"]);
              price.add(value["price"]);
              images.add(value["image"]);
              status.add(doc["status"]);
              orderId.add(doc["orderId"]);
              color.add(doc["color"]);
              size.add(doc["size"]);
              paymentType.add(doc["paymentType"]);
              productKey.add(value["productKey"]);
            });
          });

        }
      })
    }
    );
    setState((){
      orderProductsFound = false;
      print(orderProductsFound);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top:40,left: 10,bottom: 10),
                    child: InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back)
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top:40,left: 20,bottom: 10),
                    child: Text("Ordered Products",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,fontFamily: "Quicko"),),
                  ),
                ],
              ),
              orderProductsFound
                  ?
              Padding(
                padding: const EdgeInsets.only(top:300),
                child: Center(
                  child: CircularProgressIndicator(color: Colors.purple,),
                ),
              )
                  :Column(
                children: [
                  for(var i=0;i<name.length;i++)
                    OrderContainer(color[i],images[i],name[i],orderId[i],paymentType[i],price[i],productKey[i],size[i],status[i])
                ],
              )
            ],
          ),
        )
    );
  }
}