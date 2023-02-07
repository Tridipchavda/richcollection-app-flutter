

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:richcollection/widgets/CategoricalProducts.dart';
import 'package:richcollection/widgets/ProductDescriptiveView.dart';

import '../models/ProductModel.dart';

class CategoryContainer extends StatelessWidget{

  String name="-";
  int counter=0;

  List<String> categoryToSend = <String>["kurti","top","jeans","gaowns","kp","leggings","tshirts","shirts"];

  CategoryContainer(counter,name){

    this.name = name;
    this.counter = counter;

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoricalProducts(categoryToSend[counter-1])));
            },
            child: (
                Container(
                  padding: EdgeInsets.only(top: 3),
                  width:MediaQuery.of(context).size.width/3.5,
                  clipBehavior: Clip.hardEdge,
                  child: Column(
                    children: [
                      SizedBox(
                        child: Container(),
                        height: 5,
                      ),
                      Hero(
                          tag: "assets/images/cat_${counter}.png",
                          child: Container(
                            height: 100,
                            width: 140,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/images/cat_${counter}.png"),
                                  fit: BoxFit.contain,
                                )
                            ),
                          )
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom:3,top: 10),
                            child: Text("${name}",style: TextStyle(fontSize: 13,fontFamily: "Quicko"),),

                            )
                        ]
                      )
                    ],
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 3.0,
                        blurRadius: 2,
                      )]
                  ),
                )
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}