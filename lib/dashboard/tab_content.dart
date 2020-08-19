import 'package:flutter/material.dart';

import '../data/plants.dart';

class TabContent extends StatelessWidget {
  final List<Plants> plants;

  TabContent(this.plants);

  @override
  Widget build(BuildContext context) {
    print("${plants} tab content");

    return Container(
        height: 310,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: false,
            itemCount: this.plants != null ? this.plants.length : 0,
            itemBuilder: (BuildContext context, int index) {
              Plants plant = this.plants[index];

              return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: Stack(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(4),
                        child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/detail',
                                  arguments: plant);
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Image.network(
                                  plant.imageUrl,
                                  height: 200,
                                  width: 250,
                                  fit: BoxFit.cover,
                                ),
                                Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          plant.name,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Container(
                                                height: 4,
                                                width: 4,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.blue)),
                                            Container(
                                                margin:
                                                    EdgeInsets.only(left: 8),
                                                child: Text(
                                                  plant.plantType,
                                                  style: TextStyle(
                                                      color: Colors.blueGrey),
                                                ))
                                          ],
                                        ),
                                        Container(
                                            margin: EdgeInsets.only(top: 16),
                                            child: Text(
                                              '\$58',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.blueGrey),
                                            ))
                                      ],
                                    ))
                              ],
                            )),
                      ),
                      Positioned(
                          top: 16,
                          right: 16,
                          child: Icon(Icons.favorite,
                              size: 24, color: Colors.pink))
                    ],
                  ));
            }));
  }
}
