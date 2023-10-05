import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';



class SharedPrefs extends StatefulWidget {
  const SharedPrefs({Key? key}) : super(key: key);

  @override
  State<SharedPrefs> createState() => _SharedPrefsState();
}

class _SharedPrefsState extends State<SharedPrefs> {
  SharedPreferences? prefs;

  @override
  void initState() {
    super.initState();
    sharedPrefsFun();
  }

  void sharedPrefsFun() async {
    prefs = await SharedPreferences.getInstance();
    print("SharedPreferences Instance: $prefs");
  }

  @override
  Widget build(BuildContext context) {
    var sizes = MediaQuery.of(context).size;

    double screenHeight = sizes.height;
    double screenWidth = sizes.width;
    double appBarHeight = kToolbarHeight;
    double bodyHeight = screenHeight - appBarHeight;

    Color bgColor = Colors.grey;

    String display = "";
    String data = "";

    TextEditingController name = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            "SHARED PREFERENCE TASK",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // Textfield setting value
          TextField(
            controller: name,
            decoration: InputDecoration(
              hintText: 'Set the value here',
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 3, color: Colors.black),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),

          // Setter button
          Expanded(
            child: InkWell(
              onTap: () {
                setState(() {
                  display = name.text;
                });
                prefs!.setString('get', name.text);
              },
              child: Container(
                height: bodyHeight * 0.15,
                width: screenWidth * 0.8,
                decoration: BoxDecoration(
                  color: Colors.black,
                  border: Border.all(width: 10, color: Colors.white),
                ),
                child: Center(
                  child: Text(
                    "SET",
                    style: TextStyle(
                      fontSize: 35,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Container to display the "get" value
          Container(
            child: Center(
              child: Text(
                data,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(width: 3, color: Colors.black),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
          ),

          // Getter button
          Expanded(
            child: InkWell(
              onTap: () {
                setState(() {
                  display = prefs!.getString('get') ?? "";
                  data = display;
                });
              },
              child: Container(
                height: bodyHeight * 0.15,
                width: screenWidth * 0.8,
                decoration: BoxDecoration(
                  color: Colors.black,
                  border: Border.all(width: 10, color: Colors.white),
                ),
                child: Center(
                  child: Text(
                    "GET",
                    style: TextStyle(
                      fontSize: 35,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Text(
            "hello $display",
            style: TextStyle(fontSize: 29),
          ),
        ],
      ),
      backgroundColor: bgColor,
    );
  }
}
