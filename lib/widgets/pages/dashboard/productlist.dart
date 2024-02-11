// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/pages/dashboard/productcreate.dart';
import '../dashboard/models/productmodel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:confirm_dialog/confirm_dialog.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final String apiUrl =
      "http://192.168.1.12/flutter-api/products/getAllProducts.php";

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
                        confirmDismiss: (direction) async {
                          Future deleteProduct(context) async {
                            const String apiUrlDelete =
                                "http://192.168.1.12/flutter-api/products/deleteProduct.php";
                            await http.post(
                              Uri.parse(apiUrlDelete),
                              body: {
                                "id": productList[index]["id"],
                              },
                            );
                            setState(() {
                              getProductList().then((data) {
                                setState(() {
                                  productList = data;
                                });
                              });
                            });
                          }

                          Future showDeleteConfirm(BuildContext context) async {
                            if (await confirm(
                              context,
                              title: const Text("Confirm Delete"),
                              content: const Text("Are you sure to delete?"),
                              textOK: const Text("Yes"),
                              textCancel: const Text("Cancel"),
                            )) {
                              return deleteProduct(context);
                            }
                            return debugPrint("Cancel");
                          }

                          if (direction == DismissDirection.startToEnd) {
                            // proses delete
                            return await showDeleteConfirm(context);
                          } else if (direction == DismissDirection.endToStart) {
                            // form edit
                            TextEditingController productNameCtrl =
                                TextEditingController();
                            TextEditingController productPriceCtrl =
                                TextEditingController();
                            TextEditingController productDescriptionCtrl =
                                TextEditingController();
                            setState(() {
                              productNameCtrl.text =
                                  productList[index]["name"].toString();
                              productPriceCtrl.text =
                                  productList[index]["price"].toString();
                              productDescriptionCtrl.text =
                                  productList[index]["description"].toString();
                            });

                            Future updateProduct(context) async {
                              const String apiUrlUpdate =
                                  "http://192.168.1.12/flutter-api/products/updateProduct.php";
                              await http.post(
                                Uri.parse(apiUrlUpdate),
                                body: {
                                  "id": productList[index]["id"],
                                  "name": productNameCtrl.text,
                                  "price": productPriceCtrl.text,
                                  "description": productDescriptionCtrl.text,
                                },
                              );
                              setState(() {
                                getProductList().then((data) {
                                  setState(() {
                                    productList = data;
                                  });
                                });
                              });
                            }

                            return await showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text(
                                      "Edit Product with ID: ${productList[index]["id"]}"),
                                  backgroundColor: Colors.grey.shade200,
                                  actions: <Widget>[
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        alignment: Alignment.center,
                                        backgroundColor: Colors.grey,
                                      ),
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: const Text(
                                        "Cancel",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        alignment: Alignment.center,
                                        backgroundColor: Colors.blue,
                                      ),
                                      onPressed: () {
                                        updateProduct(context);
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text(
                                        "Update",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                  content: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Form(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            TextFormField(
                                              controller: productNameCtrl,
                                              keyboardType: TextInputType.text,
                                              decoration: const InputDecoration(
                                                  labelText:
                                                      "Enter product name"),
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.black87),
                                            ),
                                            const Padding(
                                                padding: EdgeInsets.only(
                                                    bottom: 16)),
                                            TextFormField(
                                              controller: productPriceCtrl,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: const InputDecoration(
                                                  labelText:
                                                      "Enter product price"),
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.black87),
                                            ),
                                            const Padding(
                                                padding: EdgeInsets.only(
                                                    bottom: 16)),
                                            TextFormField(
                                              controller:
                                                  productDescriptionCtrl,
                                              keyboardType: TextInputType.text,
                                              decoration: const InputDecoration(
                                                  labelText:
                                                      "Enter product description"),
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.black87),
                                            ),
                                            const Padding(
                                                padding: EdgeInsets.only(
                                                    bottom: 16)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          }
                        },
                        child: ListTile(
                          leading: Image(
                            image: NetworkImage(
                              productList[index]["image_path"],
                            ),
                            fit: BoxFit.cover,
                          ),
                          title: Text(
                            productList[index]["name"].toString(),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          subtitle: Text(
                            "IDR ${productList[index]["price"].toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => "${m[1]}.")}",
                          ),
                          onTap: () {
                            debugPrint(productList[index]["name"]);
                            // membuka detail product
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (context) {
                                return Wrap(
                                  alignment: WrapAlignment.center,
                                  children: <Widget>[
                                    // ignore: sized_box_for_whitespace
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              3,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          SizedBox(
                                            width: 60,
                                            height: 60,
                                            child: Image(
                                              image: NetworkImage(
                                                productList[index]
                                                    ["image_path"],
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Text(
                                            productList[index]["name"]
                                                .toString(),
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            productList[index]["price"]
                                                .toString(),
                                            style: const TextStyle(
                                              fontSize: 15,
                                            ),
                                          ),
                                          Text(
                                            productList[index]["description"]
                                                .toString(),
                                            style: const TextStyle(
                                              fontSize: 15,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
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
