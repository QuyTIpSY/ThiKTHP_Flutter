import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thi_kthp/model/product_model.dart';
import 'package:thi_kthp/provider/product_provider.dart';

class ProductListPage extends StatelessWidget {
  ProductListPage({Key? key}) : super(key: key);
  String? image;
  String? title;
  num? price;
  String? description;
  bool showGrid=true;

  double total=0;
  double tmp=0;
  List<ProductModel> listcart=[];
  num? id;

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

              // buildSearch(context),
              // SizedBox(height: 20,),
              //
              // buildGridList(context),
              // SizedBox(height: 20,),
              // showGrid? buildGridProducts(context):buildListProducts(context),
            ],
          ),
        ),
      ),
    );
  }

  buildCategory(BuildContext context, ProductModel p) {
    var productProvider = Provider.of<ProductProvider>(context);
    productProvider.getList();
    return Container(
        width: double.infinity,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...productProvider.list.map((e) {
                return Container(
                  margin: EdgeInsets.all(10),
                  child: TextButton(onPressed: (){}, child: Text(p.products?.id.toString()),),

                ); // Text(e.title ?? "Title is null");
              }).toList()
            ],
          ),
        )
    );
  }

  // buildSearch(BuildContext context) {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     children: [
  //       Expanded(
  //         child: Container(
  //             width: 240,
  //             child: TextFormField(
  //               decoration: InputDecoration(
  //                   hintText: "Search",
  //                   prefixIcon: Icon(Icons.search),
  //                   border: OutlineInputBorder(
  //                     borderRadius: BorderRadius.circular(10),
  //                   )
  //               ),
  //             )
  //         ),
  //       ),
  //       Row(
  //         children: [
  //           IconButton(onPressed: (){}, icon: Icon(Icons.arrow_circle_down)),
  //           IconButton(onPressed: (){}, icon: Icon(Icons.arrow_circle_up)),
  //           IconButton(onPressed: (){}, icon: Icon(Icons.filter_alt_outlined)),
  //         ],
  //       ),
  //       ElevatedButton(
  //         onPressed: (){
  //           // Navigator.push(context, MaterialPageRoute(builder: (context)=>buildCartPage(context)));
  //         },
  //         style: ElevatedButton.styleFrom(
  //           backgroundColor: Colors.lightBlue,
  //           padding: EdgeInsets.fromLTRB(20, 14, 20, 14),
  //           shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(20),
  //           ),
  //         ),
  //         child: Container(
  //           child: Row(
  //             children: [
  //               Icon(Icons.add_shopping_cart),
  //               Text("Cart ( ", style: TextStyle(fontWeight: FontWeight.bold),),
  //               Text(context.watch<CountProvider2>().count.toString(), style: TextStyle(fontWeight: FontWeight.bold)),
  //               Text(" )", style: TextStyle(fontWeight: FontWeight.bold),),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }
  //
  // buildListProducts(BuildContext context) {
  //   var productProvider = Provider.of<ProductProvider>(context);
  //   productProvider.getList();
  //   return Expanded(
  //     child: ListView(
  //       scrollDirection: Axis.vertical,
  //       children: [
  //         ...productProvider.list.map((e) {
  //           return Container(
  //             child: Row(
  //               children: [
  //                 OutlinedButton(
  //                     onPressed: (){
  //                       title=(e.product?.title).toString();
  //                       image=(e.product?.thumbnail).toString();
  //                       price=(e.product?.price);
  //                       description=(e.product?.description).toString();
  //                       Navigator.push(context, MaterialPageRoute(builder: (context)=>buildDetailProduct(context)));
  //                     },
  //                     child: Image.network(e.product?.thumbnail??"", width: 100, height: 100,)),
  //                 Expanded(
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //
  //                       Text(e.product?.title??"",),
  //                       Row(
  //                         children: [
  //                           Icon(Icons.price_change_outlined),
  //                           Text(e.product?.price.toString()??""),
  //                         ],
  //                       ),
  //                       ElevatedButton(
  //                           onPressed: (){
  //                             context.read<CountProvider2>().add();
  //                             // if(listcart!.contains(e)){
  //                             listcart.add(e);
  //                             // }
  //                           },
  //                           style: ElevatedButton.styleFrom(
  //                             backgroundColor: Colors.lightGreen[400],
  //                             padding: EdgeInsets.fromLTRB(20, 14, 20, 14),
  //                             shape: RoundedRectangleBorder(
  //                               borderRadius: BorderRadius.circular(20),
  //                             ),
  //                           ),
  //                           child: Text("🛒 Add to cart",)
  //                       )
  //                     ],
  //                   ),
  //                 ),
  //                 // SizedBox(height: 20,)
  //               ],
  //             ),
  //           );
  //         })
  //       ],
  //     ),
  //   );
  // }
  //
  // buildGridProducts(BuildContext context) {
  //   var productProvider = Provider.of<ProductProvider>(context);
  //   productProvider.getList();
  //   return Expanded(
  //     child: Scaffold(
  //       body: GridView.count(
  //         crossAxisCount: 2,
  //         mainAxisSpacing: 20,   // khoảng cách giữa 2 nhóm
  //         crossAxisSpacing: 20, // khoảng cách giữa 2 cột
  //         children: [
  //           ...productProvider.list.map((e) {
  //             return Column(
  //               children: [
  //                 OutlinedButton(
  //                     onPressed: (){
  //                       title=(e.product?.title).toString();
  //                       image=(e.product?.thumbnail).toString();
  //                       price=(e.product?.price);
  //                       description=(e.product?.description).toString();
  //                       id=e.product?.id;
  //
  //                       Navigator.push(context, MaterialPageRoute(builder: (context)=>buildDetailProduct(context)));
  //                     },
  //                     child: Image.network(e.product?.thumbnail??"", width: 100, height: 100,)),
  //                 Text(e.product?.title?? ""),
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   children: [
  //                     Icon(Icons.price_change_outlined,),
  //                     Text(e.product?.price.toString()??"",),
  //                   ],
  //                 ),
  //                 ElevatedButton(
  //                     onPressed: (){
  //                       context.read<CountProvider2>().add();
  //                       listcart.add(e);
  //                       // try{
  //                       //   listcart.forEach((element) {
  //                       //     if(element.id!=e.id)
  //                       //       listcart.add(e);
  //                       //   });
  //                       // }catch(e){
  //                       // }
  //                     },
  //                     style: ElevatedButton.styleFrom(
  //                       backgroundColor: Colors.lightGreen[400],
  //                       padding: EdgeInsets.fromLTRB(20, 14, 20, 14),
  //                       shape: RoundedRectangleBorder(
  //                         borderRadius: BorderRadius.circular(20),
  //                       ),
  //                     ),
  //                     child: Text("🛒 Add to cart",)
  //                 )
  //               ],
  //             ); // Text(e.title ?? "Title is null");
  //           }).toList()
  //         ],
  //       ),
  //     ),
  //   );
  // }
  //
  // buildGridList(BuildContext context) {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.start,
  //     children: [
  //       Row(
  //         children: [
  //           IconButton(onPressed: (){
  //             showGrid=true;
  //           }, icon: Icon(Icons.grid_on)),
  //           IconButton(onPressed: (){
  //             showGrid=false;
  //           }, icon: Icon(Icons.list_alt)),
  //         ],
  //       )
  //     ],
  //   );
  // }

  // buildCartPage(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text('Quay lại'),
  //     ),
  //     body: Padding(
  //         padding: const EdgeInsets.all(20.0),
  //         child: Expanded(
  //           child: ListView(
  //             children: [
  //               ...listcart.map((e) {
  //                 return Container(
  //                   child: Row(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     // mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                     children: [
  //                       Image.network(e.product?.thumbnail.toString(), width: 100, height: 100,),
  //                       Expanded(
  //                         child: Column(
  //                           children: [
  //                             Text((e.product?.title.toString())),
  //                             Row(
  //                               children: [
  //                                 Icon(Icons.price_change_outlined),
  //                                 Text(e.product?.price.toString()??""),
  //                               ],
  //                             ),
  //                             Row(
  //                               children: [
  //                                 TextButton(onPressed: (){
  //                                   context.read<CountProvider>().sub();
  //                                 }, child: Text('➖')),
  //
  //
  //                                 Text(context.watch<CountProvider>().count.toString()),
  //
  //                                 IconButton(onPressed: (){
  //                                   context.read<CountProvider>().add();
  //                                 }, icon: Icon(Icons.add)),
  //                               ],
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //
  //                     ],
  //                   ),
  //                 );
  //               }
  //
  //               ),
  //               SizedBox(height: 40,),
  //               Column(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   children: [
  //                     SizedBox(height: 20,),
  //                     Row(
  //                       mainAxisAlignment: MainAxisAlignment.center,
  //                       children: [
  //                         Text('Total: ', style: TextStyle(fontWeight: FontWeight.bold),),
  //                         Text('$total'),
  //                         Icon(Icons.attach_money)
  //                       ],
  //                     ),
  //                     ElevatedButton(onPressed: (){}, child: Text("Check out", style: TextStyle(fontWeight: FontWeight.bold),))
  //                   ]),
  //             ],
  //           ),
  //         )
  //     ),
  //   );
  // }

  // buildDetailProduct(BuildContext context) {
  //   // final args=ModalRoute.of(context)!.settings.arguments as ImageModel;
  //   return Scaffold(
  //     appBar: AppBar(
  //         title: Text('Quay lại')
  //     ),
  //     body: Padding(
  //       padding: const EdgeInsets.all(20.0),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           buildImage(context),
  //           SizedBox(height: 30,), // tạo khoảng cách giữa các khối
  //
  //           buildDetail(context),
  //           SizedBox(height: 30,),
  //         ],
  //       ),
  //     ),
  //   );
  // }
  //
  // buildImage(BuildContext context) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.center,
  //     children: [
  //       Image.network(image.toString(), width: 2000, height: 250,),
  //     ],
  //   );
  // }
  //
  // buildDetail(BuildContext context) {
  //   int tmp=context.watch<CountProvider2>().count + 1;
  //   return Expanded(
  //     child: Scaffold(
  //       body: Column(
  //         children: [
  //           Text(title.toString(),style: TextStyle(fontWeight: FontWeight.bold),),
  //           SizedBox(height: 10,),
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               Icon(Icons.price_change_outlined,),
  //               Text(price.toString()),
  //             ],
  //           ),
  //           SizedBox(height: 10,),
  //           Text(description.toString(),),
  //           SizedBox(height: 30,),
  //           ElevatedButton(
  //               onPressed: (){
  //                 context.read<CountProvider2>().add();
  //
  //                 var snackbar=SnackBar(
  //                     content: Row(
  //                       children: [
  //                         Icon(Icons.add_shopping_cart, color: Colors.white,),
  //                         Text('( $tmp )', style: TextStyle(fontWeight: FontWeight.bold)),
  //                         Text(' Susscess', style: TextStyle(fontWeight: FontWeight.bold)),
  //                       ],
  //                     )
  //                 );
  //                 ScaffoldMessenger.of(context).showSnackBar(snackbar);
  //               },
  //               style: ElevatedButton.styleFrom(
  //                 backgroundColor: Colors.lightGreen[400],
  //                 padding: EdgeInsets.fromLTRB(20, 14, 20, 14),
  //                 shape: RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.circular(20),
  //                 ),
  //               ),
  //               child: Text("🛒 Add to cart", )
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }
}