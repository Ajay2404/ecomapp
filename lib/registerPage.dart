// import 'dart:convert';
// import 'dart:io';
//
// import 'package:ecommerce/loginPage.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:image_picker/image_picker.dart';
//
// class RegisterPage extends StatefulWidget {
//   const RegisterPage({Key? key}) : super(key: key);
//
//   @override
//   State<RegisterPage> createState() => _RegisterPageState();
// }
//
// class _RegisterPageState extends State<RegisterPage> {
//   TextEditingController firstName = TextEditingController();
//   TextEditingController lastName = TextEditingController();
//   TextEditingController registerEmail = TextEditingController();
//   TextEditingController number = TextEditingController();
//   TextEditingController registerPassword = TextEditingController();
//
//   String imagePath = "";
//   bool status = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Register Page"),
//         backgroundColor: Colors.green,
//         elevation: 0,
//       ),
//       backgroundColor: Colors.green,
//       body: SingleChildScrollView(
//         child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
//           InkWell(
//               onTap: () {
//                 final ImagePicker picker = ImagePicker();
//                 showDialog(
//                   context: context,
//                   builder: (context) {
//                     return SimpleDialog(
//                       children: [
//                         InkWell(
//                           onTap: () async {
//                             Navigator.pop(context);
//                             XFile? photo = await picker.pickImage(
//                                 source: ImageSource.camera);
//                             setState(() {
//                               imagePath = photo!.path;
//                               status = true;
//                             });
//                           },
//                           child: Row(children: const [
//                             SizedBox(
//                               width: 10,
//                             ),
//                             Text("Camera"),
//                             SizedBox(width: 130),
//                             Icon(Icons.camera_alt),
//                           ]),
//                         ),
//                         const SizedBox(
//                           height: 20,
//                         ),
//                         InkWell(
//                           onTap: () async {
//                             Navigator.pop(context);
//                             final XFile? image = await picker.pickImage(
//                                 source: ImageSource.gallery);
//                             setState(() {
//                               imagePath = image!.path;
//                               status = true;
//                             });
//                           },
//                           child: Container(
//                             child: Row(children: const [
//                               SizedBox(
//                                 width: 10,
//                               ),
//                               Text("Gallery"),
//                               SizedBox(width: 136),
//                               Icon(Icons.image),
//                             ]),
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 20,
//                         ),
//                       ],
//                     );
//                   },
//                 );
//               },
//               child: imagePath != ""
//                   ? CircleAvatar(
//                       backgroundImage: FileImage(File(imagePath)),
//                       maxRadius: 80,
//                     )
//                   : CircleAvatar(
//                       maxRadius: 80,
//                       child: Text(firstName.text, maxLines: 1),
//                     )),
//           const SizedBox(height: 20),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               SizedBox(
//                 width: 170,
//                 child: TextField(
//                   controller: firstName,
//                   decoration: const InputDecoration(
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(10))),
//                     hintText: "First Name",
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 width: 10,
//               ),
//               SizedBox(
//                 width: 170,
//                 child: TextField(
//                   controller: lastName,
//                   decoration: const InputDecoration(
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(10))),
//                     hintText: "Last Name",
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 20),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: TextField(
//               controller: registerEmail,
//               decoration: const InputDecoration(
//                 border: OutlineInputBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(10))),
//                 hintText: "Enter Your Email",
//               ),
//             ),
//           ),
//           const SizedBox(height: 20),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: TextField(
//               controller: number,
//               decoration: const InputDecoration(
//                 border: OutlineInputBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(10))),
//                 hintText: "Enter Your Number",
//               ),
//             ),
//           ),
//           const SizedBox(height: 20),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: TextField(
//               controller: registerPassword,
//               decoration: const InputDecoration(
//                 border: OutlineInputBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(10))),
//                 hintText: "Enter Your Password",
//               ),
//             ),
//           ),
//           const SizedBox(height: 20),
//           GestureDetector(
//             onTap: () async {
//               Navigator.push(context, MaterialPageRoute(
//                 builder: (context) {
//                   return const LoginPage();
//                 },
//               ));
//               String fName = firstName.text;
//               String lName = lastName.text;
//               String rEmail = registerEmail.text;
//               String numb = number.text;
//               String registerPass = registerPassword.text;
//
//               List<int> img = File(imagePath).readAsBytesSync();
//               String imageData = base64Encode(img);
//
//               Map map = {
//                 "fName": fName,
//                 "lName": lName,
//                 "rEmail": rEmail,
//                 "num": numb,
//                 "rPassword": registerPass,
//                 'imagedata': imageData,
//               };
//               var url = Uri.parse(
//                   'https://ajay2404.000webhostapp.com/ApiCalling/register.php');
//               var response = await http.post(url, body: map);
//               print('Response status: ${response.statusCode}');
//               print('Response body: ${response.body}');
//             },
//             child: Container(
//               padding: const EdgeInsets.only(
//                   top: 20, bottom: 20, left: 100, right: 100),
//               decoration: BoxDecoration(
//                   color: Colors.black,
//                   border: Border.all(color: Colors.black),
//                   borderRadius: BorderRadius.circular(20)),
//               child: const Text(
//                 "Sign Up",
//                 style: TextStyle(
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Text("Already Have Account? "),
//               InkWell(
//                 onTap: () {
//                   Navigator.push(context, MaterialPageRoute(
//                     builder: (context) {
//                       return const LoginPage();
//                     },
//                   ));
//                 },
//                 child: const Text(
//                   "Login",
//                   style: TextStyle(
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ]),
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'dart:io';

import 'package:ecommerce/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController registerEmail = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController registerPassword = TextEditingController();

  String imagePath = "";
  bool status = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const SizedBox(height: 20),
          InkWell(
              onTap: () {
                final ImagePicker picker = ImagePicker();
                showDialog(
                  context: context,
                  builder: (context) {
                    return SimpleDialog(
                      children: [
                        ListTile(
                          title: Text("Camera"),
                          leading: Icon(Icons.camera_alt),
                          onTap: () async {
                            Navigator.pop(context);
                            XFile? photo = await picker.pickImage(
                                source: ImageSource.camera);
                            setState(() {
                              imagePath = photo!.path;
                              status = true;
                            });
                          },
                        ),
                        ListTile(
                          title: Text("Gallery"),
                          leading: Icon(Icons.image),
                          onTap: () async {
                            Navigator.pop(context);
                            final XFile? image = await picker.pickImage(
                                source: ImageSource.gallery);
                            setState(() {
                              imagePath = image!.path;
                              status = true;
                            });
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: imagePath != ""
                  ? CircleAvatar(
                      backgroundImage: FileImage(File(imagePath)),
                      maxRadius: 80,
                    )
                  : const CircleAvatar(
                      maxRadius: 80,
                      child: Icon(
                        Icons.person,
                        size: 150,
                      ))),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 170,
                child: TextField(
                  controller: firstName,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    hintText: "First Name",
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                width: 170,
                child: TextField(
                  controller: lastName,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    hintText: "Last Name",
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: registerEmail,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                hintText: "Enter Your Email",
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                hintText: "Enter Your Number",
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: registerPassword,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                hintText: "Enter Your Password",
              ),
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () async {
              String fName = firstName.text;
              String lName = lastName.text;
              String rEmail = registerEmail.text;
              String numb = number.text;
              String registerPass = registerPassword.text;
              String imageData = "";
              if (imagePath != "") {
                List<int> img = File(imagePath).readAsBytesSync();
                imageData = base64Encode(img);
              }

              Map map = {
                "fName": fName,
                "lName": lName,
                "rEmail": rEmail,
                "num": numb,
                "rPassword": registerPass,
                'imagedata': imageData,
              };
              var url = Uri.parse(
                  'https://ajay2404.000webhostapp.com/ApiCalling/register.php');
              var response = await http.post(url, body: map);
              print('Response status: ${response.statusCode}');
              print('Response body: ${response.body}');

              var mm = jsonDecode(response.body);

              ConvertData convertData = ConvertData.fromJson(mm);

              if (convertData.result == 1) {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return const LoginPage();
                  },
                ));
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("User Login Success")));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("User already exist")));
              }
            },
            child: Container(
              padding: const EdgeInsets.only(
                  top: 20, bottom: 20, left: 100, right: 100),
              decoration: BoxDecoration(
                  color: Colors.black,
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(20)),
              child: const Text(
                "Sign Up",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ]),
      ),
    );
  }
}
