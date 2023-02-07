
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:richcollection/main.dart';
import 'package:richcollection/widgets/AboutPage.dart';
import 'package:richcollection/widgets/DataEntry.dart';
import 'package:richcollection/widgets/OrderDetails.dart';
import 'package:richcollection/widgets/TheCart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'CategoryScreen.dart';

class Navbar extends StatefulWidget{

  final String? email,gender,pincode,city;

  Navbar(this.email,this.gender,this.pincode,this.city);

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {

  bool logOutDisabled = false;
  var logOutColor = Color(0xff9467d0);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.email);
    setState((){
      logOutColor = Color(0xff9467d0);
      logOutDisabled = false;
      getPrefs();
    });

  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 250,
      child: Container(
        width: 250,
        alignment: AlignmentDirectional.topStart,
        child: Column(
            children: [
              Container(
                width: double.infinity,
                color: Color(0xff9467d0),
                child: Padding(
                  padding: EdgeInsets.only(top: 40,left: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipOval(
                        child: Container(
                          child: widget.gender=="male" ?
                            Image.asset("assets/images/male_icon.png",width: 50,height: 50,)
                          :
                          Image.asset("assets/images/female_icon.png",width: 50,height: 50,),
                          decoration: BoxDecoration(boxShadow: [BoxShadow(color: Color(0xffc196de),blurRadius: 5)]),),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top:15),
                        child: Text("${widget.email==null ? "______" : widget.email}",style: TextStyle(fontFamily: "Quicko",fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white),),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top:2,bottom: 20),
                        child:  Text("${widget.pincode==null ? "______" : widget.pincode} ${widget.city==null ? "_________" : widget.city}",style: TextStyle(fontFamily: "Quicko",fontSize: 12,fontWeight: FontWeight.bold,color: Colors.white),),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 10,top: 20),
                alignment: Alignment.bottomLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                        child: widget.email != null
                            ?
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.shopping_cart,color: Color(0xff9467d0)),
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: InkWell(
                                  onTap: (){ Navigator.push(context, MaterialPageRoute(builder: (context)=>TheCart())); },
                                  child: Text("Cart",style: TextStyle(color: Color(0xff9467d0),fontFamily: "Quicko",fontWeight: FontWeight.bold),)
                              ),
                            ),
                          ],
                        )
                            :
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.shopping_cart,color: Colors.grey),
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: InkWell(
                                  onTap: (){ },
                                  child: Text("Cart",style: TextStyle(color: Colors.grey,fontFamily: "Quicko",fontWeight: FontWeight.bold),)
                              ),
                            ),
                          ],
                        )
                    ),
                    Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: widget.email != null
                            ?
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.mail_outline_sharp,color: Color(0xff9467d0)),
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: InkWell(
                                  onTap: (){ Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderDetails())); },
                                  child: Text("Orders",style: TextStyle(color: Color(0xff9467d0),fontFamily: "Quicko",fontWeight: FontWeight.bold),)
                              ),
                            ),
                          ],
                        )
                            :
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.fire_truck,color: Colors.grey),
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: InkWell(
                                  onTap: (){ },
                                  child: Text("Orders",style: TextStyle(color: Colors.grey,fontFamily: "Quicko",fontWeight: FontWeight.bold),)
                              ),
                            ),
                          ],
                        )
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.category,color: Color(0xff9467d0)),
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoryScreen()));
                                  },
                                  child: Text("Category",style: TextStyle(color: Color(0xff9467d0),fontFamily: "Quicko",fontWeight: FontWeight.bold),
                                  )
                              ),
                            ),
                          ],
                        )
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.info_outline,color: Color(0xff9467d0)),
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>AboutPage()));
                                },
                                child: Text("About",style: TextStyle(color: Color(0xff9467d0),fontFamily: "Quicko",fontWeight: FontWeight.bold),),
                              ),
                            ),
                          ],
                        )
                    ),
                    Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.logout,color: logOutColor),
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: InkWell(
                                onTap: !logOutDisabled ? () async{
                                  var prefs = await SharedPreferences.getInstance();
                                  prefs.setString("username","");

                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyHome()));
                                }: null,
                                child : Text("Log Out",style: TextStyle(color: logOutColor,fontFamily: "Quicko",fontWeight: FontWeight.bold),),
                              ),
                            ),
                          ],
                        )
                    ),
                  ],
                ),
              )
            ],

          ),
        ),

    );
  }

  void getPrefs() async{
      var prefs = await SharedPreferences.getInstance();

      if(prefs.getString("username")==null || prefs.getString("username")==""){
        setState((){
          logOutColor = Color(0xff9c9c9c);
          logOutDisabled = true;
        });
      }
  }

}