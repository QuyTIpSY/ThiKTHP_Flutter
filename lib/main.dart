import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thi_kthp/productlist_page.dart';
import 'package:thi_kthp/provider/product_provider.dart';

void main(){
  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context)=>ProductProvider()),
          ChangeNotifierProvider(create: (context)=>CountProvider()),
          ChangeNotifierProvider(create: (context)=>CountProvider2()),
        ],
      child: MaterialApp(
        home: ProductListPage(),
      ),
  ));
}