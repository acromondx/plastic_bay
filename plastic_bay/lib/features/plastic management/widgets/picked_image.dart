import 'dart:io';

import 'package:flutter/material.dart';

class PickedImage extends StatelessWidget {
  final String imagePath;
  const PickedImage({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: FileImage(File(imagePath)),
            fit: BoxFit.cover,
          ),
        ));
  }
}
