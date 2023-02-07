
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:richcollection/widgets/ProductDescriptiveView.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartContainer extends StatefulWidget{

  String productKey="",name="",wodPrice="",price="",discount="",image="";

  CartContainer(productKey,name,wodPrice,price,discount,image){
    this.productKey = productKey;
    this.name = name;
    this.wodPrice = wodPrice;
    this.price = price;
    this.discount = discount;
    this.image = image;
  }

  @override
  State<CartContainer> createState() => _CartContainerState();
}

class _CartContainerState extends State<CartContainer> {
  bool isDeleted = false;
  bool deleteOnProgress = false;

  void deleteProductFromCart() async{

    setState(() {
      deleteOnProgress = true;
    });

    var prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString("username");

    if(prefs.getString("username") !=null && prefs.getString("username") !="") {
      email = prefs.getString("username");
    }
    else{
      Fluttertoast.showToast(msg: "You need to Log In First",toastLength: Toast.LENGTH_SHORT);
      return;
    }
    print(prefs.getString("username"));

    List<dynamic> prevData=[];

    await FirebaseFirestore.instance.collection('cartData').get()
        .then((QuerySnapshot querySnapshot)=>{
          querySnapshot.docs.forEach((doc) {
          if(doc["email"]==email){
            for(var i=0;i<doc["productKey"].length;i++){
              if(doc["productKey"][i]==widget.productKey){
              }
              else{
                prevData.add(doc["productKey"][i]);
              }
            }
            print(doc["productKey"]);
          }
        }),
      }
    );
    print(prevData);

    await FirebaseFirestore.instance
        .collection("cartData")
        .doc(email)
        .update({'email': email, 'productKey': prevData});
    Fluttertoast.showToast(msg: "Product removed from Cart",toastLength: Toast.LENGTH_SHORT);
    
    setState(() {
      isDeleted = true;
      deleteOnProgress = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    return isDeleted
        ? Container()
        :
      Container(
          padding: EdgeInsets.only(top:5),
          height: 180,
          child: Stack(
            children: [
              Positioned(
                  top: 35,
                  left: 20,
                  child: Material(
                    child: Container(
                      height: 130,
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
                  top: 45,
                  left: 160,
                  width: 170,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${widget.name}",style: TextStyle(fontSize: 14,fontFamily:"Quicko",fontWeight: FontWeight.bold),),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top:10,),
                            child: Text("${widget.price} Rs",style: TextStyle(fontSize: 18,fontFamily:"Quicko",fontWeight: FontWeight.bold),),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10,left: 8),
                            child: Text("${widget.wodPrice} Rs",style: TextStyle(fontSize: 14,fontFamily:"Quicko",decoration: TextDecoration.lineThrough),),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10,left: 8),
                            child: Text("(${widget.discount} %)",style: TextStyle(fontSize: 12,fontFamily:"Quicko",fontWeight: FontWeight.bold,color: Colors.grey.shade400),),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left:8,top:10),
                            child: Container(
                              width: 80,
                              height: 30,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.deepPurple.shade300,
                                ),
                                onPressed: (){},
                                child:  Text("Buy Now",style: TextStyle(fontSize: 10,fontFamily:"Quicko",fontWeight: FontWeight.bold,),),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8,top: 10),
                            child: Container(
                              width: 70,
                              height: 30,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.purple.shade600,
                                ),
                                onPressed: (){
                                  deleteProductFromCart();
                                  },
                                child:
                                deleteOnProgress
                                    ? Container(width:14,height: 14,child: CircularProgressIndicator(color: Colors.white,strokeWidth:2,))
                                    :Text("Delete",style: TextStyle(fontSize: 10,fontFamily:"Quicko",fontWeight: FontWeight.bold,),),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  )
              ),

            ],
          ),
        );
  }
}