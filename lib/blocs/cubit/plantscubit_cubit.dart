import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:first_flutter_app/data/dummydata.dart';
import 'package:first_flutter_app/data/plants.dart';
import 'package:first_flutter_app/repositories/PlantsRepo.dart';

part 'plantscubit_state.dart';

class PlantscubitCubit extends Cubit<PlantscubitState> {
  final plantsRepository;

  PlantscubitCubit(this.plantsRepository) : super(PlantsNotLoaded()) {
    getPlants();
  }

  Future<void> getPlants() async {
    try {
      List<Plants> plants = await plantsRepository.getPlantList();
      // print(plants.toList());
      emit(PlantsAreLoaded(plants));
      print("emmitted");

      // emit(WeatherLoading());
      // final weather = await _weatherRepository.fetchWeather(cityName);
      // emit(WeatherLoaded(weather));
    } catch (_) {
      // emit(WeatherError("Couldn't fetch weather. Is the device online?"));
    }
  }
}
