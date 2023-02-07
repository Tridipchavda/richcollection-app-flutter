import 'package:flutter/material.dart';
import 'package:richcollection/widgets/CategoricalProducts.dart';

import '../components/CategoryContainer.dart';

class CategoryScreen extends StatefulWidget{
  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {

  List<String> category = <String>["Kurti","Top","Jeans","Gaowns","Kurti Pair","Leggis","T-Shirts","Shirts"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Category"),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Column(
            children: [
              SizedBox(
                child: Text(""),
                height: 20,
              ),
              Wrap(
                    children: [
                      for(var i=0;i<category.length;i++)
                        Container(
                          child: CategoryContainer(i+1,category[i])
                        )
                    ],
                ),
            ],
          ),
        ),
      )
    );
  }
}