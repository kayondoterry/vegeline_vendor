import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vegeline_vendor/models/order.dart';
import 'package:vegeline_vendor/models/order_status_detail.dart';
import 'package:vegeline_vendor/models/payment.dart';
import 'package:vegeline_vendor/models/product.dart';
import 'package:vegeline_vendor/models/vendor.dart';
import 'package:vegeline_vendor/models/vendor_product.dart';

class DBService {
  CollectionReference _vendorCollection =
      Firestore.instance.collection('vendors');

  CollectionReference _productCollection =
      Firestore.instance.collection('products');

  CollectionReference _vendorProductCollection =
      Firestore.instance.collection('vendor_products');

  CollectionReference _orderCollection =
      Firestore.instance.collection('orders');

  CollectionReference _paymentCollection =
      Firestore.instance.collection(('payments'));

  CollectionReference _adminCollection =
  Firestore.instance.collection('admin');

  // TODO: handle errors
  Future<void> addVendor(Vendor vendor) async {
    try {
      final vendorJson = vendor.toJson();
      final docRef = _vendorCollection.document(vendor.vendorId);
      await docRef.setData(vendorJson);
    } catch (e) {
      print('*****ERROR***** ${e.toString()}');
      throw e;
    }
  }

  // TODO: handle errors
  Future<Vendor> getVendor(String vendorId) async {
    try {
      final docRef = _vendorCollection.document(vendorId);
      final docSnap = await docRef.get();
      if (docSnap.data == null) return null;
      final vendorJson = docSnap.data;
      Vendor vendor = Vendor.fromJson({...vendorJson, 'vendorId': vendorId});
      return vendor;
    } catch (e) {
      print('*****ERROR***** ${e.toString()}');
      throw e;
    }
  }

  Future<int> getServiceRate() async{
    try {
      final docSnap = await _adminCollection.document('extraFeePercentage').get();
      return docSnap.data['value'] as int;

    } catch (e) {
      print('*****ERROR***** ${e.toString()}');
      throw e;
    }
  }

  Future<List<VendorProduct>> getVendorProductsByCategory(
      Vendor vendor, String category) async {
    try {
      final querySnap = await _vendorProductCollection
          .where('vendor.vendorId', isEqualTo: vendor.vendorId)
          .where('product.category', isEqualTo: category)
          .getDocuments();
      return querySnap.documents.map((docSnap) {
        return VendorProduct.fromJson({...docSnap.data});
      }).toList();
    } catch (e) {
      print('*****ERROR***** ${e.toString()}');
      throw e;
    }
  }

  Future<List<Product>> queryProductsByCategory(
      String queryText, String category) async {
    try {
      var query = _productCollection;
      if (queryText != null)
        query = query.where('searchTerms', arrayContains: queryText);
      if (category != null)
        query = query.where('category', isEqualTo: category);
      final querySnap = await query.getDocuments();
      return querySnap.documents.map((docSnap) {
        return Product.fromJson(
            {...docSnap.data, 'productId': docSnap.documentID});
      }).toList();
    } catch (e) {
      print('*****ERROR***** ${e.toString()}');
      throw e;
    }
  }

  Future<List<Product>> getAllAvailableProducts() async {
    try {
      final querySnap = await _productCollection.getDocuments();
      return querySnap.documents.map((docSnap) {
        return Product.fromJson(
            {...docSnap.data, 'productId': docSnap.documentID});
      }).toList();
    } catch (e) {
      print('*****ERROR***** ${e.toString()}');
      throw e;
    }
  }

  Stream<List<VendorProduct>> vendorProductsStream(Vendor vendor) {
    return _vendorProductCollection
        .where('vendor.vendorId', isEqualTo: vendor.vendorId)
        .snapshots()
        .map((snapshot) => snapshot.documents
            .map((docSnap) => VendorProduct.fromJson({...docSnap.data}))
            .toList());
  }

  Stream<List<VendorProduct>> vendorProductsByCategoryStream(
      Vendor vendor, String category) {
    return _vendorProductCollection
        .where('vendor.vendorId', isEqualTo: vendor.vendorId)
        .where('product.category', isEqualTo: category)
        .snapshots()
        .map((snapshot) => snapshot.documents
            .map((docSnap) => VendorProduct.fromJson({...docSnap.data}))
            .toList());
  }

  Stream<VendorProduct> singleVendorProductStream(String vendorProductID) {
    return _vendorProductCollection
        .document(vendorProductID)
        .snapshots()
        .map((docSnap) => VendorProduct.fromJson({...docSnap.data}));
  }

  // Stream<List<Order>> pendingOrderStreamForVendor(Vendor vendor) {
  //   return _orderCollection
  //       .where("vendorProduct.vendor.vendorId", isEqualTo: vendor.vendorId)
  //       .where('status', isEqualTo: OrderStatus.PENDING)
  //       .snapshots()
  //       .map((snapshot) {
  //     return snapshot.documents
  //         .map(
  //             (doc) => Order.fromJson({...doc.data, 'orderId': doc.documentID}))
  //         .toList();
  //   });
  // }

  // Stream<List<Order>> onGoingOrderStreamForVendor(Vendor vendor) {
  //   return _orderCollection
  //       .where("vendorProduct.vendor.vendorId", isEqualTo: vendor.vendorId)
  //       .where('status', isEqualTo: OrderStatus.ON_GOING)
  //       .snapshots()
  //       .map((snapshot) {
  //     return snapshot.documents
  //         .map(
  //             (doc) => Order.fromJson({...doc.data, 'orderId': doc.documentID}))
  //         .toList();
  //   });
  // }

  // Stream<List<Order>> completedOrderStreamForVendor(Vendor vendor) {
  //   return _orderCollection
  //       .where("vendorProduct.vendor.vendorId", isEqualTo: vendor.vendorId)
  //       .where('status', isEqualTo: OrderStatus.COMPLETED)
  //       .snapshots()
  //       .map((snapshot) {
  //     return snapshot.documents
  //         .map(
  //           (doc) => Order.fromJson({...doc.data, 'orderId': doc.documentID}),
  //         )
  //         .toList();
  //   });
  // }

  Future<void> updateOrderStatus(
    Order order,
    OrderStatusDetail orderStatusDetail,
  ) async {
    try {
      await Firestore.instance.runTransaction((tx) async {
        await tx.set(
          _orderCollection.document(order.orderId),
          {
            ...order.toJson(),
            'orderDate': Timestamp.fromDate(order.orderDate),
            'status': orderStatusDetail.status,
            'statusHistory': [
              ...order.statusHistory.map((s) => s.toJson()).toList(),
              orderStatusDetail.toJson()
            ]
          },
        );
      });
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<String> getFlutterWaveSecretKey()async{
    try{
      var data = await Firestore.instance.runTransaction((tx)async{
        final key = (await tx.get(_adminCollection.document("flutterWaveSecretKey"))).data["value"];
        await tx.set(_adminCollection.document("flutterWaveSecretKey"), {"value":key});
        return {"key": key};
      });
      return data["key"];
    }catch(e){
      throw e;
    }
  }

  Future<void> editLastOrderStatus(
      Order order,
      OrderStatusDetail orderStatusDetail,
      ) async {
    try {
      await Firestore.instance.runTransaction((tx) async {
        await tx.set(
          _orderCollection.document(order.orderId),
          {
            ...order.toJson(),
            'orderDate': Timestamp.fromDate(order.orderDate),
            'status': orderStatusDetail.status,
            'statusHistory': [
              ...order.statusHistory.map((s) => s.toJson()).toList(),
              orderStatusDetail.toJson()
            ]
          },
        );
      });
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Stream<Order> singleOrderStream(String orderId) {
    return _orderCollection
        .document(orderId)
        .snapshots(includeMetadataChanges: true)
        .where((snapshot) {
      print(snapshot.metadata.isFromCache);
      print(snapshot.data['statusHistory'].length);
      return snapshot.metadata.isFromCache == false;
    }).map(
      (doc) => Order.fromJson(
        {
          ...doc.data,
          'orderId': doc.documentID,
          'orderDate': _timeStampToDateTimeString(doc.data['orderDate']),
        },
      ),
    );
  }

  Stream<List<Product>> productsOnSaleForCategoryStream(String category) {
    return _productCollection
        .where("category", isEqualTo: category)
        .where("vendorCount", isGreaterThan: 0)
        .snapshots()
        .map((snapshot) => snapshot.documents
            .map((docSnap) => Product.fromJson(docSnap.data))
            .toList());
  }

  Stream<List<Order>> orderStreamForVendor(String vendorId) {
    return _orderCollection
        .where("vendorProduct.vendor.vendorId", isEqualTo: vendorId)
        .snapshots(includeMetadataChanges: true)
        .where((snapshot) {
      print(snapshot.metadata.isFromCache);
      return snapshot.metadata.isFromCache == false;
    }).map((snapshot) {
      return snapshot.documents
          .map(
            (doc) => Order.fromJson({
              ...doc.data,
              'orderId': doc.documentID,
              'orderDate': _timeStampToDateTimeString(doc.data['orderDate']),
            }),
          )
          .toList();
    });
  }

  String _timeStampToDateTimeString(Timestamp ts) {
    if (ts == null) return null;
    return ts.toDate().toIso8601String();
  }

  Stream<Payment> paymentStreamForOrder(Order order) {
    return _paymentCollection
        .document(order.orderId)
        .snapshots()
        .map((doc) => Payment.fromJson(doc.data));
  }

  Future<void> updateVendorProduct(VendorProduct vendorProduct) async {
    try {
      return await _vendorProductCollection
          .document(
              '${vendorProduct.vendor.vendorId}_${vendorProduct.product.productId}')
          .setData(vendorProduct.toJson());
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<void> addVendorProduct(VendorProduct vendorProduct) async {
    try {
      await Firestore.instance.runTransaction((tx) async {
        await tx.set(
            _vendorProductCollection.document(
                '${vendorProduct.vendor.vendorId}_${vendorProduct.product.productId}'),
            vendorProduct.toJson());

        await tx.update(
            _productCollection.document(vendorProduct.product.productId),
            {'vendorCount': FieldValue.increment(1)});
      });
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<void> deleteVendorProduct(VendorProduct vendorProduct) async {
    try {
      return await _vendorProductCollection
          .document(
              '${vendorProduct.vendor.vendorId}_${vendorProduct.product.productId}')
          .delete();
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
