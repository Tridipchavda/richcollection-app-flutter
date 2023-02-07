
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:richcollection/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:richcollection/widgets/DashBoard.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget{
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  var opacity = 0.4;
  bool mainLoading = true;

  String? email,gender,phone,pincode,age,city,address,name;

  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 3),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> MyHome()));
    });

    Timer(Duration(seconds: 1),(){
      setState(() {
        getPrefs();
        opacity= 1;
      });
    });
  }
  void getPrefs() async{
    setState((){
      mainLoading = true;
    });

    print(mainLoading);
    var prefs = await SharedPreferences.getInstance();

    print(prefs.getString("username"));
    if(prefs.getString("username")==null || prefs.getString("username")==""){
      print("YEs");
    }
    else{
      print("yeeeeeeesss");
      String? uname = prefs.getString("username");
      var collection = FirebaseFirestore.instance.collection("customers");
      var queryData = await collection.get();

      for(var rawData in queryData.docs){
        Map<String,dynamic> data = rawData.data();
        print(uname);
        print(data['email'].length);
        if(data['email'].compareTo(uname)==0){
          email = data['email'];
          gender = data['gender'];
          phone = data['phone'];
          pincode = data['pincode'];
          age = data['age'];
          address = data['address'];
          name = data['name'];
          city = data['city'];

        }
      }

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>DashBoard(email, phone, name, age, gender, pincode, address, city)));
    }
    setState((){
      mainLoading = false;
    });

    print(mainLoading);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: AnimatedOpacity(
      opacity: opacity,
      duration: const Duration(milliseconds: 500),
      child:Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                width:120,
                height:120,
                child: Image.asset("assets/images/logo.png")
            ),
            const Padding(
                padding: EdgeInsets.only(bottom: 40),
                child: Text("Boutique and Tailors",style: TextStyle(fontFamily: 'Pacifico',fontSize: 20,fontStyle: FontStyle.italic,color: Colors.deepPurple))
            ),
          ],
        ),
      ),
      ),
    );

  }
}