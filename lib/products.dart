import 'package:flutter/material.dart';

class Products extends StatelessWidget {
  var product;

  Products(this.product);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(children: <Widget>[
      Image.asset('assets/mango.jpg'),
      Text(product["title"])
    ]));
  }
}
