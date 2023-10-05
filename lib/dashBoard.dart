import 'package:ecommerce/addProduct.dart';
import 'package:ecommerce/loginPage.dart';
import 'package:ecommerce/profilePage.dart';
import 'package:ecommerce/splashScreen.dart';
import 'package:ecommerce/viewProduct.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'allProduct.dart';
import 'category.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  int onChange = 0;
  // int selectedIndex = 0;
  // Color selectedColor = Colors.white;
  // Color unselectedColor = Colors.black;

  String? img = SplashScreen.prefs!.getString("imgPath");
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          leading: GestureDetector(
            child: SvgPicture.asset(height: 10, "images/svg_assets/menu.svg"),
            onTap: () => scaffoldKey.currentState!.openDrawer(),
          ),
          actions: [
            SizedBox(
              width: 10,
            ),
            // IconButton(
            //   icon: const Icon(Icons.search_rounded),
            //   color: Colors.black,
            //   onPressed: () {
            //     Navigator.push(context, MaterialPageRoute(
            //       builder: (context) {
            //         return PaymentPage();
            //       },
            //     ));
            //   },
            // ),
            const SizedBox(width: 10)
          ],
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        drawer: Drawer(
          child: Column(
            children: [
              UserAccountsDrawerHeader(
                  currentAccountPicture: CircleAvatar(
                      backgroundImage: NetworkImage(
                          "https://ajay2404.000webhostapp.com/ApiCalling/$img")),
                  accountName:
                      Text("${SplashScreen.prefs!.getString("fName")}"),
                  accountEmail:
                      Text("${SplashScreen.prefs!.getString("eMail")}")),
              ListTile(
                title: const Text("View Product"),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    onChange = 0;
                  });
                },
              ),
              ListTile(
                title: const Text("Add Product"),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    onChange = 1;
                  });
                },
              ),
              ListTile(
                title: const Text("All Product"),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    onChange = 2;
                  });
                },
              ),
              ListTile(
                title: const Text("Category"),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    onChange = 3;
                  });
                },
              ),
              const ListTile(title: Text("Order History")),
              const ListTile(title: Text("Contact Us")),
              const ListTile(title: Text("Help Center")),
              const ListTile(title: Text("About Us")),
              ListTile(
                title: const Text("Log Out"),
                onTap: () {
                  SplashScreen.prefs!
                      .setBool("loginStatus", false)
                      .then((value) {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return const LoginPage();
                      },
                    ));
                  });
                },
              ),
            ],
          ),
        ),
        body: onChange == 0
            ? const ViewProduct()
            : onChange == 1
                ? const AddProduct()
                : onChange == 2
                    ? const AllProduct()
                    : const Category(),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(50)),
            color: Colors.black,
          ),
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width: 5),
              SvgPicture.asset("images/svg_assets/home.svg",
                  colorFilter:
                      const ColorFilter.mode(Colors.white, BlendMode.srcIn)),
              const SizedBox(width: 5),
              SvgPicture.asset("images/svg_assets/cart.svg",
                  colorFilter:
                      const ColorFilter.mode(Colors.white, BlendMode.srcIn)),
              const SizedBox(width: 5),
              SvgPicture.asset("images/svg_assets/card.svg",
                  colorFilter:
                      const ColorFilter.mode(Colors.white, BlendMode.srcIn)),
              const SizedBox(width: 5),
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return ProfilePage();
                    },
                  ));
                },
                child: SvgPicture.asset("images/svg_assets/profile.svg",
                    colorFilter:
                        const ColorFilter.mode(Colors.white, BlendMode.srcIn)),
              ),
              const SizedBox(width: 5),
            ],
          ),
        ),
      ),
    );
  }
}
