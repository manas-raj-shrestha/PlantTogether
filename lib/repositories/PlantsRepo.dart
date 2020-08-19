import 'package:first_flutter_app/data/plants.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

/// Uses firebase to manage repository for plants
class PlantsRepository {
  Future<List<Plants>> getPlantList() async {
    final databaseReference = Firestore.instance;

    var documents = await databaseReference.collection("plants").getDocuments();
    return processData(documents);
  }

  List<Plants> processData(snapshot) {
    List<Plants> plants = [];

    snapshot.documents.forEach((f) {
      return plants.add(Plants(
          f.documentID,
          f.data["name"],
          f.data["description"],
          f.data["scientific_name"],
          f.data["image_url"],
          f.data["plant_type"],
          f.data["price"],
          f.data["size"],
          f.data["diameter"],
          f.data["humidity"],
          f.data["temperature"]));
    });

    return plants;
  }
}
