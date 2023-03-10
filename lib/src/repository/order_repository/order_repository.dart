import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class OrderRepository extends GetxController {
  static OrderRepository get instance => Get.find();

  final orderCollection = FirebaseFirestore.instance.collection('orders');

  Stream<QuerySnapshot<Map<String, dynamic>>> getOrdersSnapshots(String userId) {
    final orderDoc = orderCollection.doc(userId);
    final ordersCollection = orderDoc.collection('order');
    return ordersCollection.snapshots();
  }

  Future<void> getOrderProducts(String userId, String orderId) {
    final orderDoc = orderCollection.doc(userId);
    final ordersCollection = orderDoc.collection('order');
    final ordersDoc = ordersCollection.doc(orderId);
    final orderProductsCollection = ordersDoc.collection('orderProducts');
    return orderProductsCollection.get();
  }
}
