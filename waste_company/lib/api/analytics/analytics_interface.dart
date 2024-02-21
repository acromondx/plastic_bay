import 'package:waste_company/api/core/fpdart.dart';
import 'package:waste_company/model/analytics.dart';

abstract class AnalyticsInterface {
  Future<Analytics> getAnalytics();
  FutureVoid updateAnalytics({required Map<String, dynamic> update});
  FutureVoid saveAnalytics({required Analytics analytics});
}
