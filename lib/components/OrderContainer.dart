
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:richcollection/widgets/ProductDescriptiveView.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderContainer extends StatefulWidget{

  String status="",name="",orderId="",price="",color="",image="",size="",paymentType="",productKey="";

  double? deliveryProgress = 0;

  OrderContainer(color,image,name,orderId,paymentType,price,productKey,size,status){
    this.status = status;
    this.name = name;
    this.color = color;
    this.price = price;
    this.size = size;
    this.paymentType = paymentType;
    this.orderId = orderId;
    this.image = image;
    this.productKey = productKey;

    if(status == "ordered"){
      deliveryProgress = 50;
    }
    if(status == "shipped"){
      deliveryProgress = 100;
    }
    if(status == "unshipped"){
      deliveryProgress = 220;
    }
    if(status == "delivered"){
      deliveryProgress = 324;
    }


  }

  @override
  State<OrderContainer> createState() => _OrderContainerState();
}

class _OrderContainerState extends State<OrderContainer> {
  bool isDeleted = false;
  bool deleteOnProgress = false;

  @override
  Widget build(BuildContext context) {

    return
    Container(
      padding: EdgeInsets.only(top:5),
      height: 180,
      child: Stack(
        children: [
          Positioned(
              top: 20,
              left: 20,
              child: Material(
                child: Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width*0.9,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(0.0),
                      boxShadow: [BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        offset: new Offset(-10, 10),
                        blurRadius: 20,
                        spreadRadius: 4,
                      ),
                      ]
                  ),
                ),
              )
          ),
          Positioned(
              top: 0,
              left: 30,
              child: Card(
                elevation: 10,
                shadowColor: Colors.grey.withOpacity(0.5),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)
                ),
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDescriptiveView(widget.productKey)));
                  },
                  child: Container(
                    height: 140,
                    width: 110,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(widget.image),
                        )
                    ),
                  ),
                ),
              )
          ),
          Positioned(
              top: 30,
              left: 160,
              width: 170,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onLongPress: () async{
                      Clipboard.setData(ClipboardData(text: widget.orderId));
                      Fluttertoast.showToast(msg: "Order Key has been copied");
                    },
                      child: Text("Order Id : ${widget.orderId.substring(0,13)}...",style: TextStyle(fontSize: 13,fontFamily:"Quicko",fontWeight: FontWeight.bold,color: Colors.grey.shade500),)
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top:10,),
                        child: Text("${widget.name}",style: TextStyle(fontSize: 12,fontFamily:"Quicko",fontWeight: FontWeight.bold),),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text("SubType : ${widget.size} ${widget.color}",style: TextStyle(fontSize: 10,fontFamily:"Quicko",fontWeight: FontWeight.bold,),),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top:15,),
                            child: Text("Status : ${widget.status}",style: TextStyle(fontSize: 12,fontFamily:"Quicko",fontWeight: FontWeight.bold,color: Colors.grey),),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Text("Payment : ${widget.price} Rs (${widget.paymentType})",style: TextStyle(fontSize: 12,fontFamily:"Quicko",fontWeight: FontWeight.bold,color: Colors.grey),),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              )
          ),
          Positioned(
              top: 168,
              left: 20,
              width: widget.deliveryProgress,
              child: LinearProgressIndicator(

                backgroundColor: Colors.purple,
              )
          ),
        ],
      ),
    );
  }
}