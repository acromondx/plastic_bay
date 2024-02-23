import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:waste_company/api/analytics/analytics_api.dart';
import 'package:waste_company/utils/post_status.dart';

import '../../../api/providers.dart';
import '../../../api/waste_management/waste_management_api.dart';
import '../../../utils/toast_message.dart';

final plasticControllerProvider =
    StateNotifierProvider<PlasticController, bool>((ref) {
  return PlasticController(
      wasteManagementAPI: ref.watch(plasticManagementApiProvider),
      auth: ref.watch(firebaseAuthProvider),
      analyticsApi: ref.watch(analyticsApiProvider));
});

class PlasticController extends StateNotifier<bool> {
  final WasteManagementAPI _wasteManagementAPI;
  final FirebaseAuth _auth;
  final AnalyticsApi _analyticsApi;
  PlasticController(
      {required WasteManagementAPI wasteManagementAPI,
      required FirebaseAuth auth,
      required AnalyticsApi analyticsApi})
      : _wasteManagementAPI = wasteManagementAPI,
        _auth = auth,
        _analyticsApi = analyticsApi,
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
      'pickUpTime': pickUpTime,
      'status': PlasticStatus.accepted.name,
      'acceptedCompanyId': _auth.currentUser!.uid,
    };

    final plasticUpdate = await _wasteManagementAPI.updatePost(
        plasticId: postId, updateFields: update);

    plasticUpdate.fold((failure) {
      state = false;
      showToastMessage(failure.error.toString(), context);
    }, (r) async {
      state = false;
      await _analyticsApi
          .updateAnalytics(update: {'acceptedPost': FieldValue.increment(1)});
      context.pop();
    });
  }

  Future<void> cancelPickUp({
    required String postId,
    required BuildContext context,
    required String contributorsId,
  }) async {
    state = true;
    final update = {
      'pickUpDate': '',
      "pickUpTime": '',
      'status': PlasticStatus.pending.name,
      'acceptedCompanyId': '',
    };
    final increasePendingPost = {'pendingPost': FieldValue.increment(1)};
    final plasticUpdate = await _wasteManagementAPI.updatePost(
        plasticId: postId, updateFields: update);

    plasticUpdate
        .fold((failure) => showToastMessage(failure.error.toString(), context),
            (r) async {
      final updateContributorPendingPost =
          await _wasteManagementAPI.updateContributorsAnalytics(
        contributorsId: contributorsId,
        updateFields: increasePendingPost,
      );
      updateContributorPendingPost.fold((failure) {
        state = false;
        showToastMessage(failure.error.toString(), context);
      }, (r) async {
        state = false;
        await _analyticsApi.updateAnalytics(
            update: {'acceptedPost': FieldValue.increment(-1)});
        showToastMessage(
          'Pick up cancelled',
          context,
        );
      });
    });
  }

  Future<void> pickedUp({
    required String postId,
    required String contributorsId,
    required BuildContext context,
  }) async {
    state = true;
    final decreasePending = {'pendingPost': FieldValue.increment(-1)};
    final update = {
      'status': PlasticStatus.pickedUp.name,
    };
    final plasticUpdate = await _wasteManagementAPI.updatePost(
        plasticId: postId, updateFields: update);
    state = false;
    plasticUpdate
        .fold((failure) => showToastMessage(failure.error.toString(), context),
            (r) async {
      final coUpdate = await _wasteManagementAPI.updatePost(
          plasticId: contributorsId, updateFields: decreasePending);
      coUpdate.fold(
          (failure) => showToastMessage(failure.error.toString(), context),
          (r) {
        _analyticsApi
            .updateAnalytics(update: {'pickedUpPost': FieldValue.increment(1)});
        showToastMessage('Picked up success', context, isSuccess: true);
      });
    });
  }
}
