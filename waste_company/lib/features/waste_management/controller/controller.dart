import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:waste_company/utils/post_status.dart';

import '../../../api/providers.dart';
import '../../../api/waste_management/waste_management_api.dart';
import '../../../utils/toast_message.dart';

final plasticControllerProvider =
    StateNotifierProvider<PlasticController, bool>((ref) {
  return PlasticController(
      wasteManagementAPI: ref.watch(plasticManagementApiProvider),
      auth: ref.watch(firebaseAuthProvider));
});

class PlasticController extends StateNotifier<bool> {
  final WasteManagementAPI _wasteManagementAPI;
  final FirebaseAuth _auth;
  PlasticController(
      {required WasteManagementAPI wasteManagementAPI,
      required FirebaseAuth auth})
      : _wasteManagementAPI = wasteManagementAPI,
        _auth = auth,
        super(false);

  Future<void> schedulePickUp({
    required String pickUpDate,
    required String pickUpTime,
    required String postId,
    required BuildContext context,
  }) async {
    state = true;
    final update = {
      'pickUpDate': pickUpDate,
      "pickUpTime": pickUpTime,
      'status': PlasticStatus.accepted.name,
      'acceptedCompanyId': _auth.currentUser!.uid,
    };
    final plasticUpdate = await _wasteManagementAPI.updatePost(
        plasticId: postId, updateFields: update);
    state = false;
    plasticUpdate.fold(
        (failure) => showToastMessage(failure.error.toString(), context),
        (r) => context.pop());
  }

  Future<void> cancelPickUp({
    required String postId,
    required BuildContext context,
  }) async {
    state = true;
    final update = {
      'pickUpDate': '',
      "pickUpTime": '',
      'status': PlasticStatus.pending.name,
      'acceptedCompanyId': '',
    };
    final plasticUpdate = await _wasteManagementAPI.updatePost(
        plasticId: postId, updateFields: update);
    state = false;
    plasticUpdate.fold(
        (failure) => showToastMessage(failure.error.toString(), context),
        (r) => showToastMessage(
              'Pick up cancelled',
              context,
            ));
  }

  Future<void> pickedUp({
    required String postId,
    required BuildContext context,
  }) async {
    state = true;
    final update = {
      'status': PlasticStatus.pickedUp.name,
    };
    final plasticUpdate = await _wasteManagementAPI.updatePost(
        plasticId: postId, updateFields: update);
    state = false;
    plasticUpdate.fold(
        (failure) => showToastMessage(failure.error.toString(), context),
        (r) => showToastMessage('Picked up success', context, isSuccess: true));
  }
}
