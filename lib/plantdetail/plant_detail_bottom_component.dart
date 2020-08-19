import 'package:flutter/material.dart';

import '../data/plants.dart';

class Details extends StatelessWidget {
  final Plants plant;

  Details(this.plant);

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        plant.name,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(
                              height: 4,
                              width: 4,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.blue)),
                          Container(
                              margin: EdgeInsets.only(left: 8),
                              child: Text(
                                plant.plantType,
                                style: TextStyle(color: Colors.blueGrey),
                              ))
                        ],
                      )
                    ]),
                Icon(Icons.favorite_border, size: 24, color: Colors.pink)
              ]),
          SizedBox(height: 24),
          Text(
            "Price",
            style: TextStyle(fontSize: 16),
          ),
          Text(
            "\$54",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 24),
          Text("Description", style: TextStyle(fontSize: 18)),
          SizedBox(height: 8),
          Flexible(
              child: SingleChildScrollView(
                  child: Padding(
                      padding: EdgeInsets.only(bottom: 64),
                      child: Text(plant.description + plant.description))))
        ]);
  }
}
