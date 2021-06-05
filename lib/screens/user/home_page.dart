import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopper/constants.dart';
import 'package:shopper/models/product.dart';
import 'package:shopper/screens/login_screen.dart';
import 'package:shopper/screens/user/cart_screen.dart';
import 'package:shopper/screens/user/productinfo.dart';
import 'package:shopper/services/auth.dart';
import 'package:shopper/services/functions/get_product_bycategory.dart';
import 'package:shopper/services/store.dart';
import 'package:shopper/widgets/custom_text.dart';
import 'package:shopper/widgets/product_view.dart';

class HomePage extends StatefulWidget {
    final QueryDocumentSnapshot queryDocumentSnapshot;
    const HomePage({
    this.queryDocumentSnapshot,
  });

  static String id = 'HomePage';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _auth = Auth();
  User _loggedUser;
  int _tabBarIndex = 0;
  int _bottomBarIndex = 0;
  final _store = Store();
  List<Product> _products;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        DefaultTabController(
          length: 4,
          child: Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: _bottomBarIndex,
              fixedColor: Color(kPurpleColor),
              onTap: (value) {
                setState(() async {
                  if (value == 2) {
                    SharedPreferences pref =
                        await SharedPreferences.getInstance();
                    pref.clear();
                    await _auth.SignOut();
                    Navigator.popAndPushNamed(context, LoginScreen.id);
                  }
                  _bottomBarIndex = value;
                });
              },
              items: [
                BottomNavigationBarItem(
                    label: 'Profile', icon: Icon(Icons.person)),
                BottomNavigationBarItem(
                    label: 'Profile', icon: Icon(Icons.person)),
                BottomNavigationBarItem(
                    label: 'Sign Out', icon: Icon(Icons.close)),
              ],
            ),
            appBar: AppBar(
              backgroundColor: Color(kPurpleColor),
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
                    color: _tabBarIndex == 0 ? Colors.black : Colors.white,
                    text: 'Jackets',
                    fontSize: _tabBarIndex == 0 ? 16 : null,
                  ),
                  CustomText(
                    color: _tabBarIndex == 1 ? Colors.black : Colors.white,
                    text: 'Trousers',
                    fontSize: _tabBarIndex == 1 ? 16 : null,
                  ),
                  CustomText(
                    color: _tabBarIndex == 2 ? Colors.black : Colors.white,
                    text: 'T-shirts',
                    fontSize: _tabBarIndex == 2 ? 16 : null,
                  ),
                  CustomText(
                    color: _tabBarIndex == 3 ? Colors.black : Colors.white,
                    text: 'Shoes',
                    fontSize: _tabBarIndex == 3 ? 16 : null,
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                jacketView(),
                productView(kTrousers, _products),
                productView(kT_shirts, _products),
                productView(kShoes, _products),
              ],
            ),
          ),
        ),
        Material(
          // child: Padding(
          //   padding: EdgeInsets.symmetric(vertical: 20),
          child: Container(
            color: Color(kPurpleColor),
            height: MediaQuery.of(context).size.height * 0.118,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    color: Colors.white,
                    text: 'Discover'.toUpperCase(),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, CartScreen.id);
                    },
                    child: Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
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
          _products = [...products];
          products.clear();
          products = getProductByCategory(kJackets, _products);
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 0.8),
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, ProductInfo.id,
                      arguments: products[index]);
                },
                child: Stack(children: [
                  Positioned.fill(
                    child: Image.network(products[index].pLocation),),
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
