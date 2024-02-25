import 'package:waste_company/model/plastic.dart';

import '../core/fpdart.dart';

abstract class WasteManagementInterface {
  Future<List<Plastic>> getPlasticPost();
  FutureVoid updatePost(
      {required String plasticId, required Map<String, dynamic> updateFields});
  Future<List<Plastic>> getPlasticPostByCompanyId({required bool isCompleted});
  FutureVoid updateContributorsAnalytics({
    required String contributorsId,
    required Map<String, dynamic> updateFields,
  });

}
