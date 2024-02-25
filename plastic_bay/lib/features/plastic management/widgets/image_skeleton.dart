import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../../../theme/app_color.dart';

class ImageSkeleton extends StatelessWidget {
  const ImageSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      color: Colors.grey.shade300,
      child: DottedBorder(
          radius: const Radius.circular(20),
          color: AppColors.primaryColor,
          strokeWidth: 1,
          dashPattern: const [2, 5],
          stackFit: StackFit.loose,
          child: Container(
            color: Colors.grey.withOpacity(0.1),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.cloud_upload_rounded,
                  color: AppColors.primaryColor,
                ),
                Text('Upload Image')
              ],
            ),
          )),
    );
  }
}
