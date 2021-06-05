import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopper/constants.dart';
import 'package:shopper/models/product.dart';
import 'package:shopper/services/store.dart';

class OrderDetails extends StatelessWidget {
  static String id = 'OrderDetails';
  Store _store = Store();
  @override
  Widget build(BuildContext context) {
    String documentId = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _store.loadOrdersDetails(documentId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Product> products = [];
            for (var doc in snapshot.data.docs) {
              products.add(Product(
                pName: doc[kProductName],
                pQuantity: doc[kProductQuantity],
                pCategory: doc[kProductCategory],
              ));
            }
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Container(
                        color: Color(kPurpleColor),
                        height: MediaQuery.of(context).size.height * 0.2,
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'product name : \$ ${products[index].pName}',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text('Quatity: ${products[index].pQuantity}',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                    'Category: \$ ${products[index].pCategory}',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    itemCount: products.length,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: ElevatedButton(
                        onPressed: () {},
                        child: Text('Confirm'),
                        style: ElevatedButton.styleFrom(
                            onPrimary: Colors.white,
                            primary: Color(kPurpleColor)),
                      )),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: ElevatedButton(
                        onPressed: () {},
                        child: Text('Delete'),
                        style: ElevatedButton.styleFrom(
                            onPrimary: Colors.white,
                            primary: Color(kPurpleColor)),
                      )),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return Center(child: Text('Loading...'));
          }
        },
      ),
    );
  }
}
