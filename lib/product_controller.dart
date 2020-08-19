import 'package:flutter/material.dart';

class ProductController extends StatelessWidget {
  final Function updateProduct;

  ProductController(this.updateProduct);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return RaisedButton(
      child: Text("Add Product"),
      onPressed: () {
        updateProduct("Mangos");
      },
    );
  }
}
