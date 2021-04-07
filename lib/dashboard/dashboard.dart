import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_flutter_app/authentication_service.dart';
import 'package:first_flutter_app/blocs/cubit/plantscubit_cubit.dart';
import 'package:first_flutter_app/repositories/PlantsRepo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils.dart';
import '../simple_tab.dart';
import '../data/plants.dart';
import 'tab_content.dart';

class Dashboard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DashboardState();
  }
}

class _DashboardState extends State<Dashboard> {
  int currentTabIndex = 0;
  var plants = [];
  final Widget svgIcon = Container();
  bool isWeb = true;
  // SvgPicture.asset("assets/flower.svg", height: 36, width: 36);

  void processData(QuerySnapshot snapshot) {
    List<Plants> plants = [];

    snapshot.docs.forEach((doc) {
      return plants.add(Plants(
          doc.id,
          doc["name"],
          doc["description"],
          doc["scientific_name"],
          doc["image_url"],
          doc["plant_type"],
          doc["price"],
          doc["size"],
          doc["diameter"],
          doc["humidity"],
          doc["temperature"]));
    });

    // setState(() {
    //   this.plants.addAll(plants);
    // });
  }

  @override
  void initState() {
    super.initState();

    // print(DotEnv().env['VAR_NAME']);

    FirebaseFirestore.instance
        .collection('plants')
        .get()
        .then((QuerySnapshot querySnapshot) {
      this.processData(querySnapshot);
    });

    // final databaseReference = FirebaseFirestore.instance;
    // var a = databaseReference.collection("plants");

    // print(a == null);

    // a.get().then((value) => print(value.docs.length));
    // .get()
    // .then((snapshot) => {this.processData(snapshot)});
  }

  Widget getTabSpecificContent(plants) {
    print("${plants[2].plantType} gettabspecific");
    switch (currentTabIndex) {
      case 1:
        return TabContent(
            plants.where((element) => element.plantType == "outdoor").toList());
      case 2:
        return TabContent(
            plants.where((element) => element.plantType == "indoor").toList());
      case 3:
        return TabContent(plants
            .where((element) => element.plantType == "seasonal")
            .toList());
      default:
        return TabContent(plants);
    }
  }

  onTabChanged(int position) {
    setState(() {
      this.currentTabIndex = position;
    });
  }

  Widget getTipWidget() {
    return ClipRRect(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20)),
        child: Container(
            color: Color(parseColor("#f9eaca")),
            child: Padding(
                padding: EdgeInsets.fromLTRB(16, 28, 16, 28),
                child: Row(
                  children: <Widget>[
                    Image.network(
                        'https://dy1yydbfzm05w.cloudfront.net/media/catalog/product/cache/39b52c4cabb46819553175347e38b212/f/l/flowerbx-plants-product-areca-palm-1000px-2_1.jpg',
                        height: 52,
                        width: 52),
                    SizedBox(width: 8),
                    Flexible(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Find out more about Erica palm",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Container(
                            height: 50,
                            child: Text(
                              "The areca palm, otherwise known as butterfly palm, golden cane palm, bamboo palm, or its Latin name, Dypsis lutescens, is a native of Madagascar. Areca palms require bright, indirect light, but direct sunlight may burn the leaves. Home temperatures between 60°F (16°C) to 75°F (24°C) are fine, but sudden temperature drops or cold drafts can lead to brown spots on the leaves. Indoors, expect this plant to get 6 to 10 feet (2 to 3 meters) tall.",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.normal),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            )),
                      ],
                    )),
                  ],
                ))));
  }

  Widget getGreetingView() {
    int hour = TimeOfDay.now().hour;
    String greetingText;

    if (hour >= 0 && hour < 12) {
      greetingText = "Morning";
    } else if (hour >= 12 && hour < 17) {
      greetingText = "Afternoon";
    } else if (hour >= 17 && hour < 19) {
      greetingText = "Evening";
    } else {
      greetingText = "Evening";
    }

    return Container(
        child:
            Row(crossAxisAlignment: CrossAxisAlignment.end, children: <Widget>[
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Good",
            style: TextStyle(fontSize: 32),
          ),
          Text(
            greetingText,
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      Container(child: svgIcon, margin: EdgeInsets.only(left: 8))
    ]));
  }

  @override
  Widget build(BuildContext context) {
    // final plantsCubit = context.bloc<PlantscubitCubit>();
    // plantsCubit.getWeather();
    print("calling fetch");
    // plantsBloc.add(FetchPlants());

    return Scaffold(
        backgroundColor: Color(parseColor("#F8F8F8")),
        body: BlocProvider<PlantscubitCubit>(
            create: (BuildContext context) {
              return PlantscubitCubit(PlantsRepository());
            },
            child: Stack(children: <Widget>[
              SingleChildScrollView(
                child: Container(
                    margin: EdgeInsets.fromLTRB(16.w, 56.h, 16.w, 80.h),
                    child: Column(
                      children: <Widget>[
                        getGreetingView(),
                        SizedBox(height: 36.h),
                        getTipWidget(),
                        Container(
                            margin: EdgeInsets.fromLTRB(0, 16.h, 0, 16.h),
                            child: SimpleTab(
                                ["All", "Outdoor", "Indoor", "Seasonal"],
                                currentTabIndex,
                                onTabChanged)),
                        BlocBuilder<PlantscubitCubit, PlantscubitState>(
                            builder: (context, state) {
                          if (state is PlantsAreLoaded) {
                            return getTabSpecificContent(state.getPlants());
                          }
                          return Text("What is this?");
                        }),
                      ],
                    )),
              ),
              getBottomNavBar()
            ])));
  }

  Widget getIcon(iconAsset, color, double size) {
    if (!isWeb) {
      iconAsset = "assets/$iconAsset";
    }
    return SvgPicture.asset(
      iconAsset,
      height: size,
      width: size,
      color: (color != null) ? color : Colors.black,
    );
  }

  Widget getBottomNavBar() {
    return Align(
        alignment: Alignment.bottomLeft,
        child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(16),
                    topLeft: Radius.circular(16))),
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 16.h, 0, 16.h),
              child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    getIcon("compass.svg", Color(parseColor("#67b666")), 24),
                    getIcon("cloud.svg", null, 24),
                    Stack(
                      children: <Widget>[
                        getIcon(
                            "hexagon.svg", Color(parseColor("#67b666")), 36),
                        Positioned.fill(
                            child: Padding(
                                padding: EdgeInsets.all(10),
                                child: getIcon("leaf.svg", Colors.white, 20)))
                      ],
                    ),
                    getIcon("heart.svg", null, 24),
                    GestureDetector(
                      child: getIcon("user.svg", null, 24),
                      onTap: () {
                        AuthenticationService().signOutUser();
                        Navigator.of(context).pushReplacementNamed('/login');
                      },
                    )
                  ]),
            )));
  }
}
