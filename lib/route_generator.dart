import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './plantdetail/plants_detail.dart';
import './landing.dart';
import 'blocs/cubit/plantscubit_cubit.dart';
import 'dashboard/dashboard.dart';
import './signup/sign_up.dart';
import './login/login.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/landing':
        return MaterialPageRoute(builder: (_) => Landing());
      case '/dashboard':
        return MaterialPageRoute(
            builder: (_) => BlocProvider<PlantscubitCubit>(
                create: (BuildContext context) {
                  return PlantscubitCubit(PlantsNotLoaded());
                },
                child: Dashboard()));
      case '/signup':
        return MaterialPageRoute(builder: (_) => SignUp());
      case '/login':
        return MaterialPageRoute(builder: (_) => Login());
      case '/detail':
        return MaterialPageRoute(builder: (_) => PlantDetail(plant: args));
    }
  }
}
