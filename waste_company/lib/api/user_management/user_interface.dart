import 'package:waste_company/api/core/fpdart.dart';
import 'package:waste_company/model/waste_company.dart';

abstract class UserManagementInterface {
  FutureVoid saveCredentials({required WasteCompany wasteCompany});
  FutureVoid updateCredentials({
    required String wasteCompanyId,
    required Map<String, dynamic> update,
  });
  Future<WasteCompany> getCredentials({required String wasteCompanyId});
}
