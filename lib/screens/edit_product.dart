import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopper/constants.dart';
import 'package:shopper/models/product.dart';
import 'package:shopper/services/store.dart';

class EditProduct extends StatefulWidget {
  static String id = 'EditProduct';

  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final _store = Store();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _store.loadProduct(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Product> products = [];
            for (var doc in snapshot.data.docs) {
              var data = doc.data();
              products.add(Product(
                pPrice: data[kProductPrice],
                pDescription: data[kProductDescription],
                pCategory: data[kProductCategory],
                pName: data[kProductName],
                pLocation: data[kProductLocation],
              ));
            }

            return GridView.builder(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: GestureDetector(
                  onTapUp: (details) {
                    double dx = details.globalPosition.dx;
                    double dy = details.globalPosition.dy;
                    double dx2 = MediaQuery.of(context).size.width - dx;
                    double dy2 = MediaQuery.of(context).size.height - dy;

                    showMenu(
                        context: context,
                        position: RelativeRect.fromLTRB(dx, dy, dx2, dy2),
                        items: [
                          CustomPopupMenuItem(
                            child: Text('Edit'),
                          ),
                          CustomPopupMenuItem(
                            child: Text('Delete'),
                          ),
                        ]);
                  },
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
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
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
      ),
    );
  }
}

//override popupMenuItem method to control handle tap to be able to edit and delete
class CustomPopupMenuItem<T> extends PopupMenuItem<T> {
  final Widget child;

  CustomPopupMenuItem({@required this.child}) : super(child: child);

  @override
  PopupMenuItemState<T, PopupMenuItem<T>> createState() {
    return CustomPopupItemState();
  }
}

class CustomPopupItemState<T, PopMenuItem>
    extends PopupMenuItemState<T, CustomPopupMenuItem<T>> {
  @override
  void handleTap() {}
}
