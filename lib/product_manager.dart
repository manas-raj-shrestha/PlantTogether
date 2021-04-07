import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './products.dart';
import './product_controller.dart';

class ProductManager extends StatefulWidget {
  // final List<String> startingProduct;

  // ProductManager();

  @override
  State<StatefulWidget> createState() {
    return _ProductManagerState();
  }
}

class _ProductManagerState extends State<ProductManager> {
  List _products;

  Future<String> _getData() async {
    // var response = await http.get("https://jsonplaceholder.typicode.com/posts");
    // print(response.body);
    // setState(() {
    //   _products = jsonDecode(response.body);
    // });
  }

  @override
  void initState() {
    // _products = widget.startingProduct;
    super.initState();
    _getData();
  }

  void _updateProduct(String product) {
    _getData();
    setState(() {
      // _products.add(product);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Expanded(
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: (_products == null) ? 0 : _products.length,
              itemBuilder: (BuildContext context, int index) {
                return Products(_products[index]);
              }))
    ]);
  }
}
