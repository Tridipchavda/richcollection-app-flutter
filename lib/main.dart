import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:richcollection/widgets/DashBoard.dart';
import 'package:richcollection/widgets/Navbar.dart';
import 'package:richcollection/widgets/SignIn.dart';
import 'package:richcollection/widgets/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rich Collection',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: SplashScreen(),
    );
  }
}
class MyHome extends StatefulWidget{
  const MyHome({super.key});

  @override
  MyHomePage createState()=> MyHomePage();

}
class MyHomePage extends State<MyHome> {
  bool mainLoading = false;
  @override
  void initState() {
    // TODO: implement initState

    // getPrefs();
    super.initState();

  }

  bool show = true;
  bool load = false;

  var userText = TextEditingController();
  var passText = TextEditingController();

  String? email,name,gender,city,pincode,address,age,phone;

  void loadDashBoard(AnimationController controller){
    controller.forward();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      resizeToAvoidBottomInset: false,

      body :
      mainLoading ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              color: Colors.purple.shade200,
            ),
            Padding(
                padding: EdgeInsets.only(top:10),
                child: Text("Checking Shared Preferences"),
            )
          ],
        ),
      ):
      Center(
        child: Container(
          color: Colors.white,
          width: double.infinity,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom:40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left:18.0,top:2),
                        child: const Text(''),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:2,right:20),
                        child: InkWell(
                            onTap: (){
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> DashBoard(email,phone,name,age,gender,pincode,address,city)));
                              mainLoading=false;
                            },
                            child: const Text('Skip',style: TextStyle(fontSize:18,color: Colors.purple))
                        ),
                      ),
                    ],
                  ),
                ),
                Image.asset('assets/images/logo.png',width: 100,height: 100),

                const Padding(
                    padding: EdgeInsets.only(bottom: 40),
                    child: Text("Boutique and Tailors",style: TextStyle(fontFamily: 'Pacifico',fontSize: 20,fontStyle: FontStyle.italic,color: Colors.deepPurple))
                ),

                    Container(
                      alignment: Alignment.topCenter,
                      width: double.infinity,
                      height: 450,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xffd6a0ec),
                            Color(0xffd9ded8),
                          ],
                          begin: Alignment.bottomRight,
                          end: Alignment.topLeft,
                        ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                        color: Color.fromARGB(100, 232, 139, 241) ,
                      ),
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: Text("Log In",style: TextStyle(fontFamily: 'Quicko',color: Colors.purple,fontWeight: FontWeight.bold,fontSize: 32)),
                          ),
                          const SizedBox(
                            width: double.infinity,
                            height: 30,
                          ),

                          Padding(
                            padding: const EdgeInsets.only(top:20),

                            child: SizedBox(
                              width: 280,
                              height: 50,

                              child: TextField(
                                controller: userText,
                                style: TextStyle(fontFamily: 'Quicko',color: Colors.deepPurple),
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                                    prefixIcon: const Icon(Icons.email,color: Colors.purple),

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
                                controller: passText,
                                style: TextStyle(fontFamily: 'Quicko',color: Colors.purple),
                                obscureText: show,
                                decoration: InputDecoration(
                                    suffixIconColor: Colors.purple,
                                    suffixIcon: IconButton(
                                      icon: const Icon(Icons.remove_red_eye),
                                      onPressed: (){
                                        setState(() {
                                          if(show){
                                            show = false;
                                          }else{
                                            show = true;
                                          }
                                        });
                                      },
                                    ),
                                    prefixIcon: const Icon(Icons.lock,color: Colors.purple),
                                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
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
                          Padding(
                            padding: const EdgeInsets.only(left:80,top:10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(" ",style: TextStyle(color: Colors.purple),),
                                InkWell(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>SignIn()));
                                    },
                                    child: Text("Sign Up ? / Registration",style: TextStyle(color: Colors.purple),)
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top:30),
                            child: !load ? ElevatedButton(
                              onPressed: ()async{
                                String uname = userText.text.toString();
                                String pass = passText.text.toString();

                                setState(() { load=true; });
                                await FirebaseAuth.instance.signInWithEmailAndPassword(email: uname, password: pass).then((value) async {
                                  var prefs = await SharedPreferences.getInstance();

                                  prefs.setString("username", uname);

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

                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(builder: (context)=>DashBoard(email,phone,name,age,gender,pincode,address,city))
                                  );

                                  Fluttertoast.showToast(msg: "Log In Succesfull ",toastLength: Toast.LENGTH_SHORT);
                                }).onError((error, stackTrace) {
                                  print(error.toString());
                                });

                                setState(() { load = false; });
                              },
                              child: const Text('Log In',style: TextStyle(color: Colors.white,fontSize: 16),),
                            ) : CircularProgressIndicator(
                              color: Colors.purple,
                            )
                            ,
                          )
                        ],
                      ),
                    ),
                  ]
          ),
        ),
      ),
    );
  }

}

