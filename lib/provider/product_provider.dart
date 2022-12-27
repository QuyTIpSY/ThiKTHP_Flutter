import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:thi_kthp/model/product_model.dart';

class ProductProvider extends ChangeNotifier{
  List<Products> listcart = [];
  List<dynamic> list = [];
  ProductModel p = ProductModel();

  void getList() async{  // async: bất đồng bộ
    // lấy ds sản phẩm từ fakestoreAPI
    String urlAPI="https://dummyjson.com/products";
    var client=http.Client();
    var rs = await client.get(Uri.parse(urlAPI)); // await: đợi vì đây là hàm bất đồng bộ
    var jsonString = rs.body;
    var jsonObject = jsonDecode(jsonString);
    var _jsonObject = jsonObject['products'];
    list = _jsonObject.map((e) {  // duyệt hết ds rồi gán vào list
      return Products(
        id: e['id'],
        title: e['title'],
        description: e['description'],
        price: e['price'],
        discountPercentage: e['discountPercentage'],
        rating: e['rating'],
        stock: e['stock'],
        thumbnail: e['thumbnail'],
        brand: e['brand'],
        category: e['category'],
      );
    }).toList();
    p.total = jsonObject['total'];
    p.skip = jsonObject['skip'];
    p.limit = jsonObject['limit'];

    notifyListeners(); // thông báo đã lấy dữ liệu xong
  }

  void getListCart(Products e) {
    if (listcart.isEmpty) {
      listcart.add(e);
    } else {
      int kt = 0;
      for (var element in listcart) {
        if (element.id == e.id) {
          kt = 1;
          element.sl = (element.sl! + 1);
          break;
        }
      }
      if (kt == 0) {
        listcart.add(e);
      }
    }

    notifyListeners();
  }
}

class CountProvider2 extends ChangeNotifier {
  int _count=0;
  int get count => _count;
  void add() {
    _count++;
    notifyListeners();
  }}

class CountProvider extends ChangeNotifier {
  int get count => _count;
  int _count=1;
  void add() {
    _count++;
    notifyListeners();
  }

  void sub(){
    _count--;
    if(count<0) {
      _count = 0;
    }
    notifyListeners();
  }
}
