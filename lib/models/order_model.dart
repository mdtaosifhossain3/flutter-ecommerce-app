import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mini_ecommerce/models/address_model.dart';
import 'package:mini_ecommerce/utils/enums.dart';

class OrderModel {
  String? orderId;
  String? userId;
  DateTime? orderDate;
  List<Items>? items;
  double? totalAmount;
  OrderStatus? status;
  AddressModel? shippingAddress;
  PaymentMethod? paymentMethod;
  PaymentStatus? paymentStatus;

  OrderModel(
      {this.orderId,
      this.userId,
      this.orderDate,
      this.items,
      this.totalAmount,
      this.status,
      this.shippingAddress,
      this.paymentMethod,
      this.paymentStatus});

  OrderModel.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    userId = json['userId'];
    orderDate = (json['orderDate'] as Timestamp?)?.toDate();
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
    totalAmount = json['totalAmount'];
    status = OrderStatus.values.firstWhere((e) => e.name == json['status']);
    shippingAddress = json['shippingAddress'] != null
        ? AddressModel.fromJson(json['shippingAddress'])
        : null;
    paymentMethod =
        PaymentMethod.values.firstWhere((e) => e.name == json['paymentMethod']);
    paymentStatus =
        PaymentStatus.values.firstWhere((e) => e.name == json['paymentStatus']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['orderId'] = orderId;
    data['userId'] = userId;
    data['orderDate'] =
        orderDate != null ? Timestamp.fromDate(orderDate!) : null;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    data['totalAmount'] = totalAmount;
    data['status'] = status?.name;
    if (shippingAddress != null) {
      data['shippingAddress'] = shippingAddress!.toJson();
    }
    data['paymentMethod'] = paymentMethod?.name;
    data['paymentStatus'] = paymentStatus?.name;
    return data;
  }
}

class Items {
  String? productId;
  String? productName;
  int? quantity;
  double? price;

  Items({this.productId, this.productName, this.quantity, this.price});

  Items.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    productName = json['productName'];
    quantity = json['quantity'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productId'] = productId;
    data['productName'] = productName;
    data['quantity'] = quantity;
    data['price'] = price;
    return data;
  }
}

class ShippingAddress {
  String? street;
  String? city;
  String? state;
  String? zipCode;
  String? country;

  ShippingAddress(
      {this.street, this.city, this.state, this.zipCode, this.country});

  ShippingAddress.fromJson(Map<String, dynamic> json) {
    street = json['street'];
    city = json['city'];
    state = json['state'];
    zipCode = json['zipCode'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['street'] = street;
    data['city'] = city;
    data['state'] = state;
    data['zipCode'] = zipCode;
    data['country'] = country;
    return data;
  }
}
