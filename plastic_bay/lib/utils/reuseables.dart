import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geocoding/geocoding.dart';

Future<String> pickImage() async {
  final image = await ImagePicker().pickImage(source: ImageSource.gallery);
  return image!.path;
}

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
