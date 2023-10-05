import 'dart:convert';

import 'package:ecommerce/dashBoard.dart';
import 'package:ecommerce/modelclass.dart';
import 'package:ecommerce/registerPage.dart';
import 'package:ecommerce/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              bottom: const TabBar(
                tabs: [
                  Tab(child: Text("LOGIN")),
                  Tab(child: Text("SIGNUP")),
                ],
              ),
            ),
            body: TabBarView(children: [
              //loginpage
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: email,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          hintText: "Enter Email"),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: password,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        hintText: "Enter Your Password",
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.visibility),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () async {
                      String loginEmail = email.text;
                      String loginPassword = password.text;
                      Map map1 = {
                        "rEmail": loginEmail,
                        "rPassword": loginPassword,
                      };
                      var url = Uri.parse(
                          'https://ajay2404.000webhostapp.com/ApiCalling/login.php');
                      var response = await http.post(url, body: map1);
                      print('Response status: ${response.statusCode}');
                      print('Response body: ${response.body}');

                      var ab = jsonDecode(response.body);
                      DataView dataView = DataView.fromJson(ab);
                      if (dataView.result == 1) {
                        String id = dataView.user!.iD.toString();
                        String fName = dataView.user!.fIRSTNAME.toString();
                        String lName = dataView.user!.lASTNAME.toString();
                        String email = dataView.user!.eMAIL.toString();
                        String number = dataView.user!.nUMBER.toString();
                        String password = dataView.user!.pASSWORD.toString();
                        String imgPath = dataView.user!.iMAGEPATH.toString();

                        setState(() {
                          SplashScreen.prefs!.setString("UserId", id);
                          SplashScreen.prefs!.setString("fName", fName);
                          SplashScreen.prefs!.setString("lName", lName);
                          SplashScreen.prefs!.setString("eMail", email);
                          SplashScreen.prefs!.setString("numb", number);
                          SplashScreen.prefs!.setString("password", password);
                          SplashScreen.prefs!.setString("imgPath", imgPath);
                        });
                        SplashScreen.prefs!
                            .setBool("loginStatus", true)
                            .then((value) {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return DashBoard();
                            },
                          ));
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("User Login Success")));
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("User Not Found")));
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                              top: 20, bottom: 20, left: 100, right: 100),
                          decoration: BoxDecoration(
                              color: Colors.black,
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(20)),
                          child: const Text(
                            "Login",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              //  registerPage
              RegisterPage(),
            ])));
  }
}

class ConvertData {
  int? connection;
  int? result;

  ConvertData({this.connection, this.result});

  ConvertData.fromJson(Map<String, dynamic> json) {
    connection = json['connection'];
    result = json['result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['connection'] = this.connection;
    data['result'] = this.result;
    return data;
  }
}
