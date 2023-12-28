import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/pages/dashboard/productlist.dart';
import 'package:http/http.dart' as http;

class ProductCreate extends StatefulWidget {
  final formKey = GlobalKey<FormState>();
  final TextEditingController productNameCtrl = TextEditingController();
  final TextEditingController productPriceCtrl = TextEditingController();
  final TextEditingController productDescriptionCtrl = TextEditingController();

  ProductCreate({super.key});

  @override
  State<ProductCreate> createState() => _ProductCreateState();
}

class _ProductCreateState extends State<ProductCreate> {
  String? validateString(String? value) {
    if (value!.length < 8) {
      return "Minimal characters is 8";
    }
    return null;
  }

  String? validateNumber(String? value) {
    Pattern pattern = r'(?<=\s|^)\d+(?=\s|$)';
    RegExp regExp = RegExp(pattern.toString());
    if (!regExp.hasMatch(value!)) {
      return "Only number";
    }
    return null;
  }

  createProduct() async {
    const String apiUrl =
        "http://192.168.1.12/flutter-api/products/createProduct.php";
    return await http.post(
      Uri.parse(apiUrl),
      body: {
        "name": widget.productNameCtrl.text,
        "price": widget.productPriceCtrl.text,
        "description": widget.productDescriptionCtrl.text,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Product"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Form(
                key: widget.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      controller: widget.productNameCtrl,
                      validator: validateString,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                          labelText: "Enter product name"),
                      style:
                          const TextStyle(fontSize: 18, color: Colors.black87),
                    ),
                    const Padding(padding: EdgeInsets.only(bottom: 16)),
                    TextFormField(
                      controller: widget.productPriceCtrl,
                      validator: validateNumber,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          labelText: "Enter product price"),
                      style:
                          const TextStyle(fontSize: 18, color: Colors.black87),
                    ),
                    const Padding(padding: EdgeInsets.only(bottom: 16)),
                    TextFormField(
                      controller: widget.productDescriptionCtrl,
                      validator: validateString,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                          labelText: "Enter product description"),
                      style:
                          const TextStyle(fontSize: 18, color: Colors.black87),
                    ),
                    const Padding(padding: EdgeInsets.only(bottom: 16)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: GestureDetector(
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width / 3,
            alignment: Alignment.center,
            color: Colors.orange,
            child: const Text(
              "Create Product",
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          onTap: () {
            // proses creating product
            if (widget.formKey.currentState!.validate()) {
              createProduct();
              final mySnackbar = SnackBar(
                content: const Text("Success to create product"),
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
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const ProductList(),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
