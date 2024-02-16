
import 'package:cloud_firestore_platform_interface/src/geo_point.dart';
import 'package:waste_company/api/core/fpdart.dart';
import 'package:waste_company/api/waste_management/waste_management_interface.dart';
import 'package:waste_company/model/plastic.dart';

class WasteManagementAPI implements WasteManagementInterface{
  @override
  Future<List<Plastic>> getPlasticPost({required GeoPoint currentLocation}) {
    // TODO: implement getPlasticPost
    throw UnimplementedError();
  }

  @override
  FutureVoid updatePost() {
    // TODO: implement updatePost
    throw UnimplementedError();
  }
  
}