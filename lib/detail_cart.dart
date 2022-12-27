import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:thi_kthp/model/product_model.dart';
import 'package:thi_kthp/productlist_page.dart';

class AddCart extends StatefulWidget {
  final List<Products> listCart;
  const AddCart({
    super.key,
    required this.listCart,
  });

  @override
  State<AddCart> createState() => _AddCartState();
}

class _AddCartState extends State<AddCart> {
  @override
  Widget build(BuildContext context) {
    double tt = 0;
    widget.listCart.forEach(
          (element) {
        tt += (element.sl!.toDouble() * element.price!.toDouble());
      },
    );

    //print(listCart);
    return Scaffold(
      appBar: AppBar(
        title: Text('Quay lại'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Expanded(
            child: ListView(
            children: [
              SizedBox(
                  height: 30,
                  width: 414,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                  )),
              SizedBox(
                width: 400,
                height: 800,
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                      width: 414,
                    ),
                    ProductView(context),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 0, top: 12, right: 0, bottom: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Total: ",
                            style: TextStyle(fontSize: 30),
                          ),
                          Text('${tt.toStringAsFixed(0)}',
                              style: TextStyle(fontSize: 30)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SizedBox(
                        width: 400,
                        height: 50,
                        child: ElevatedButton(
                            onPressed: () {
                              widget.listCart.clear();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) =>
                                      (ProductListPage()))));
                            },
                            child: const Text(
                              "Check Out",
                              style:
                              TextStyle(fontSize: 20, color: Colors.white),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )
    );
  }

  BuildProduct(BuildContext context, num sl) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
      child: Text(
        '$sl',
        style: TextStyle(fontSize: 30),
        textAlign: TextAlign.center,
      ),
    );
  }

  ProductView(BuildContext context) {
    // double tt = 0;
    // widget.listCart.forEach(
    //       (element) {
    //     tt += (element.sl!.toDouble() * element.price!.toDouble());
    //   },
    // );
    var thanhtien=0;
    return Expanded(
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            ...widget.listCart.map((e) {
              num tt=e.price! * e.sl!;
              return Container(
                decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                          height: 80,
                          width: 80,
                          child: Image.network(e.thumbnail ?? "")),
                      SizedBox(
                        child: Row(
                          children: [
                            Text('Giá: '+e.price.toString()??""),
                            Icon(Icons.price_change_outlined),
                            Text('    '),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    e.sl = (e.sl! + 1);
                                    tt=e.price! * e.sl!;
                                  });

                                },
                                icon: Icon(Icons.add)),
                            Text('${e.sl}'),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    e.sl = (e.sl! - 1);
                                    if (e.sl! <= 0) {
                                      widget.listCart.remove(e);
                                    }
                                  });
                                  tt=e.price! * e.sl!;
                                },
                                icon: Icon(Icons.remove)),

                            Text('   Thành tiền: '+'${tt}'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList()
          ],
        ));
  }
}
