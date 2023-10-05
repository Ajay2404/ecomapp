import 'dart:convert';
import 'dart:io';

import 'package:ecommerce/dashBoard.dart';
import 'package:ecommerce/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  TextEditingController title = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController description = TextEditingController();
  final ImagePicker imgPicker = ImagePicker();
  List<XFile>? imagefiles;
  List<String> imagepathlist = [];
  String productImagePath = "";
  bool status = false;
  bool imgStatus = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () async {
                showDialog(
                  context: context,
                  builder: (context) {
                    return SimpleDialog(
                      children: [
                        ListTile(
                          title: const Text("Camera"),
                          leading: const Icon(Icons.camera_alt),
                          onTap: () async {
                            Navigator.pop(context);
                            XFile? photo = await imgPicker.pickImage(
                                source: ImageSource.camera);
                            setState(() {
                              productImagePath = photo!.path;
                              status = true;
                            });
                          },
                        ),
                        ListTile(
                          title: const Text("Gallery"),
                          leading: const Icon(Icons.image),
                          onTap: () async {
                            Navigator.pop(context);
                            final XFile? image = await imgPicker.pickImage(
                                source: ImageSource.gallery);
                            setState(() {
                              productImagePath = image!.path;
                              status = true;
                            });
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: productImagePath != ""
                  ? Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      height: 400,
                      child: Image.file(File(productImagePath), width: 400),
                    )
                  : Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      height: 400,
                      width: 400,
                      child: const Icon(
                        Icons.add_photo_alternate_outlined,
                        size: 60,
                      ),
                    ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 10),
                imagefiles != null
                    ? Wrap(
                        children: imagefiles!.map((imageone) {
                          return Container(
                            child: Card(
                              child: Container(
                                height: 80,
                                width: 80,
                                child: Image.file(File(imageone.path)),
                              ),
                            ),
                          );
                        }).toList(),
                      )
                    : ElevatedButton(
                        onPressed: () async {
                          try {
                            var pickedFiles = await imgPicker.pickMultiImage();
                            if (pickedFiles != null) {
                              imagefiles = pickedFiles;
                              setState(() {});
                            } else {
                              print("No image is selected.");
                            }
                          } catch (e) {
                            print(e);
                          }
                        },
                        child: Text("Add Images"),
                      ),
                SizedBox(width: 10),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: title,
                decoration: InputDecoration(
                  hintText: "Title",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              margin: const EdgeInsets.only(right: 230, left: 20),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Price",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                controller: price,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              height: 200,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                maxLines: 8,
                decoration: InputDecoration(
                  hintText: "Description",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                controller: description,
              ),
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () async {
                for (int i = 0; i < imagefiles!.length; i++) {
                  List<int> barry = File(imagefiles![i].path).readAsBytesSync();
                  String imagedata = base64Encode(barry);
                  imagepathlist.add(imagedata);
                }
                String? loginId = SplashScreen.prefs!.getString("UserId");
                String productThumbnail = "";
                String productTitle = title.text;
                String productPrice = price.text;
                String productDescription = description.text;
                if (productImagePath != "") {
                  List<int> img = File(productImagePath).readAsBytesSync();
                  productThumbnail = base64Encode(img);
                }

                print("==$imagepathlist");

                print("======");

                Map map = {
                  "loginId": loginId,
                  "productThumbnail": productThumbnail,
                  "productTitle": productTitle,
                  "productPrice": productPrice,
                  "productDescription": productDescription,
                  "multiImg": "$imagepathlist",
                  "totalMultiImg": "${imagepathlist.length}",
                };

                print(map);
                var url = Uri.parse(
                    'https://ajay2404.000webhostapp.com/ApiCalling/addproduct.php');
                var response = await http.post(url, body: map);
                print('ajay hariyani Response status: ${response.statusCode}');
                print('ajay hariyani ====== Response body: ${response.body}');

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DashBoard(),
                  ),
                );
              },
              child: Container(
                alignment: Alignment.center,
                height: 60,
                width: 250,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Text(
                  "Add Product",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
