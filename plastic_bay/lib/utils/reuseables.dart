
import 'package:image_picker/image_picker.dart';

Future<String> pickImage()async{
  final image = await ImagePicker().pickImage(source: ImageSource.gallery);
  return image!.path;  
}