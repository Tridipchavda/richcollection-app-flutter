
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';


class AboutPage extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About Us"),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
                Padding(
                  padding: EdgeInsets.only(top:18),
                  child: CarouselSlider.builder(
                    itemCount: 3,
                    itemBuilder: (context,i,pi){
                      return Container(

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          boxShadow: [BoxShadow(spreadRadius:0)],
                        ),
                        child: Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(2),
                              child: Image.asset("assets/images/img${i+1}.jpg",fit: BoxFit.cover,width: 900,height: 300,),
                            )
                        ),
                      );
                    }, options: CarouselOptions(
                  autoPlay: true,
                  aspectRatio: 1.5,
                  enlargeCenterPage: true,
                )
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left:18,top:18),
                      child: Text("Rich Collection is a collection of Various Different style of "+
                          "Ladies ware diversifing designs for our customers .",
                        style: TextStyle(fontFamily: "Quicko",fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left:18,top:18),
                      child: Text("Address : Rich Collection, 13, Ishwar Icon Residency, Nr. Krishna Haveli, Nikol, Ahmedabad",
                        style: TextStyle(fontFamily: "Quicko",fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left:18,top:18),
                      child: Text("Our Contacts : +91 99999 99999 , +91 99999 99999",
                        style: TextStyle(fontFamily: "Quicko",fontSize: 14),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left:18,top:18),
                      child: Text("Mail : richcollection7890@gmail.com",
                        style: TextStyle(fontFamily: "Quicko",fontSize: 14),
                      ),
                    ),
                  ],
                )



          ],
        ),
      ),
    );
  }

}