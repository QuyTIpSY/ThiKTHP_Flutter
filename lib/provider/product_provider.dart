import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:thi_kthp/model/product_model.dart';

class ProductProvider extends ChangeNotifier{
  List<ProductModel> list = [];

  void getList() async{  // async: bất đồng bộ
    // lấy ds sản phẩm từ fakestoreAPI
    String urlAPI="https://dummyjson.com/products";
    var client=http.Client();
    var rs = await client.get(Uri.parse(urlAPI)); // await: đợi vì đây là hàm bất đồng bộ
    var jsonString = rs.body;
    var jsonObject = jsonDecode(jsonString) as List; // parse sang json theo kiểu danh sách/mảng
    list = jsonObject.map((e) {  // duyệt hết ds rồi gán vào list
      return ProductModel(
        products: Products(
          id: e['products']['id'],
        )
      );
    }).toList();
    notifyListeners(); // thông báo đã lấy dữ liệu xong
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
