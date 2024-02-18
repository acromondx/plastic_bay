import 'package:intl/intl.dart';

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
