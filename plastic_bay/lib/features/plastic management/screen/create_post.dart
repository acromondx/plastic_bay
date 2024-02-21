import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:plastic_bay/features/plastic%20management/widgets/image_skeleton.dart';
import 'package:plastic_bay/features/plastic%20management/widgets/picked_image.dart';
import 'package:plastic_bay/utils/enums/plastic_type.dart';
import 'package:plastic_bay/utils/extensions/date_format.dart';
import 'package:plastic_bay/utils/loading_alert.dart';
import 'package:plastic_bay/utils/reuseables.dart';
import 'package:plastic_bay/utils/toast_message.dart';

import '../controller/plastic_management_controller.dart';
import '../widgets/post_text_field.dart';

class CreatePost extends ConsumerStatefulWidget {
  const CreatePost({super.key});

  @override
  ConsumerState<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends ConsumerState<CreatePost> {
  List<String> imagePathList = ['', '', ''];
  PlasticType initialPlasticType = PlasticType.ldpe;
  _uploadImage(int index) async {
    final imagePath = await pickImage();
    switch (index) {
      case 0:
        imagePathList.removeAt(index);
        imagePathList.insert(index, imagePath);
        break;
      case 1:
        imagePathList.removeAt(index);
        imagePathList.insert(index, imagePath);
        break;
      case 2:
        imagePathList.removeAt(index);
        imagePathList.insert(index, imagePath);
        break;
    }
    setState(() {});
  }

  DateTime pickUpDate = DateTime.now().add(const Duration(days: 1));
  TimeOfDay dayTime = TimeOfDay.now();
  final descriptionController = TextEditingController();
  final quantityController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final postController =
        ref.watch(plasticManagementControllerProvider.notifier);
    final postControllerState = ref.watch(plasticManagementControllerProvider);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Create Post'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: postControllerState
              ? const LoadingIndicator()
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      PostTextField(
                        hintText: 'Description',
                        controller: descriptionController,
                        maxLines: 3,
                      ),
                      const SizedBox(height: 20),
                      PostTextField(
                        hintText: 'Quantity e.g 0.5Kg',
                        keyboardType: TextInputType.number,
                        controller: quantityController,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                              onTap: () {
                                _uploadImage(0);
                              },
                              child: imagePathList[0].isEmpty
                                  ? const ImageSkeleton()
                                  : PickedImage(
                                      imagePath: imagePathList[0],
                                    )),
                          GestureDetector(
                              onTap: () {
                                _uploadImage(1);
                              },
                              child: imagePathList[1].isEmpty
                                  ? const ImageSkeleton()
                                  : PickedImage(
                                      imagePath: imagePathList[1],
                                    )),
                          GestureDetector(
                              onTap: () {
                                _uploadImage(2);
                              },
                              child: imagePathList[2].isEmpty
                                  ? const ImageSkeleton()
                                  : PickedImage(
                                      imagePath: imagePathList[2],
                                    )),
                        ],
                      ),
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: () async {
                          final DateTime? date = await showDatePicker(
                              context: context,
                              initialDate: pickUpDate,
                              firstDate:
                                  DateTime.now().add(const Duration(days: 1)),
                              lastDate: DateTime(2050));
                          if (date != null) {
                            setState(() {
                              pickUpDate = date;
                            
                            });
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: Colors.grey.withOpacity(0.6),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'PickUp Date',
                                style: textTheme.bodyMedium!.copyWith(
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                pickUpDate.toOrdinalDate(),
                                style: textTheme.bodyMedium!.copyWith(
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: () async {
                          final TimeOfDay? pickedTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (pickedTime != null) {
                            setState(() {
                              dayTime = pickedTime;
                              // deadlineController.text = pickUpDate.toString();
                            });
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: Colors.grey.withOpacity(0.6),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'PickUp Time',
                                style: textTheme.bodyMedium!.copyWith(
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                dayTime.format(context),
                                style: textTheme.bodyMedium!.copyWith(
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: DropdownButton<PlasticType>(
                          value: initialPlasticType,
                          onChanged: (PlasticType? newValue) {
                            setState(() {
                              initialPlasticType = newValue!;
                            });
                          },
                          items: plasticType.map((PlasticType item) {
                            return DropdownMenuItem<PlasticType>(
                              value: item,
                              child: Text(item.name),
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          if (descriptionController.text.isEmpty ||
                              quantityController.text.isEmpty) {
                            showToastMessage(
                                'All fields are required', context);
                          } else {
                            postController.createPost(
                              description: descriptionController.text,
                              plasticType: initialPlasticType,
                              quantity: double.parse(quantityController.text),
                              imagePath: imagePathList,
                              pickUpDate: pickUpDate.toOrdinalDate(),
                              pickUpTime: dayTime.format(context),
                              context: context,
                            );
                          }
                        },
                        child: Text('Create Post',
                            style: textTheme.bodyMedium!.copyWith(
                              fontSize: 15,
                              color: Colors.white,
                            )),
                      ),
                    ],
                  ),
                ),
        ));
  }
}
