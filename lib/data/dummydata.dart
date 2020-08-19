import 'package:equatable/equatable.dart';

class DummyData extends Equatable {
  final String name;

  DummyData(this.name);

  @override
  List<Object> get props => [name];
}
