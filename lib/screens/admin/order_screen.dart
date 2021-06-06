import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopper/constants.dart';
import 'package:shopper/models/order.dart';
import 'package:shopper/screens/admin/order_details.dart';
import 'package:shopper/services/store.dart';

class OrderScreen extends StatelessWidget {
  static String id = 'OrderScreen';
  final Store _store = Store();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: _store.loadOrders(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: Text('No orders yet'),
              );
            } else {
              List<Order> orders = [];
              for (var doc in snapshot.data.docs) {
                orders.add(Order(
                  documentId: doc.id,
                  address: doc[kAddress],
                  totalPrice: doc[kTotalPrice],
                ));
              }
              return ListView.builder(
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.all(20.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, OrderDetails.id,arguments: orders[index].documentId);
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.2,
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            
                            Text(
                              'Total Price = \$ ${orders[index].totalPrice}',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text('Adress is: \$ ${orders[index].address}',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold))
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                itemCount: orders.length,
              );
            }
          }),
    );
  }
}
