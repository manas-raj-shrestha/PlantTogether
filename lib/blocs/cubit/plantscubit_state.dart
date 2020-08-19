part of 'plantscubit_cubit.dart';

abstract class PlantscubitState extends Equatable {
  const PlantscubitState();
}

class PlantscubitInitial extends PlantscubitState {
  @override
  List<Object> get props => [];
}

class PlantsAreLoaded extends PlantscubitState {
  final List<Plants> _plantList;

  PlantsAreLoaded(this._plantList);

  @override
  List<Object> get props => [_plantList];

  List<Plants> getPlants() {
    print("get plants called");
    return this._plantList;
  }
}

class PlantsNotLoaded extends PlantscubitState {
  final List<Plants> _plantList = [];

  @override
  List<Object> get props => [_plantList];

  List<Plants> getPlants() => this._plantList;
}
