import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:first_flutter_app/data/dummydata.dart';
import 'package:first_flutter_app/data/plants.dart';
import 'package:first_flutter_app/repositories/PlantsRepo.dart';

class PlantEvents extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchPlants extends PlantEvents {
  FetchPlants() {
    print("Fetch called");
  }

  @override
  List<Object> get props => [];
}

class PlantState extends Equatable {
  @override
  List<Object> get props => [];
}

class PlantsAreLoaded extends PlantState {
  final DummyData _plantList;

  PlantsAreLoaded(this._plantList);

  @override
  List<Object> get props => [_plantList];

  DummyData getPlants() {
    return this._plantList;
  }
}

class PlantsNotLoaded extends PlantState {
  final DummyData _plantList = DummyData("Plants not loaded");

  @override
  List<Object> get props => [_plantList];

  DummyData getPlants() => this._plantList;
}

class PlantsBloc extends Bloc<PlantEvents, PlantState> {
  PlantsRepository plantsRepository;

  PlantsBloc(PlantState initialState, this.plantsRepository)
      : super(initialState);

  @override
  Stream<PlantState> mapEventToState(PlantEvents event) async* {
    if (event is FetchPlants) {
      try {
        // List<Plants> plants = await plantsRepository.getPlantList();
        // print(plants.toList());
        yield PlantsAreLoaded(DummyData("Plants Are Loaded"));
      } catch (e) {
        print("${e} error");
      }
    }
  }
}

final plantsBloc = PlantsBloc(PlantsNotLoaded(), PlantsRepository());
