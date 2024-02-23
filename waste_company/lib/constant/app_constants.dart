import 'package:flutter/material.dart';
import 'package:waste_company/features/waste_management/screen/pick_ups.dart';

import '../features/analytics/screen/analytics_page.dart';
import '../features/waste_management/screen/feeds.dart';

List<Widget> screens = [
  const Feeds(),
  const PickUps(),
  const AnalyticsScreen()
];
