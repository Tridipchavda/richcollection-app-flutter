
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:richcollection/widgets/ProductDescriptiveView.dart';

import '../models/ProductModel.dart';

class ProductContainer extends StatelessWidget{

  String name="-",price="-",wodPrice="-",image="-",id="-";

  ProductContainer(id,name,price,wodPrice,image){
    this.id = id;
    this.name = name;
    this.price = price;
    this.wodPrice = wodPrice;
    this.image = image;

    print(id);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        (
            Container(
              // padding: EdgeInsets.only(top: 3),
              width:MediaQuery.of(context).size.width/2.3,
              clipBehavior: Clip.hardEdge,
              child: Column(
                children: [
                  Hero(
                      tag: image,
                      child: Container(
                        height: 195,
                        width: 205,
                        decoration: BoxDecoration(
                            image: DecorationImage(

                              image: NetworkImage(image,),
                              fit: BoxFit.cover,
                            )
                        ),
                      )
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10,top: 10),
                        child: name.length >= 18
                            ? Row(
                              children: [
                                Text("${name.substring(0,18)}...",style: TextStyle(fontSize: 13,fontFamily: "Quicko"),),
                                SizedBox(height: 20,)
                              ],
                            )
                            : Text("${name}",style: TextStyle(fontSize: 13,fontFamily: "Quicko"),),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10,top: 10),
                            child: Text("${price} Rs",style: TextStyle(fontSize: 14,fontFamily: "Quicko"),),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10,top: 10),
                            child: Text("${wodPrice} Rs",style: TextStyle(color: Colors.grey,fontSize: 14,fontFamily: "Quicko",decoration: TextDecoration.lineThrough),),
                          ),
                        ],
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(4),
                    child: Divider(height: 4,color: Colors.deepPurple,),
                  ),
                  InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDescriptiveView(id)));
                  },
                  child: Padding(
                      padding: EdgeInsets.only(top: 0,left: 5,right: 5,bottom: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(Icons.shopping_basket,color: Colors.deepPurple,),
                          Text("View Product",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,fontFamily: "Quicko",color: Colors.deepPurple),),

                        ],
                      )
                  ),
                  ),
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
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}