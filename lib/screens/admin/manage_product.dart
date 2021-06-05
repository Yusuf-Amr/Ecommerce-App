import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:shopper/constants.dart';
import 'package:shopper/models/product.dart';
import 'package:shopper/screens/admin/edit_product.dart';
import 'package:shopper/services/store.dart';
import 'package:shopper/widgets/custom_menu.dart';

class ManageProduct extends StatefulWidget {
  static String id = 'ManageProduct';

  @override
  _ManageProductState createState() => _ManageProductState();
}

class _ManageProductState extends State<ManageProduct> {
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
                child: GestureDetector(
                  onTapUp: (details) async {
                    double dx = details.globalPosition.dx;
                    double dy = details.globalPosition.dy;
                    double dx2 = MediaQuery.of(context).size.width - dx;
                    double dy2 = MediaQuery.of(context).size.height - dy;

                    await showMenu(
                        context: context,
                        position: RelativeRect.fromLTRB(dx, dy, dx2, dy2),
                        items: [
                          CustomPopupMenuItem(
                            onClick: () async{
                            await  Navigator.pushNamed(context, EditProduct.id,
                                  arguments: products[index]);
                            },
                            child: Text('Edit'),
                          ),
                          CustomPopupMenuItem(
                            onClick: () async{
                             await _store.deleteProduct(products[index].pId);
                              Navigator.pop(context);
                            },
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


