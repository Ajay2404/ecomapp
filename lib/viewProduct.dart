import 'dart:convert';

import 'package:ecommerce/editProduct.dart';
import 'package:ecommerce/productView.dart';
import 'package:ecommerce/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ViewProduct extends StatefulWidget {
  const ViewProduct({super.key});

  @override
  State<ViewProduct> createState() => _ViewProductState();
}

class _ViewProductState extends State<ViewProduct> {
  productview? productView;

  // bool checkNull = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProductData();
  }

  Future<void> getProductData() async {
    final loginId = SplashScreen.prefs!.getString("UserId") ?? "";

    Map map = {"loginId": loginId};

    var url = Uri.parse(
        'https://ajay2404.000webhostapp.com/ApiCalling/viewproduct.php');
    var response = await http.post(url, body: map);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    var aa = jsonDecode(response.body);
    setState(() {
      productView = productview.fromJson(aa);
      // checkNull = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          height: double.infinity,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadius.only(bottomRight: Radius.circular(50))),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, mainAxisExtent: 265),
            itemCount: productView?.productdata1?.length ?? 0,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return ProductViews(
                              productdata: productView!.productdata1![index]);
                        },
                      ));
                    },
                    child: Container(
                        margin: const EdgeInsets.all(5),
                        height: 180,
                        width: 300,
                        child: Image.network(
                            "https://ajay2404.000webhostapp.com/ApiCalling/${productView!.productdata1![index].tHUMBNAIL}")),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${productView!.productdata1![index].tITLE}"),
                      PopupMenuButton(
                        onSelected: (value) {
                          if (value == 1) {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return EditProduct(
                                    productView!.productdata1![index]);
                              },
                            ));
                          }
                          // else {
                          //   showDialog(
                          //     context: context,
                          //     builder: (context) {
                          //       return SimpleDialog(
                          //         title: const Text(
                          //             "Are you sure you want to delete your product?"),
                          //         children: [
                          //           ElevatedButton(
                          //               onPressed: () {
                          //                 Navigator.pop(context);
                          //               },
                          //               child: Text("YES")),
                          //           ElevatedButton(
                          //               onPressed: () {
                          //                 Navigator.pop(context);
                          //               },
                          //               child: Text("NO"))
                          //         ],
                          //       );
                          //     },
                          //   );
                          // }
                        },
                        itemBuilder: (context) {
                          return [
                            const PopupMenuItem(
                                value: 1, child: Text("Update")),
                            PopupMenuItem(
                                value: 2,
                                onTap: () {},
                                child: const Text("Delete")),
                          ];
                        },
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text("${productView!.productdata1![index].pRICE}"),
                    ],
                  ),
                ],
              );
            },
          ),
        ));
  }
}

class productview {
  int? connection;
  int? result;
  List<Productdata1>? productdata1;

  productview({this.connection, this.result, this.productdata1});

  productview.fromJson(Map<String, dynamic> json) {
    connection = json['connection'];
    result = json['result'];
    if (json['productdata1'] != null) {
      productdata1 = <Productdata1>[];
      json['productdata1'].forEach((v) {
        productdata1!.add(new Productdata1.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['connection'] = this.connection;
    data['result'] = this.result;
    if (this.productdata1 != null) {
      data['productdata1'] = this.productdata1!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Productdata1 {
  String? iD;
  String? tHUMBNAIL;
  String? tITLE;
  String? pRICE;
  String? dESCRIPTION;
  List<String>? mULTIIMG;
  String? uSERID;

  Productdata1(
      {this.iD,
      this.tHUMBNAIL,
      this.tITLE,
      this.pRICE,
      this.dESCRIPTION,
      this.mULTIIMG,
      this.uSERID});

  Productdata1.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    tHUMBNAIL = json['THUMBNAIL'];
    tITLE = json['TITLE'];
    pRICE = json['PRICE'];
    dESCRIPTION = json['DESCRIPTION'];
    mULTIIMG = json['MULTIIMG'].cast<String>();
    uSERID = json['USERID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['THUMBNAIL'] = this.tHUMBNAIL;
    data['TITLE'] = this.tITLE;
    data['PRICE'] = this.pRICE;
    data['DESCRIPTION'] = this.dESCRIPTION;
    data['MULTIIMG'] = this.mULTIIMG;
    data['USERID'] = this.uSERID;
    return data;
  }
}
