import 'package:flutter/material.dart';

import '../data/plants.dart';
import '../utils.dart';
import './plant_detail_bottom_component.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../colors.dart';

class PlantDetail extends StatelessWidget {
  final Plants plant;

  PlantDetail({this.plant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(parseColor("#FFFFFF")),
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Color(parseColor(themeGreen))),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Stack(children: <Widget>[
          SingleChildScrollView(
            child: Container(
                child:
                    Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
                Container(),
                Expanded(
                    flex: 2,
                    child: Image.network(
                      plant.imageUrl,
                      fit: BoxFit.contain,
                    )),
                SizedBox(width: 16.w),
                Expanded(
                    flex: 1,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          getMiniInfoView(
                              'diameter.svg', plant.diameter, 'Diameter'),
                          SizedBox(height: 16.h),
                          getMiniInfoView('ruler.svg', plant.size, "Height"),
                          SizedBox(height: 16.h),
                          getMiniInfoView(
                              'humidity.svg', plant.humidity, 'Humidity'),
                          SizedBox(height: 16.h),
                          getMiniInfoView('temperature.svg', plant.temperature,
                              'Temperature'),
                          SizedBox(height: 16.h)
                        ]))
              ]),
              Container(margin: EdgeInsets.all(16.h), child: Details(plant))
            ])),
          ),
          getBuyButton(context)
        ]));
  }

  Widget getBuyButton(context) {
    return Container(
        alignment: Alignment.bottomCenter,
        width: MediaQuery.of(context).size.width,
        child: Padding(
            padding: EdgeInsets.only(bottom: 16, left: 48.w, right: 48.w),
            child: RaisedButton(
                onPressed: () {
                  // Navigator.of(context).pushNamed('');
                },
                color: Color(parseColor(themeGreen)),
                child: Padding(
                    padding: EdgeInsets.fromLTRB(36.w, 16.h, 36.w, 16.h),
                    child: Text(
                      "Buy Now",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    )),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)))));
  }

  getMiniInfoView(imageAsset, value, title) {
    return Row(children: <Widget>[
      Container(
          decoration: BoxDecoration(
              color: Color(parseColor("#e4f2e9")),
              border: Border.all(
                color: Color(parseColor(themeGreen)),
              ),
              borderRadius: new BorderRadius.circular(24.0)),
          child: Padding(
            padding: EdgeInsets.all(6),
            child: getIcon(
                imageAsset,
                Color(
                  parseColor(themeGreen),
                ),
                18),
          )),
      SizedBox(width: 10),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            value,
            style: TextStyle(
                fontSize: 16,
                color: Color(
                  parseColor(themeGreen),
                )),
          ),
          Text(title)
        ],
      )
    ]);
  }
}
