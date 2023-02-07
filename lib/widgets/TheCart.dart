
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/CartContainer.dart';

class TheCart extends StatefulWidget{
  @override
  State<TheCart> createState() => _TheCartState();
}

class _TheCartState extends State<TheCart> {

  late List<String> name=[];
  late List<String> wodPrice=[];
  late List<String> price=[];
  late List<String> image=[];
  late List<String> discount=[];
  late List<String> productKey=[];

  bool cartProductsFound = false;

  @override
  void initState() {
    setState((){

      getCartProducts();
    });

    super.initState();
  }
  void getCartProducts() async{
    cartProductsFound = true;
    print(cartProductsFound);

    var prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString("username");

    List<dynamic> allKey = [];

    FirebaseFirestore.instance.collection("cartData").get().then((QuerySnapshot q) => {
        q.docs.forEach((doc) {
          if (doc["email"] == email) {
            for (var i = 0; i < doc["productKey"].length; i++) {
              print(doc["productKey"][i]);
              allKey.add(doc["productKey"][i]);
            }
            FirebaseFirestore.instance.collection('products').get().then((
                QuerySnapshot querySnapshot) =>
            {
              querySnapshot.docs.forEach((doc) {
                if(allKey.contains(doc["productKey"])){
                  print(doc["productKey"]);
                  setState((){
                    name.add(doc["name"]);
                    price.add(doc["price"]);
                    wodPrice.add(doc["wodprice"]);
                    productKey.add(doc["productKey"]);
                    image.add(doc["image"]);
                    discount.add(doc["discount"]);
                  });

                }
              })
            });
          }
        })
    }
    );
    cartProductsFound = false;
    print(cartProductsFound);
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
                  child: Text("Cart Products",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,fontFamily: "Quicko"),),
                ),
              ],
            ),
            cartProductsFound
                ?
                Padding(
                  padding: const EdgeInsets.only(top:300),
                  child: Center(
                    child: CircularProgressIndicator(color: Colors.purple,),
                  ),
                )
                :Column(
                  children: [
                    for(var i=0;i<productKey.length;i++)
                      CartContainer(productKey[i],name[i],wodPrice[i],price[i],discount[i],image[i]),
                  ],
                 )
            ],
        ),
      )
    );
  }
}