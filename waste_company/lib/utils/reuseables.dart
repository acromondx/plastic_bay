import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:map_launcher/map_launcher.dart';

Future<String> getStreetAddress(GeoPoint point) async {
  try {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(point.latitude, point.longitude);

    if (placemarks.isNotEmpty) {
      Placemark place = placemarks[0];

      return place.street ?? 'Address not found';
    } else {
      return 'No address found';
    }
  } catch (e) {
    return 'No address found';
  }
}

Future<void> getDirection(
    {required GeoPoint point, required String address}) async {
  if (Platform.isAndroid) {
    final mapAvailable = await MapLauncher.isMapAvailable(MapType.google);
    if (mapAvailable!) {
      return await MapLauncher.showMarker(
        mapType: MapType.google,
        coords: Coords(point.latitude, point.longitude),
        title: address,
        description: 'Follow the direction to pick up location',
      );
    }
  } else if (Platform.isIOS) {
    final mapAvailable = await MapLauncher.isMapAvailable(MapType.apple);
    if (mapAvailable!) {
      return await MapLauncher.showMarker(
        mapType: MapType.apple,
        coords: Coords(point.latitude, point.longitude),
        title: address,
        description: 'Follow the direction to pick up location',
      );
    }
  }
}

DateTime parseDateString(String dateString) {
  Map<String, int> monthNames = {
    'January': 1,
    'February': 2,
    'March': 3,
    'April': 4,
    'May': 5,
    'June': 6,
    'July': 7,
    'August': 8,
    'September': 9,
    'October': 10,
    'November': 11,
    'December': 12,
  };

  List<String> dateAndTime = dateString.split(' ');

  int day = int.parse(dateAndTime[0].replaceAll(RegExp(r'\D'), ''));
  int month = monthNames[dateAndTime[1].replaceAll(',', '')]!;
  int year = int.parse(dateAndTime[2]);

  String timeString = dateAndTime[3];
  String meridiem = dateAndTime[4].toLowerCase();
  List<String> timeComponents = timeString.split(':');
  int hour = int.parse(timeComponents[0]);
  int minute = int.parse(timeComponents[1]);

  if (meridiem == 'pm' && hour != 12) {
    hour += 12;
  } else if (meridiem == 'am' && hour == 12) {
    hour = 0;
  }

  return DateTime(year, month, day, hour, minute);
}

extension DateTimeFormatter on DateTime {
  String toOrdinalDate() {
    String daySuffix(int day) {
      if (!(day >= 1 && day <= 31)) {
        throw Exception('Illegal day of month: $day');
      }

      if (day >= 11 && day <= 13) {
        return 'th';
      }

      switch (day % 10) {
        case 1:
          return 'st';
        case 2:
          return 'nd';
        case 3:
          return 'rd';
        default:
          return 'th';
      }
    }

    var formatter = DateFormat('d MMMM, y');
    String formattedDate = formatter.format(this);

    String suffix = daySuffix(day);
    String dayWithSuffix = '$day$suffix';
    formattedDate = formattedDate.replaceFirst('$day', dayWithSuffix);

    return formattedDate;
  }
}
