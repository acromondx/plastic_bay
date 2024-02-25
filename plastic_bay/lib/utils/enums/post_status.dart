import 'package:flutter/material.dart';
import 'package:plastic_bay/theme/app_color.dart';

enum PlasticStatus {
  pending,
  review,
  accepted,
  rejected,
  pickedUp,
}

PlasticStatus plasticFromStringToStatus(String text) => switch (text) {
      'pending' => PlasticStatus.pending,
      'accepted' => PlasticStatus.accepted,
      'review' => PlasticStatus.review,
      'rejected' => PlasticStatus.rejected,
      'pickedUp' => PlasticStatus.pickedUp,
      _ => PlasticStatus.pending,
    };
Color plasticStatusColor(PlasticStatus status) => switch (status) {
      PlasticStatus.pending => Colors.orange,
      PlasticStatus.accepted => AppColors.primaryColor,
      PlasticStatus.review => Colors.blue,
      PlasticStatus.rejected => Colors.red,
      PlasticStatus.pickedUp => Colors.purple,
      _ => Colors.orange,
    };
