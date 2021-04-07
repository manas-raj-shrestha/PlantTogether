import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_flutter_app/data/plants.dart';

// import 'package:cloud_firestore/cloud_firestore.dart';

/// Uses firebase to manage repository for plants
class PlantsRepository {
  Future<List<Plants>> getPlantList() async {
    final databaseReference = FirebaseFirestore.instance;

    var documentsReference = await databaseReference.collection("plants").get();
    var documents = documentsReference.docs;

    return processData(documents);
  }

  List<Plants> processData(List<QueryDocumentSnapshot> snapshot) {
    List<Plants> plants = [];

    snapshot.forEach((f) {
      return plants.add(Plants(
          f.id,
          f["name"],
          f["description"],
          f["scientific_name"],
          f["image_url"],
          f["plant_type"],
          f["price"],
          f["size"],
          f["diameter"],
          f["humidity"],
          f["temperature"]));
    });

    return plants;
  }
}
