import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thi_kthp/detail_cart.dart';
import 'package:thi_kthp/model/product_model.dart';
import 'package:thi_kthp/provider/product_provider.dart';
import 'package:badges/badges.dart';

class ProductListPage extends StatelessWidget {
  ProductListPage({Key? key}) : super(key: key);
  late List<Products> _list = [];
  Products ctsp=new Products();

  bool showGrid=true;

  bool isMax = false;

  bool isMin = false;

  String category = "";

  double total=0;
  double tmp=0;
  final List<Products> listcart=[];
  num? id;
  var SearchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var productProvider = Provider.of<ProductProvider>(context);
    productProvider.getList();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildCategory(context),
              SizedBox(height: 20,), // tạo khoảng cách giữa các khối

              buildSearch(context),
              SizedBox(height: 20,),

              buildGridList(context),
              SizedBox(height: 20,),
              // showGrid? buildGridProducts(context):buildListProducts(context),
              showGrid
                  ? buildGridProducts(context, isMax, isMin)
                  : buildListProducts(context, isMax, isMin),
            ],
          ),
        ),
      ),
    );
  }

  buildCategory(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.blue,
                padding: const EdgeInsets.all(16.0),
                textStyle: const TextStyle(fontSize: 20),
              ),
              onPressed: () {
                category = "smartphones";
              },
              child: const Text("smartphones"),
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.blue,
                padding: const EdgeInsets.all(16.0),
                textStyle: const TextStyle(fontSize: 20),
              ),
              onPressed: () {
                category = "laptops";
              },
              child: const Text("laptops"),
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.blue,
                padding: const EdgeInsets.all(16.0),
                textStyle: const TextStyle(fontSize: 20),
              ),
              onPressed: () {
                category = "fragrances";
              },
              child: const Text('fragrances'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.blue,
                padding: const EdgeInsets.all(16.0),
                textStyle: const TextStyle(fontSize: 20),
              ),
              onPressed: () {
                category = "skincare";
              },
              child: const Text('skincare'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.blue,
                padding: const EdgeInsets.all(16.0),
                textStyle: const TextStyle(fontSize: 20),
              ),
              onPressed: () {
                category = "groceries";
              },
              child: const Text('groceries'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.blue,
                padding: const EdgeInsets.all(16.0),
                textStyle: const TextStyle(fontSize: 20),
              ),
              onPressed: () {
                category = "home-decoration";
              },
              child: const Text('home-decoration'),
            ),
          ],
        ),
      ),
    );
  }

  buildSearch(BuildContext context) {
    var productProvider = Provider.of<ProductProvider>(context);
    return Row(
      children: [
        SizedBox(
          width: 180,
          child: TextField(
            decoration: InputDecoration(
                hintText: "Search",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10))),
            controller: SearchController,
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.black,
            padding: const EdgeInsets.all(4.0),
            textStyle: const TextStyle(fontSize: 14),
          ),
          onPressed: () {
            isMax = true;
            isMin = false;
          },
          child: Icon(Icons.arrow_circle_down),

        ),
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.black,
            padding: const EdgeInsets.all(4.0),
            textStyle: const TextStyle(fontSize: 14),
          ),
          onPressed: () {
            isMin = true;
            isMax = false;
          },
          child: Icon(Icons.arrow_circle_up),
        ),
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.black,
            padding: const EdgeInsets.all(4.0),
            textStyle: const TextStyle(fontSize: 14),
          ),
          onPressed: () {
            category = "";
            SearchController.text = "";
          },
          child: Icon(Icons.house_outlined),
        ),
        Badge(
          badgeContent: Text('${productProvider.listcart.length}'),
          child: IconButton(
              onPressed: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: ((context) => (AddCart(
                //           listCart: productProvider.listcart,
                //         )))));
              },
              icon: const Icon(Icons.add_shopping_cart)),
        )
      ],
    );
  }

  buildListProducts(BuildContext context, bool isMax, bool isMin) {
    var productProvider = Provider.of<ProductProvider>(context);
    productProvider.getList();
    //_list = productProvider.list;
    if (category != "") {
      productProvider.list
          .retainWhere((element) => element.category == category);
    }

    if (SearchController.text != "") {
      productProvider.list.retainWhere((element) => (element.category!
          .toLowerCase()
          .contains(SearchController.text.toLowerCase()) ||
          element.title!
              .toLowerCase()
              .contains(SearchController.text.toLowerCase())));
    }

    if (isMax) {
      productProvider.list
          .sort((a, b) => b.price!.toDouble().compareTo(a.price!.toDouble()));
    }
    if (isMin) {
      productProvider.list
          .sort((a, b) => a.price!.toDouble().compareTo(b.price!.toDouble()));
    }
    return Expanded(
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            ...productProvider.list.map((e) {
              return Padding(
                padding:
                const EdgeInsets.only(left: 4.0, right: 4, top: 4, bottom: 6),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Color.fromARGB(255, 255, 193, 68))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      OutlinedButton(
                          onPressed: (){
                            // title=(e.title).toString();
                            // thumbnail=(e.thumbnail).toString();
                            // price=(e.price);
                            // description=(e.description).toString();
                            ctsp=e;
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>buildDetailProduct(context)));
                          },
                          child: Image.network(e.thumbnail??"", width: 100, height: 100,)),
                      TextButton(
                        onPressed: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: ((context) => (DetailProduct(
                          //           obj: e,
                          //         )))));
                        },
                        child: Text(
                          e.title ?? 'Title NULL',
                          style: const TextStyle(
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      // ignore: prefer_interpolation_to_compose_strings
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.price_change_outlined),
                              Text(e.price.toString()??""),
                            ],
                          ),
                        ],
                      ),
                      TextButton(
                          onPressed: () {
                            // productProvider.getList();
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: ((context) => (AddCart(
                            //           listCart: productProvider.listCart,
                            //         )))));
                          },
                        child: Text("🛒 Add to cart",))
                    ],
                  ),
                ),
              );
            }).toList()
          ],
        ));
  }

  buildGridProducts(BuildContext context, bool isMax, bool isMin) {
    var productProvider = Provider.of<ProductProvider>(context);
    productProvider.getList();
    //_list = productProvider.list;
    if (category != "") {
      productProvider.list
          .retainWhere((element) => element.category == category);
    }

    if (SearchController.text != "") {
      productProvider.list.retainWhere((element) => (element.category!
          .toLowerCase()
          .contains(SearchController.text.toLowerCase()) ||
          element.title!
              .toLowerCase()
              .contains(SearchController.text.toLowerCase())));
    }

    if (isMax) {
      productProvider.list
          .sort((a, b) => b.price!.toDouble().compareTo(a.price!.toDouble()));
    }
    if (isMin) {
      productProvider.list
          .sort((a, b) => a.price!.toDouble().compareTo(b.price!.toDouble()));
    }
    return Expanded(
        child: GridView.count(
          crossAxisCount: 2,
          children: [
            ...productProvider.list.map((e) {
              return Padding(
                padding:
                const EdgeInsets.only(left: 3, right: 3, top: 0, bottom: 2),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Color.fromARGB(255, 255, 193, 68))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      OutlinedButton(
                          onPressed: (){
                            ctsp=e;
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>buildDetailProduct(context)));
                          },
                          child: Image.network(e.thumbnail??"", width: 100, height: 100,)),
                      TextButton(
                        onPressed: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: ((context) => (DetailProduct(
                          //           obj: e,
                          //         )))));
                        },
                        child: Text(
                          e.title ?? 'Title NULL',
                          style: const TextStyle(
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      // ignore: prefer_interpolation_to_compose_strings
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.price_change_outlined),
                              Text(e.price.toString()??""),
                            ],
                          ),
                        ],
                      ),
                      TextButton(
                          onPressed: () {
                            productProvider.getListCart(e);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => (AddCart(
                                      listCart: productProvider.listcart,
                                    )))));
                          },
                        child: Text("🛒 Add to cart",))
                    ],
                  ),
                ),
              );
            }).toList()
          ],
        ));
  }

  buildGridList(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            IconButton(onPressed: (){
              showGrid=true;
            }, icon: Icon(Icons.grid_on)),
            IconButton(onPressed: (){
              showGrid=false;
            }, icon: Icon(Icons.list_alt)),
          ],
        )
      ],
    );
  }

  buildCartPage(BuildContext context) {
    var productProvider = Provider.of<ProductProvider>(context);
    productProvider.getList();
    return Scaffold(
      appBar: AppBar(
        title: Text('Quay lại'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Expanded(
            child: ListView(
              children: [
                ...listcart.map((e) {
                  return Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.network(e.thumbnail??"", width: 100, height: 100,),
                        Expanded(
                          child: Column(
                            children: [
                              Text((e.title.toString())),
                              Row(
                                children: [
                                  Icon(Icons.price_change_outlined),
                                  Text(e.price.toString()??""),
                                ],
                              ),

                              Row(
                                children: [
                                  TextButton(onPressed: (){
                                    context.read<CountProvider>().sub();
                                  }, child: Text('➖')),


                                  Text(context.watch<CountProvider>().count.toString()),

                                  IconButton(onPressed: (){
                                    context.read<CountProvider>().add();
                                  }, icon: Icon(Icons.add)),
                                ],
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                  );
                }

                ),
                SizedBox(height: 40,),
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Total: ', style: TextStyle(fontWeight: FontWeight.bold),),
                          Text('$total'),
                          Icon(Icons.attach_money)
                        ],
                      ),
                      ElevatedButton(onPressed: (){}, child: Text("Check out", style: TextStyle(fontWeight: FontWeight.bold),))
                    ]),
              ],
            ),
          )
      ),
    );
  }

  buildDetailProduct(BuildContext context) {
    // final args=ModalRoute.of(context)!.settings.arguments as ImageModel;
    return Scaffold(
      appBar: AppBar(
          title: Text('Quay lại')
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildImage(context),
            SizedBox(height: 30,), // tạo khoảng cách giữa các khối

            buildDetail(context),
            SizedBox(height: 30,),
          ],
        ),
      ),
    );
  }

  buildImage(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.network(ctsp.thumbnail.toString(), width: 2000, height: 250,),
      ],
    );
  }

  buildDetail(BuildContext context) {
    var productProvider = Provider.of<ProductProvider>(context);
    productProvider.getList();
    return Expanded(
      child: Scaffold(
        body: Column(
          children: [
            Text(ctsp.title.toString(),style: TextStyle(fontWeight: FontWeight.bold),),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.price_change_outlined,),
                Text(ctsp.price.toString()),
              ],
            ),
            SizedBox(height: 10,),
            Text(ctsp.description.toString(),),
            SizedBox(height: 30,),
            ElevatedButton(
                onPressed: (){
                  productProvider.getListCart(ctsp);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => (AddCart(
                            listCart: productProvider.listcart,
                          )))));

                  var snackbar=SnackBar(
                      content: Row(
                        children: [
                          Icon(Icons.add_shopping_cart, color: Colors.white,),
                          Text('${productProvider.listcart.length}', style: TextStyle(fontWeight: FontWeight.bold)),
                          Text(' Susscess', style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      )
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackbar);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightGreen[400],
                  padding: EdgeInsets.fromLTRB(20, 14, 20, 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text("🛒 Add to cart", )
            )
          ],
        ),
      ),
    );
  }
}