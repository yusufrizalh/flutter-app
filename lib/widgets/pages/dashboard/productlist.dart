import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/pages/dashboard/productcreate.dart';
import '../dashboard/models/productmodel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final String apiUrl =
      "http://192.168.1.6/flutter-api/products/getAllProducts.php";

  List<dynamic> productList = []; // nilai awal masih kosong
  final productModel = ProductModel();

  getProductList() async {
    try {
      var resp = await http.get(Uri.parse(apiUrl));
      if (resp.statusCode == 200) {
        var response = convert.json.decode(resp.body);
        if (response["status"] == "OK") {
          debugPrint("RESPONSE: ${resp.body}");
          List<dynamic> products = response["data"];
          return products;
        }
      } else {
        throw Exception("Error while getting all products");
      }
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  List<dynamic> productSearch = [];

  @override
  void initState() {
    super.initState();
    getProductList().then((data) {
      setState(() {
        productSearch = data;
        productList = productSearch;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product List"),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        strokeWidth: 3,
        onRefresh: () {
          return Future.delayed(
            const Duration(seconds: 3),
            () {
              setState(() {
                getProductList().then((data) {
                  setState(() {
                    productList = data;
                  });
                });
              });
              final mySnackbar = SnackBar(
                content: const Text("Success to refresh data"),
                backgroundColor: Colors.orange,
                elevation: 4,
                margin: const EdgeInsets.all(12),
                behavior: SnackBarBehavior.floating,
                showCloseIcon: true,
                closeIconColor: Colors.white,
                dismissDirection: DismissDirection.down,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                duration: const Duration(seconds: 3),
              );
              ScaffoldMessenger.of(context).showSnackBar(mySnackbar);
            },
          );
        },
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.all(12),
                child: TextField(
                  textInputAction: TextInputAction.search,
                  decoration: const InputDecoration(
                    hintText: "Search product name",
                    suffixIcon: Icon(Icons.search),
                  ),
                  onChanged: (keyword) {
                    setState(() {
                      productList = productSearch
                          .where((productFound) => productFound["name"]
                              .toLowerCase()
                              .contains(keyword.toLowerCase()))
                          .toList();
                    });
                  },
                ),
              ),
              Expanded(
                child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(4),
                  itemCount: productList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.all(8),
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.grey.shade200),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Dismissible(
                        key: Key("index_${productList[index]["id"]}"),
                        background: Container(
                          color: Colors.red,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 12),
                                child: Icon(Icons.delete, color: Colors.white),
                              ),
                              Text(
                                "Delete",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        secondaryBackground: Container(
                          color: Colors.blue,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                "Edit",
                                style: TextStyle(color: Colors.white),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 12),
                                child: Icon(Icons.edit, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        onDismissed: (direction) async {
                          if (direction == DismissDirection.startToEnd) {
                            // after delete
                          } else if (direction == DismissDirection.endToStart) {
                            // after edit
                          }
                        },
                        child: ListTile(
                          leading: const Icon(Icons.numbers),
                          title: Text(productList[index]["name"].toString()),
                          subtitle:
                              Text(productList[index]["price"].toString()),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ProductCreate(),
          ),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
