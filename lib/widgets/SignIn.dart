
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:richcollection/main.dart';
import 'package:richcollection/models/CustomerModel.dart';

class SignIn extends StatefulWidget{

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _fromKey = GlobalKey<FormState>();
  bool load = false;

  TextEditingController email = new TextEditingController();

  TextEditingController name =new TextEditingController();

  TextEditingController phone = new TextEditingController();

  TextEditingController age = new TextEditingController();

  TextEditingController address = new TextEditingController();

  TextEditingController pass = new TextEditingController();

  TextEditingController city = new TextEditingController();

  TextEditingController gender = new TextEditingController();

  TextEditingController pincode = new TextEditingController();

  var valid = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 50),
              child: Text("Register Yourself",style: TextStyle(fontFamily: 'Quicko',color: Colors.purple,fontWeight: FontWeight.bold,fontSize: 24)),
            ),
            const SizedBox(
              width: double.infinity,
              height: 10,
            ),
            Container(
              alignment: AlignmentDirectional.topStart,
              padding: const EdgeInsets.only(top:20,left: 20),
              child: Text("Personal Details",style: TextStyle(color: Colors.purple,fontFamily: "Quicko",fontSize: 14,fontWeight: FontWeight.bold),),
            ),
            Padding(
              padding: const EdgeInsets.only(top:20),
              child: SizedBox(
                width: 280,
                height: 50,
                child: TextField(
                  controller: name,
                  style: TextStyle(fontFamily: 'Quicko',color: Colors.purple),
                  decoration: InputDecoration(
                      suffix: Text("  "),
                      prefixIcon: const Icon(Icons.face,color: Colors.purple),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.deepPurple,
                          )
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.purple,
                          )
                      ),
                      hintText: "Enter Name",
                      hintStyle: TextStyle(color: Colors.purple),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.purple,
                          )
                      )
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:20),
              child: SizedBox(
                width: 280,
                height: 50,
                child: TextField(
                  controller: age,
                  style: TextStyle(fontFamily: 'Quicko',color: Colors.purple),
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.timeline,color: Colors.purple),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.deepPurple,
                          )
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.purple,
                          )
                      ),
                      hintText: "Enter Age",
                      hintStyle: TextStyle(color: Colors.purple),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.purple,
                          )
                      )
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:20),
              child: SizedBox(
                width: 280,
                height: 50,
                child: TextField(
                  controller: gender,
                  style: TextStyle(fontFamily: 'Quicko',color: Colors.purple),
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.boy,color: Colors.purple),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.deepPurple,
                          )
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.purple,
                          )
                      ),
                      hintText: "Enter Gender",
                      hintStyle: TextStyle(color: Colors.purple),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.purple,
                          )
                      )
                  ),
                ),
              ),
            ),
            Container(
              alignment: AlignmentDirectional.topStart,
              padding: const EdgeInsets.only(top:20,left: 20),
              child: Text("Authentication Details",style: TextStyle(color: Colors.purple,fontFamily: "Quicko",fontSize: 14,fontWeight: FontWeight.bold),),
            ),
            Padding(
              padding: const EdgeInsets.only(top:20),
              child: SizedBox(
                width: 280,
                height: 50,

                child: TextField(
                  controller: email,
                  style: TextStyle(fontFamily: 'Quicko',color: Colors.deepPurple),
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.email,color: Colors.purple),
                      contentPadding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.deepPurple,
                          )
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.purple,
                          )
                      ),
                      hintText: "Enter UserName",
                      hintStyle: TextStyle(color: Colors.purple),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.purple,
                          )
                      )
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:20),
              child: SizedBox(
                width: 280,
                height: 50,
                child: TextField(
                  controller: phone,
                  style: TextStyle(fontFamily: 'Quicko',color: Colors.purple),
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.phone,color: Colors.purple),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.deepPurple,
                          )
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.purple,
                          )
                      ),
                      hintText: "Enter Phone",
                      hintStyle: TextStyle(color: Colors.purple),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.purple,
                          )
                      )
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:20),
              child: SizedBox(
                width: 280,
                height: 50,
                child: TextField(
                  controller: pass,
                  style: TextStyle(fontFamily: 'Quicko',color: Colors.purple),
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock,color: Colors.purple),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.deepPurple,
                          )
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.purple,
                          )
                      ),
                      hintText: "Enter Password",
                      hintStyle: TextStyle(color: Colors.purple),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.purple,
                          )
                      )
                  ),
                ),
              ),
            ),
            Container(
              alignment: AlignmentDirectional.topStart,
              padding: const EdgeInsets.only(top:20,left: 20),
              child: Text("Shipping Details",style: TextStyle(color: Colors.purple,fontFamily: "Quicko",fontSize: 14,fontWeight: FontWeight.bold),),
            ),
            Padding(
              padding: const EdgeInsets.only(top:20),
              child: SizedBox(
                width: 280,
                height: 50,
                child: TextField(
                  controller: pincode,
                  style: TextStyle(fontFamily: 'Quicko',color: Colors.purple),
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.pin,color: Colors.purple),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.deepPurple,
                          )
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.purple,
                          )
                      ),
                      hintText: "Enter Pinode",
                      hintStyle: TextStyle(color: Colors.purple),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.purple,
                          )
                      )
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:20),
              child: SizedBox(
                width: 280,
                height: 50,
                child: TextField(
                  controller: city,
                  style: TextStyle(fontFamily: 'Quicko',color: Colors.purple),
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.home_work_outlined,color: Colors.purple),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.deepPurple,
                          )
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.purple,
                          )
                      ),
                      hintText: "Enter City",
                      hintStyle: TextStyle(color: Colors.purple),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.purple,
                          )
                      )
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:20),
              child: SizedBox(
                width: 280,
                height: 70,
                child: TextField(
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                  controller: address,
                  style: TextStyle(fontFamily: 'Quicko',color: Colors.purple),
                  decoration: InputDecoration(

                      prefixIcon: const Icon(Icons.local_shipping_outlined,color: Colors.purple),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.deepPurple,
                          )
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.purple,
                          )
                      ),
                      hintText: "Enter Address",
                      hintStyle: TextStyle(color: Colors.purple),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.purple,
                          )
                      )
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:40,top:10,right: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(" ",style: TextStyle(color: Colors.purple),),
                  InkWell(
                      onTap: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyHome()));
                      },
                      child: Text("Back to Log In",style: TextStyle(color: Colors.purple,fontSize: 14),
                      )
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:20,bottom: 30),
              child: !load ? ElevatedButton(
                onPressed: ()async {
                  String c_email = email.text.toString();
                  String c_name = name.text.toString();
                  String c_phone = phone.text.toString();
                  String c_pass = pass.text.toString();
                  String c_age = age.text.toString();
                  String c_gender = gender.text.toString();
                  String c_address = address.text.toString();
                  String c_city = city.text.toString();
                  String c_pincode = pincode.text.toString();

                    setState(() { load = true; });
                    FirebaseFirestore f = FirebaseFirestore.instance;

                    final FirebaseAuth auth = FirebaseAuth.instance;
                    final User? user = auth.currentUser;
                    final uid = user?.uid;

                    CustomerModel customer = CustomerModel();

                    customer.phone = c_phone;
                    customer.email = c_email;
                    customer.pincode = c_pincode;
                    customer.address = c_address;
                    customer.city = c_city;
                    customer.gender = c_gender;
                    customer.age = c_age;
                    customer.pass = c_pass;
                    customer.name = c_name;

                    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: c_email, password: c_pass).then((value) async{
                      await f
                          .collection("customers")
                          .doc(uid)
                          .set(customer.toMap());

                      print("Done");
                      Fluttertoast.showToast(msg: "Registration Successful",toastLength: Toast.LENGTH_SHORT);
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyHome()));

                    }).catchError((e){
                      Fluttertoast.showToast(msg: e,toastLength: Toast.LENGTH_SHORT);
                      print(e);
                    });
                  setState(() { load = false; });
                },
                child: const Text('Sign In',style: TextStyle(color: Colors.white,fontSize: 16),),
              ): CircularProgressIndicator(
               color: Colors.purple,
              ),
            )
          ],
        ),
      ),
    );
  }
}