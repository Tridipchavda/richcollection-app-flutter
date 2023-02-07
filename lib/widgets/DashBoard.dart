
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:richcollection/components/ProductContainer.dart';
import 'package:richcollection/widgets/CategoricalProducts.dart';
import 'package:richcollection/widgets/Navbar.dart';

import '../components/ProductSearch.dart';
import '../models/ProductModel.dart';

class DashBoard extends StatefulWidget{

  final String? email,phone,name,age,gender,pincode,address,city;

  const DashBoard(this.email,this.phone,this.name,this.age,this.gender,this.pincode,this.address,this.city);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {

  late List<dynamic> id = <String>[];
  late List<dynamic> allIds = [];
  late List<dynamic> searchList = <String>[];
  late List<dynamic> name = <String>[];
  late List<dynamic> price = <String>[];
  late List<dynamic> wodPrice = <String>[];
  late List<dynamic> image = <String>[];


  bool loadProducts = false;
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
        print(doc['popular']);

        searchList.add(doc['name']);
        allIds.add(doc['productKey']);

        if(doc['popular'] != "0"){
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
  final GlobalKey<ScaffoldState> sc = new GlobalKey<ScaffoldState>();

  List<String> category = <String>["Kurti","Top","Jeans","Gaowns","Kurti Pair","Leggis","T-Shirts","Shirts"];

  List<String> categoryToSend = <String>["kurti","top","jeans","gaowns","kp","leggings","tshirts","shirts"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Navbar(widget.email, widget.gender, widget.pincode, widget.city),
      body: Padding(
        padding: const EdgeInsets.only(top: 40),
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 50),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      Column(
                        children:[
                          Container(
                            height: 105,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: category.length,
                                itemBuilder: (context,int index) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 11,bottom: 11),
                                child: SizedBox(
                                    width: 90,
                                    child: Column(
                                      children: [
                                        InkWell(
                                          onTap: (){
                                            print("---${categoryToSend[index]}");
                                            Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoricalProducts(categoryToSend[index])));
                                          },
                                          child: CircleAvatar(
                                            backgroundColor: Color(0xffacafe8),
                                            radius: 30,
                                            child: Image.asset("assets/images/cat_${index+1}.png"),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top:5),
                                          child: Text("${category[index]}",style: TextStyle(color: Color(0xffa215ad)),),
                                        ),
                                      ],
                                    )
                                ),
                              );
                            }
                            ),
                          ),
                          Container(
                            height: 250,
                            color: Color(0xffe5dee7),

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 15,top: 10,bottom: 10),
                                  child: Text("Sales and Events",style: TextStyle(fontSize: 20,fontFamily:"Quicko",color: Colors.purple.shade800,fontWeight: FontWeight.bold),),
                                ),
                                CarouselSlider.builder(
                                    itemCount: category.length,
                                    itemBuilder: (context,i,pi){
                                      return Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          boxShadow: [BoxShadow(spreadRadius:0)],
                                        ),
                                        child: Center(
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(5),
                                            child: Image.asset("assets/images/sale_1.png",fit: BoxFit.cover,width: 1100),
                                          )
                                        ),
                                      );
                                    }, options: CarouselOptions(
                                        autoPlay: true,
                                        aspectRatio: 2,
                                        enlargeCenterPage: true,
                                      )),
                              ],
                            ),
                          ),
                        ]
                      ),
                      Container(
                        alignment: AlignmentDirectional.topStart,
                        padding: const EdgeInsets.only(top: 10,left: 10,bottom: 20),
                        child: Text("Popular Products",style: TextStyle(fontSize: 24,fontFamily: "Quicko"),),
                      ),

                      Wrap(
                        spacing: 8,
                        children: [
                          for(var i=1;i<name.length;i++)
                            ProductContainer(id[i],name[i], price[i], wodPrice[i], image[i])

                        ],
                      ),
                    ],
                  )
                ),
              ),
              Container(
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Builder(
                        builder: (context) {
                          return IconButton(
                            icon: Icon(Icons.menu,color:Colors.purple),
                            onPressed: () async {
                              Scaffold.of(context).openDrawer();
                            },

                          );
                        }
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right:8.0),
                          child: Image.asset("assets/images/logo.png",width: 30,height: 30,),
                        ),
                        Text("Rich Collection",style: TextStyle(fontFamily:"Pacifico",color:Colors.deepPurple),),
                      ],
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      padding: EdgeInsets.all(5),
                      child: IconButton(
                        icon: Icon(Icons.search,color:Colors.purple),
                        onPressed: () {
                          showSearch(
                              context: context,
                              delegate: ProductSearch(searchList,allIds)
                          );
                        },
                      )

                    )
                  ],
                ),
              ),
            ],
          ),
        ),
    );
  }
}