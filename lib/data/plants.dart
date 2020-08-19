import 'package:equatable/equatable.dart';

class Plants extends Equatable {
  final String documentId;
  final String size;
  final String imageUrl;
  final String name;
  final String scientificName;
  final String description;
  final String plantType;
  final int price;
  final String diameter;
  final String humidity;
  final String temperature;

  Plants(
      this.documentId,
      this.name,
      this.description,
      this.scientificName,
      this.imageUrl,
      this.plantType,
      this.price,
      this.size,
      this.diameter,
      this.humidity,
      this.temperature);

  @override
  // TODO: implement props
  List<Object> get props => [
        this.documentId,
        this.name,
        this.description,
        this.scientificName,
        this.imageUrl,
        this.plantType,
        this.price,
        this.size,
        this.diameter,
        this.humidity,
        this.temperature
      ];
}
