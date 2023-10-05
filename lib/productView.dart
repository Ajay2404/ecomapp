import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce/addressPage.dart';
import 'package:ecommerce/viewProduct.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'addToCart.dart';

class ProductViews extends StatefulWidget {
  final Productdata1? productdata;

  const ProductViews({super.key, this.productdata});

  @override
  State<ProductViews> createState() => _ProductViewsState();
}

class _ProductViewsState extends State<ProductViews> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                        "https://ajay2404.000webhostapp.com/ApiCalling/${widget.productdata!.tHUMBNAIL}")),
                color: Colors.black,
                borderRadius: const BorderRadius.all(Radius.circular(20))),
            margin: const EdgeInsets.all(20),
            height: 400,
            width: 400,
          ),
          CarouselSlider(
              items: List.generate(
                  widget.productdata!.mULTIIMG!.length,
                  (index) => Image(
                      image: NetworkImage(
                          "https://ajay2404.000webhostapp.com/ApiCalling/${widget.productdata!.mULTIIMG![index]}"))),
              options: CarouselOptions(autoPlay: true)),
          Text("${widget.productdata!.pRICE}"),
        ]),
        bottomNavigationBar: Row(
          children: [
            InkWell(
              onTap: () async {
                Map map3 = {
                  "userId": widget.productdata!.uSERID,
                  "cartId": widget.productdata!.iD,
                  "cartThumbnail": widget.productdata!.tHUMBNAIL,
                  "cartTitle": widget.productdata!.tITLE,
                  "cartPrice": widget.productdata!.pRICE,
                  "cartDescription": widget.productdata!.dESCRIPTION,
                };
                var url = Uri.parse(
                    'https://ajay2404.000webhostapp.com/ApiCalling/addtocart.php');
                var response = await http.post(url, body: map3);
                print('Response status: ${response.statusCode}');
                print('Response body: ${response.body}');

                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return AddToCart();
                  },
                ));
              },
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius:
                        BorderRadius.only(topRight: Radius.circular(30))),
                alignment: Alignment.center,
                margin: const EdgeInsets.only(right: 5, left: 1),
                height: 80,
                width: 100,
                child: const Text(
                  "Add To Cart",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return const AddressPage();
                  },
                ));
              },
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(30))),
                alignment: Alignment.center,
                margin: const EdgeInsets.only(left: 5),
                height: 80,
                width: 100,
                child: const Text("Buy Now",
                    style: TextStyle(color: Colors.white, fontSize: 20)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
