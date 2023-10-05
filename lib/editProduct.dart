import 'dart:convert';
import 'dart:io';

import 'package:ecommerce/dashBoard.dart';
import 'package:ecommerce/viewProduct.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class EditProduct extends StatefulWidget {
  Productdata1? productdata1;

  EditProduct(Productdata1 this.productdata1, {super.key});

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  TextEditingController title = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController description = TextEditingController();
  final ImagePicker imgPicker = ImagePicker();
  String newImage = "";
  bool status = false;
  bool imgStatus = false;
  List multiImg = [];

  bool multiStatus = false;
  List<XFile>? imageFile;
  List<String> imageList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    editMethod();
  }

  editMethod() {
    setState(() {
      title.text = widget.productdata1!.tITLE!;
      price.text = widget.productdata1!.pRICE!;
      description.text = widget.productdata1!.dESCRIPTION!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue,
        body: ListView(children: [
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return SimpleDialog(
                    children: [
                      ListTile(
                        title: const Text("Camera"),
                        leading: const Icon(Icons.camera_alt),
                        onTap: () async {
                          XFile? photo = await imgPicker.pickImage(
                              source: ImageSource.camera);
                          setState(() {
                            newImage = photo!.path;
                            status = true;
                          });
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        title: const Text("Gallery"),
                        leading: const Icon(Icons.image),
                        onTap: () async {
                          final XFile? image = await imgPicker.pickImage(
                              source: ImageSource.gallery);
                          setState(() {
                            newImage = image!.path;
                            status = true;
                          });
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  );
                },
              );
            },
            child: status
                ? Container(
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    height: 400,
                    width: 400,
                    child: Image.file(File(newImage)))
                : Container(
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    height: 400,
                    child: Image.network(
                        "https://ajay2404.000webhostapp.com/ApiCalling/${widget.productdata1!.tHUMBNAIL}")),
          ),
          multiStatus
              ? Wrap(
                  children: imageFile!.map((imageOne) {
                    return Card(
                      child: SizedBox(
                        height: 80,
                        width: 80,
                        child: Image.file(File(imageOne.path)),
                      ),
                    );
                  }).toList(),
                )
              : SizedBox(
                  height: 300,
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3),
                    itemCount: widget.productdata1!.mULTIIMG!.length,
                    itemBuilder: (context, index) {
                      return Container(
                          width: 200,
                          height: 200,
                          child: Image(
                            image: NetworkImage(
                                "https://ajay2404.000webhostapp.com/ApiCalling/${widget.productdata1!.mULTIIMG![index]}"),
                          ));
                    },
                  ),
                ),
          ElevatedButton(
              onPressed: () async {
                try {
                  var pickedMultiFiles = await imgPicker.pickMultiImage();
                  if (pickedMultiFiles != null) {
                    imageFile = pickedMultiFiles;
                    setState(() {});
                  } else {
                    print("No image is selected.");
                  }
                } catch (e) {
                  print(e);
                }
              },
              child: Text("Change Images")),
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
                      borderRadius: BorderRadius.circular(10))),
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
                      borderRadius: BorderRadius.circular(10))),
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
                      borderRadius: BorderRadius.circular(10))),
              controller: description,
            ),
          ),
          const SizedBox(height: 10),
          InkWell(
            onTap: () async {
              String imageData = "";
              if (newImage != "") {
                List<int> imge = File(newImage).readAsBytesSync();
                imageData = base64Encode(imge);
              }

              if (imageFile != "") {
                for (int i = 0; i < imageFile!.length; i++) {
                  List<int> barry = File(imageFile![i].path).readAsBytesSync();
                  String imageData = base64Encode(barry);
                  imageList.add(imageData);
                }
              }

              Map map2 = {
                "productId": widget.productdata1!.iD,
                "productTitle": title.text,
                "productPrice": price.text,
                "productDescription": description.text,
                "productnameThumbnail": widget.productdata1!.tHUMBNAIL,
                "productNewImg": imageData,
                "productNewMultiImg": "$imageList",
                "totalProductMultiImg": "${imageList.length}",
              };
              var url = Uri.parse(
                  'https://ajay2404.000webhostapp.com/ApiCalling/updateproduct.php');
              var response = await http.post(url, body: map2);
              print('Response status: ${response.statusCode}');
              print('Response body: ${response.body}');

              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DashBoard(),
                  ));
            },
            child: Container(
              alignment: Alignment.center,
              height: 60,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(15)),
              child: const Text("Update Product",
                  style: TextStyle(color: Colors.white)),
            ),
          ),
        ]),
      ),
    );
  }
}
