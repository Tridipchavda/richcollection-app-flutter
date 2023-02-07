
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:richcollection/components/ProductContainer.dart';

class CategoricalProducts extends StatefulWidget{

  String category="-";

  CategoricalProducts(this.category);

  @override
  State<CategoricalProducts> createState() => _Categorical();
}

class _Categorical extends State<CategoricalProducts> {

  bool loadProducts = false;

  late List<dynamic> id = <String>[];
  late List<dynamic> name = <String>[];
  late List<dynamic> price = <String>[];
  late List<dynamic> wodPrice = <String>[];
  late List<dynamic> image = <String>[];

  @override
  void initState() {
    id.add("--");
    name.add("--");
    price.add("--");
    wodPrice.add("--");
    image.add("--");

    setState(() {
      loadProducts = false;
      getProducts();
    });

    super.initState();

  }

  void getProducts() async{
    await FirebaseFirestore.instance.collection('products').get().then((QuerySnapshot querySnapshot)=>{
      querySnapshot.docs.forEach((doc) {
        // print(doc['category']);

        if(doc['category'] == widget.category){
          setState((){
            id.add(doc['productKey']);
            name.add(doc['name']);
            price.add(doc['price']);
            wodPrice.add(doc['wodprice']);
            image.add(doc['image']);
          });
        }
        loadProducts = true;
      })
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,fontFamily: "Quicko"),),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 20,bottom: 10),
            child: Container(
                child: Wrap(
                  spacing: 10,
                  children: [

                    for(var i=1;i<name.length;i++)
                      ProductContainer(id[i],name[i], price[i], wodPrice[i], image[i])
                  ],
                )
              ),
          ),
        ),
      )
    );
  }

}
