
import 'package:plastic_bay/model/waste_contributor.dart';

import '../core/either.dart';

abstract class UserManagementInterface {
  FutureVoid saveContributorCredentials({
    required WasteContributor wasteContributor,
  });
  Future<WasteContributor> contributorDetails({
    required String wasteContributorId,
  });
  FutureVoid updateContributorDetails({
    required String wasteContributorId,
  });
  FutureVoid spendPoint({
    required String wasteContributorId,
    required double totalSpending,
  });
  Future<List<WasteContributor>> topContributors();
}