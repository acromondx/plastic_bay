import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:waste_company/model/plastic.dart';

import '../core/fpdart.dart';

abstract class WasteManagementInterface {
  Future<List<Plastic>> getPlasticPost({required GeoPoint currentLocation});
  FutureVoid updatePost({
    required Plastic plastic,
  });
}
