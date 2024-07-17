import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:themovers/core/utils/shared_prefs.dart';
import 'package:themovers/feature/customer_profile/customer_profile.dart';

import '../../../../core/constants/app_keys.dart';
import '../../../../core/utils/app_alerts.dart';

class CustomerDetailUpdateChangeNotifier extends ChangeNotifier {
  String? _id;
  String? _customerName;

  File? _pickedImage;
  String? _emailId;
  String? _mobileNumber;

  File? get pickedImage => _pickedImage;

  String? get id => _id;

  String? get customerName => _customerName;

  String? get emailId => _emailId;

  String? get mobileNumber => _mobileNumber;

  Future<void> setPickedImage(File image) async {
    _pickedImage = image;
    notifyListeners();
  }

  Future<void> setCustomerName(String customerName) async {
    _customerName = customerName;
    notifyListeners();
  }

  Future<void> setEmail(String emailId) async {
    _emailId = emailId;
    notifyListeners();
  }

  Future<void> setMobileNumber(String mobileNumber) async {
    _mobileNumber = mobileNumber;
    notifyListeners();
  }

  Future<void> submitProfileImage(BuildContext context, WidgetRef ref) async {
    final id = SharedPrefs.instance.getInt(AppKeys.userId) ?? 0;

    File? pickedImage =
        ref.read(customerDetailUpdateNotifierProvider).pickedImage;
    CustomerProfileImageUpdateEntities customerProfileImageUpdateEntities =
        CustomerProfileImageUpdateEntities(id: id, profileImage: pickedImage!);
    ref
        .read(customerProfileDetailProvider.notifier)
        .customerProfileImageUpdate(customerProfileImageUpdateEntities)
        .then((res) => res.fold((l) => {}, (r) => {}));
  }

  Future<void> submitCustomerUpdate(BuildContext context, WidgetRef ref) async {
    final id = SharedPrefs.instance.getInt(AppKeys.userId) ?? 0;

    final customerName =
        ref.read(customerDetailUpdateNotifierProvider).customerName ?? '';
    final emailId =
        ref.read(customerDetailUpdateNotifierProvider).emailId ?? '';
    final mobileNumber =
        ref.read(customerDetailUpdateNotifierProvider).mobileNumber ?? '';

    CustomerDetailUpdateEntities customerDetailUpdateEntities =
        CustomerDetailUpdateEntities(
      id: id.toString(),
      customerName: customerName,
      emailId: emailId,
      mobileNumber: mobileNumber,
    );
    ref
        .read(customerProfileDetailProvider.notifier)
        .customerDetailUpdate(customerDetailUpdateEntities)
        .then((res) => res.fold(
            (l) => {
                  debugPrint(l.message),
                  AppAlerts.displaySnackBar(context, 'Edit Failed', false)
                },
            (r) => {
                  AppAlerts.displaySnackBar(
                      context, "Update Successfully", true),
                  Navigator.of(context).pop(),
                }));
  }
}
