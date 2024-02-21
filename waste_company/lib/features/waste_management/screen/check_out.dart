import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:waste_company/theme/app_color.dart';
import 'package:waste_company/utils/loading_alert.dart';
import 'package:waste_company/utils/reuseables.dart';

import '../../../model/plastic.dart';
import '../controller/controller.dart';

class PostCheckOut extends ConsumerStatefulWidget {
  final Plastic plastic;
  const PostCheckOut({super.key, required this.plastic});

  @override
  ConsumerState<PostCheckOut> createState() => _PostCheckOutState();
}

class _PostCheckOutState extends ConsumerState<PostCheckOut> {
  TimeOfDay pickUpTime = TimeOfDay.now();
  DateTime pickUpDate = DateTime.now().add(const Duration(days: 1));
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final plasticController = ref.watch(plasticControllerProvider.notifier);
    final plasticControllerState = ref.watch(plasticControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Check Out'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: plasticControllerState
            ? const LoadingIndicator()
            : Column(
                children: [
                  Text('Select pickup date & time',
                      style: textTheme.titleLarge!
                          .copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 30),
                  GestureDetector(
                    onTap: () async {
                      final DateTime? date = await showDatePicker(
                          context: context,
                          initialDate: pickUpDate,
                          firstDate:
                              DateTime.now().add(const Duration(days: 1)),
                          lastDate: DateTime(2028));
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
                          color: AppColors.primaryColor.withOpacity(0.6),
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
                  const SizedBox(height: 30),
                  GestureDetector(
                    onTap: () async {
                      final TimeOfDay? pickedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (pickedTime != null) {
                        setState(() {
                          pickUpTime = pickedTime;
                        });
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: AppColors.primaryColor.withOpacity(0.6),
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
                            pickUpTime.format(context),
                            style: textTheme.bodyMedium!.copyWith(
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                      onPressed: () {
                        plasticController.schedulePickUp(
                            pickUpDate: pickUpDate.toOrdinalDate(),
                            pickUpTime: pickUpTime.format(context),
                            postId: widget.plastic.plasticId,
                            context: context);
                      },
                      child: Text(
                        'Schedule Pickup',
                        style: textTheme.bodyMedium!.copyWith(
                          color: AppColors.greyColor,
                        ),
                      ))
                ],
              ),
      ),
    );
  }
}
