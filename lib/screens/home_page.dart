import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shopper/constants.dart';
import 'package:shopper/models/product.dart';
import 'package:shopper/services/auth.dart';
import 'package:shopper/services/store.dart';
import 'package:shopper/widgets/custom_text.dart';

class HomePage extends StatefulWidget {
  static String id = 'HomePage';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _auth = Auth();
  User _loggedUser;
  int _tabBarIndex = 0;
  final _store = Store();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        DefaultTabController(
          length: 4,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              bottom: TabBar(
                labelPadding: EdgeInsets.zero,
                indicatorColor: Color(kPurpleColor),
                onTap: (value) {
                  setState(() {
                    _tabBarIndex = value;
                  });
                },
                tabs: <Widget>[
                  CustomText(
                    color:
                        _tabBarIndex == 0 ? Color(kPurpleColor) : Colors.black,
                    text: 'Jackets',
                    fontSize: _tabBarIndex == 0 ? 16 : null,
                  ),
                  CustomText(
                    color:
                        _tabBarIndex == 1 ? Color(kPurpleColor) : Colors.black,
                    text: 'Trousers',
                    fontSize: _tabBarIndex == 1 ? 16 : null,
                  ),
                  CustomText(
                    color:
                        _tabBarIndex == 2 ? Color(kPurpleColor) : Colors.black,
                    text: 'T-shirts',
                    fontSize: _tabBarIndex == 2 ? 16 : null,
                  ),
                  CustomText(
                    color:
                        _tabBarIndex == 3 ? Color(kPurpleColor) : Colors.black,
                    text: 'Shoes',
                    fontSize: _tabBarIndex == 3 ? 16 : null,
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                jacketView(),
                CustomText(),
                CustomText(),
                CustomText(),
              ],
            ),
          ),
        ),
        Material(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.08,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: 'Discover'.toUpperCase(),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  Icon(Icons.shopping_cart)
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  @override
  void initState() {
    getCurrenUser();
  }

  getCurrenUser() async {
    _loggedUser = await _auth.getUser();
  }

  Widget jacketView() {
    return StreamBuilder<QuerySnapshot>(
      stream: _store.loadProduct(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Product> products = [];
          for (var doc in snapshot.data.docs) {
            var data = doc.data();
            products.add(Product(
              pId: doc.id,
              pPrice: data[kProductPrice],
              pDescription: data[kProductDescription],
              pCategory: data[kProductCategory],
              pName: data[kProductName],
              pLocation: data[kProductLocation],
            ));
          }
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 0.8),
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Stack(children: [
                Positioned.fill(
                  child: Image(
                      fit: BoxFit.fill,
                      image: AssetImage(products[index].pLocation)),
                ),
                Positioned(
                  bottom: 0,
                  child: Opacity(
                    opacity: 0.6,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      color: Colors.white,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              (products[index].pName),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(('\$ ${products[index].pPrice}')),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
            ),
            itemCount: products.length,
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
