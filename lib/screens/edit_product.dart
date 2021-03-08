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

            return ListView.builder(
              itemBuilder: (context, index) => Text(products[index].pName),
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
