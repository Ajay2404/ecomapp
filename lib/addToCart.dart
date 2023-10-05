import 'dart:convert';

import 'package:ecommerce/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddToCart extends StatefulWidget {
  const AddToCart({super.key});

  @override
  State<AddToCart> createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addToCartData();
  }

  viewcartdata? viewCartData;

  addToCartData() async {
    final loginId = SplashScreen.prefs!.getString("UserId") ?? "";

    Map viewmap = {"loginId": loginId};

    var url =
        Uri.parse('https://ajay2404.000webhostapp.com/ApiCalling/viewcart.php');
    var response = await http.post(url, body: viewmap);
    print('Response status: ${response.statusCode}');
    print('Response body ajay: ${response.body}');
    var aaa = jsonDecode(response.body);
    setState(() {
      viewCartData = viewcartdata.fromJson(aaa);
      // checkNull = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        backgroundColor: Colors.black,
        body: Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadius.only(bottomRight: Radius.circular(50))),
          height: double.infinity,
          child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, mainAxisExtent: 265),
            itemCount: viewCartData?.productcart?.length ?? 0,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  InkWell(
                    onTap: () {
                      // Navigator.push(context, MaterialPageRoute(
                      //   builder: (context) {
                      //     return ProductViews(
                      //
                      //     );
                      //   },
                      // ));
                    },
                    child: Container(
                        margin: const EdgeInsets.all(5),
                        height: 180,
                        width: 300,
                        child: Image.network(
                            "https://ajay2404.000webhostapp.com/ApiCalling/${viewCartData!.productcart![index].tHUMBNAIL}")),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${viewCartData!.productcart![index].pRICE}"),
                      PopupMenuButton(
                        onSelected: (value) {
                          if (value == 1) {
                            // Navigator.push(context, MaterialPageRoute(
                            //   builder: (context) {
                            //     return EditProduct();
                            //   },
                            // ));
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return SimpleDialog(
                                  title: const Text(
                                      "Are you sure you want to delete your product?"),
                                  children: [
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("YES")),
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("NO"))
                                  ],
                                );
                              },
                            );
                          }
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
                      Text("${viewCartData!.productcart![index].tITLE}"),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class viewcartdata {
  int? connection;
  int? result;
  List<Productcart>? productcart;

  viewcartdata({this.connection, this.result, this.productcart});

  viewcartdata.fromJson(Map<String, dynamic> json) {
    connection = json['connection'];
    result = json['result'];
    if (json['productcart'] != null) {
      productcart = <Productcart>[];
      json['productcart'].forEach((v) {
        productcart!.add(new Productcart.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['connection'] = this.connection;
    data['result'] = this.result;
    if (this.productcart != null) {
      data['productcart'] = this.productcart!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Productcart {
  String? iD;
  String? tITLE;
  String? tHUMBNAIL;
  String? pRICE;
  String? dESCRIPTION;
  String? mULTIIMAGE;
  String? pRODUCTID;
  String? uSERID;

  Productcart(
      {this.iD,
      this.tITLE,
      this.tHUMBNAIL,
      this.pRICE,
      this.dESCRIPTION,
      this.mULTIIMAGE,
      this.pRODUCTID,
      this.uSERID});

  Productcart.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    tITLE = json['TITLE'];
    tHUMBNAIL = json['THUMBNAIL'];
    pRICE = json['PRICE'];
    dESCRIPTION = json['DESCRIPTION'];
    mULTIIMAGE = json['MULTIIMAGE'];
    pRODUCTID = json['PRODUCTID'];
    uSERID = json['USERID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['TITLE'] = this.tITLE;
    data['THUMBNAIL'] = this.tHUMBNAIL;
    data['PRICE'] = this.pRICE;
    data['DESCRIPTION'] = this.dESCRIPTION;
    data['MULTIIMAGE'] = this.mULTIIMAGE;
    data['PRODUCTID'] = this.pRODUCTID;
    data['USERID'] = this.uSERID;
    return data;
  }
}
