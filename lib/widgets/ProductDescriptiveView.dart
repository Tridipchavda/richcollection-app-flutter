
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:crypto/crypto.dart';

class ProductDescriptiveView extends StatefulWidget{

  String id="-";

  ProductDescriptiveView(id){
    this.id = id;
  }
  @override
  State<ProductDescriptiveView> createState() => _ProductDescriptiveView();
}
class _ProductDescriptiveView extends State<ProductDescriptiveView>{

  bool loading = false;
  late String category;
  late String desc;
  late String discount;
  late String image;
  late String name;
  late String popular;
  late String price;
  late String productKey;
  late String wodPrice;
  late List<dynamic> sizes = [];
  late List<dynamic> colors = [];

  String selectedColor = "";
  String selectedSize = "";
  var colorIndex = 0;
  var sizeIndex = 0;
  bool addedAlready = false;
  bool addingProductToCart = false;
  bool purchasingProcess = false;

  String? email = "";
  Map<String,dynamic> hexOf = {"black":0xffffffff,"blue":0xff0000ff,"red":0xffff1111,"green":0xff00ef55,"white":0xff000000,"yellow":0xffFFD300};

  @override
  void initState() {
    setState((){
      hexOf = {"black":0xff000000,"blue":0xff0000ff,"red":0xffff1111,"green":0xff00ef55,"white":0xffffffff,"yellow":0xffFFD300};

      getProducts();
    });
    super.initState();
  }

  void addToCart() async{

    FirebaseFirestore f = FirebaseFirestore.instance;
    var prefs = await SharedPreferences.getInstance();


    if(prefs.getString("username") !=null && prefs.getString("username") !="") {
      email = prefs.getString("username");
      setState((){ addingProductToCart=true; });
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
                  prevData = doc["productKey"];
                  print(doc["productKey"]);
              }
            }),
    }
    );
    prevData.add(productKey);

    await f
        .collection("cartData")
        .doc(email)
        .set({'email': email, 'productKey': prevData});

    setState((){ addingProductToCart=false; });
    setState((){ addedAlready=true; });
    Fluttertoast.showToast(msg: "Product Added to Cart Successfully",toastLength: Toast.LENGTH_SHORT);
  }
  void getProducts() async {
    image = "https://i.ibb.co/LvBBV6H/IMG-20230125-124847.png";
    category = "";
    wodPrice = "";
    price = "";
    name = "";
    discount = "";
    desc = "";
    popular = "";
    productKey = "";
    loading = false;

    var prefs = await SharedPreferences.getInstance();
    FirebaseFirestore.instance.collection('products').get().then((
        QuerySnapshot querySnapshot) =>
    {
      querySnapshot.docs.forEach((doc) {
        if (doc['productKey'] == widget.id) {
          setState(() {
            if(prefs.getString("username") !=null) {
              email = prefs.getString("username");
            }

            FirebaseFirestore.instance.collection('cartData').get()
                .then((QuerySnapshot querySnapshot)=>{
              querySnapshot.docs.forEach((doc) {
                print(doc["email"]);
                if(doc["email"]==email) {
                  print(doc["productKey"].length);
                  for (var i = 0; i < doc["productKey"].length; i++) {
                    print(doc["productKey"][i]);
                    if(doc["productKey"][i]==productKey) {
                      setState(() {
                        addedAlready = true;
                      });
                    }
                  };
                }
              })
            }
            );

            image = doc['image'];
            category = doc['category'];
            wodPrice = doc['wodprice'] + " Rs";
            price = doc['price'] + " Rs";
            name = doc['name'];
            discount = "(" + doc['discount'] + " % off)";
            colors = doc['color'];
            sizes = doc['size'];
            desc = doc['desc'];
            popular = doc['popular'];
            productKey = doc['productKey'];

            loading = true;
          });
        }
      })
    });
  }

  void showAlert(currStock,key){

    setState(() {
      purchasingProcess=true;
    });

    QuickAlert.show(
      context: context,
      type: QuickAlertType.confirm,
      title: "Confirm Your Purchase",
      widget: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text("Product : ${name} ",style:TextStyle(fontFamily:"Quicko")),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text("Size : ${sizes[sizeIndex]} ",style:TextStyle(fontFamily:"Quicko")),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text("Color : ${colors[colorIndex]} ",style:TextStyle(fontFamily:"Quicko")),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text("Price To Pay :${price} ",style:TextStyle(fontFamily:"Quicko")),
            ),
          ],
        ),
      ),
      // text: "Product :${name} \n Size :${sizes[sizeIndex]} \n Color :${colors[colorIndex]} \n Price To Pay :${price} \n",
      confirmBtnText : "Proceed",
      onCancelBtnTap:(){
        setState(() {
          purchasingProcess=false;
        });
        Navigator.of(context).pop();
      },
      onConfirmBtnTap: ()async{

        String updatedStock = currStock.toString();
        await FirebaseFirestore.instance
            .collection("stock")
            .doc(key)
            .update({'productKey':productKey,'color':colors[colorIndex],'size':sizes[sizeIndex],'stock' : updatedStock});

        var bytes = utf8.encode(email! + DateTime.now().microsecondsSinceEpoch.toString() + key);
        var orderId = md5.convert(bytes);

        print(orderId);

        await FirebaseFirestore.instance
            .collection("orders")
            .doc('${orderId}')
            .set(
            {'orderId':'${orderId}','cId':email,'pId':productKey,'paymentType':'COD','status':'ordered','deliveryTime':'72','size':sizes[sizeIndex],'color':colors[colorIndex]}
        );

        Navigator.of(context).pop();
        Fluttertoast.showToast(msg: "Ordered Has Been Placed",toastLength: Toast.LENGTH_SHORT);
        setState(() {
          purchasingProcess=false;
        });
      }
    );
  }
  void buyingProduct() async{

    var prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString("username");
    String key = productKey + sizeIndex.toString() + colorIndex.toString();

    if(email==null || email==""){
      Fluttertoast.showToast(msg: "Please Log In for Shopping",toastLength: Toast.LENGTH_SHORT);
      return;
    }
    FirebaseFirestore.instance.collection("stock").doc(key).get().then((value) async{
      print(value["productKey"]);
      print(value["stock"]);

      int currStock = int.parse(value["stock"]);
      if( currStock != 0){
          currStock = currStock - 1;
          showAlert(currStock,key);

      }else{
        Fluttertoast.showToast(msg: "Product is out of Stock",toastLength: Toast.LENGTH_SHORT);
      }
    });

  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        width: 40,
        height: 40,
        child: FloatingActionButton(
          onPressed: () {
            setState((){addedAlready=false;});
            Navigator.pop(context);
          },
          backgroundColor: Colors.purple.shade200,
          child: Container(
              child: Icon(Icons.arrow_back_rounded)
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,

      body: !loading
          ? Padding(
        padding: const EdgeInsets.only(top:30),
        child: Center(
            child: CircularProgressIndicator( color:Colors.purple.shade300),
        ),
      )
          :
          Padding(
        padding: const EdgeInsets.only(top:27),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Image.network(
                        image,
                        fit: BoxFit.cover,
                        loadingBuilder: (context,child,lp){
                          if(lp==null) return child;
                          return Center(
                            child: CircularProgressIndicator(color: Colors.purple,),
                          );
                        },
                      ),
                      Padding(
                          padding: EdgeInsets.only(top: 20,left: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 250,
                                child: Wrap(
                                    children:[ Text(name,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,fontFamily: "Quicko"),) ]
                                ),
                              ),
                              popular!="0"
                                  ? Padding(
                                      padding: const EdgeInsets.only(right: 20),
                                      child: Icon(Icons.favorite_rounded,color: Colors.purple.shade200,),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.only(right: 20),
                                      child: Text(""),
                                    )
                            ],
                          ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 2,left: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10,top: 10),
                                child: Text("${price}",style: TextStyle(fontSize: 20,fontFamily: "Quicko"),),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10,top: 10),
                                child: Text("${wodPrice}",style: TextStyle(color: Colors.grey,fontSize: 16,fontFamily: "Quicko",decoration: TextDecoration.lineThrough),),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10,top: 10),
                                child: Text("${discount}",style: TextStyle(fontSize: 14,fontFamily: "Quicko"),),
                              ),
                            ],
                          )
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10,left: 20,bottom: 10),
                        child: Wrap(
                          children: [
                            Text(desc,style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,fontFamily: "Quicko"),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 2,left: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Text("Select Colour",style: TextStyle(fontFamily: "Quicko",fontSize: 14)),
                            Row(
                              children: [
                                for(var i=0;i<colors.length;i++)
                                  Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: InkWell(
                                      onTap: (){
                                        setState(() {
                                          selectedColor = colors[i];
                                          colorIndex = i;
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(20)),
                                          border: Border.all(color: Colors.deepPurple.shade100,width: 2),
                                        ),
                                        child: colorIndex==i
                                            ? CircleAvatar(
                                                radius: 12,
                                                backgroundColor: Color(hexOf[colors[i]]),
                                                child: Icon(Icons.check,color: Colors.grey,),
                                              )
                                              : CircleAvatar(
                                                  radius: 12,
                                                  backgroundColor: Color(hexOf[colors[i]]),
                                              )
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.only(top: 2,left: 20,bottom: 40),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Select Size",style: TextStyle(fontFamily: "Quicko",fontSize: 14)),
                            Row(
                              children: [

                                for(var i=0;i<sizes.length;i++)
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10,top: 10),
                                    child: InkWell(
                                      onTap: (){
                                        setState(() {
                                          selectedSize = colors[i];
                                          sizeIndex = i;
                                        });
                                      },
                                      child: sizeIndex!=i
                                          ? Container(
                                              padding: const EdgeInsets.only(top: 6,bottom: 6,left: 8,right: 8),
                                              decoration: BoxDecoration(
                                                border: Border.all(color: Colors.grey.shade400,width: 2),
                                              ),
                                              child: Text("${sizes[i]}",style: TextStyle(fontFamily: "Quicko",fontSize: 10)),
                                            )
                                          : Container(
                                              padding: const EdgeInsets.only(top: 6,bottom: 6,left: 8,right: 8),
                                              decoration: BoxDecoration(
                                                color: Colors.deepPurple.shade300,
                                                border: Border.all(color: Colors.grey.shade300,width: 2),
                                              ),
                                              child: Text("${sizes[i]}",style: TextStyle(color: Colors.white,fontFamily: "Quicko",fontSize: 10,fontWeight: FontWeight.bold)),
                                            )
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(

                    boxShadow: [BoxShadow(spreadRadius: 0.2,blurRadius: 30,offset: Offset(2,20),color: Colors.purple.shade200),],
                  ),
                  width: double.infinity,
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      !addingProductToCart ?
                      Expanded(
                        child: !addedAlready
                            ?
                        Padding(
                            padding: const EdgeInsets.only(),
                            child: Container(
                              height: 50,
                              child: Container(
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                    ),
                                    onPressed: (){
                                      setState((){
                                        addToCart();
                                      });
                                    },
                                    child: Text('Add To Cart',style: TextStyle(fontSize: 16,color: Colors.purple.shade200),)
                                )

                              )
                            ),
                          )
                        :
                        Padding(
                          padding: const EdgeInsets.only(),
                          child: Container(
                            height: 50,
                            child: Container(
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                  ),
                                  onPressed: (){
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left:0.0),
                                        child: Icon(Icons.check,color: Colors.grey.shade400,),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left:8.0),
                                        child: Text("Added",style: TextStyle(color:Colors.grey.shade400,),),
                                      ),
                                    ],
                                  )
                              ),
                            ),
                          ),
                        )
                      )
                      : Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(),
                          child: Container(
                            height: 50,
                            child: Container(
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                  ),
                                  onPressed: (){

                                  },
                                  child: Container(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(color: Colors.purple.shade200,)
                                  ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                            padding: const EdgeInsets.only(),
                            child: Container(
                              height: 50,
                              child: Container(
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                    ),
                                    onPressed: (){
                                      setState((){
                                        buyingProduct();
                                      });

                                    },
                                    child: !purchasingProcess
                                        ?
                                        Text('Buy Now',style: TextStyle(fontSize: 16,color: Colors.purple.shade200),)
                                        :
                                        Container(
                                          width: 20,
                                          height: 20,
                                          child: CircularProgressIndicator(color: Colors.purple.shade200,)
                                        ),
                                ),
                              ),
                            ),
                          ),
                      ),

                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

}