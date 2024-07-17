import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:themovers/core/core.dart';
import 'package:themovers/feature/customer_profile/customer_profile.dart';

import '../../domain/usecase/customer_detail_update/customer_detail_update_usecase.dart';
import '../../domain/usecase/customer_profile_image_update/customer_profile_image_update_usecase.dart';

class CustomerProfileDetailNotifier
    extends StateNotifier<CustomerProfileDetailState> {
  final CustomerProfileDetailUseCase _customerProfileDetailUseCase;

  final ResetPasswordUseCase _resetPasswordUseCase;
  final CustomerDetailUpdateUseCase _customerDetailUpdateUseCase;

  final CustomerDeleteAccountUseCase _customerDeleteAccountUseCase;
  final CustomerProfileImageUpdateUseCase _customerProfileImageUseCase;

  CustomerProfileDetailNotifier(
      this._customerProfileDetailUseCase,
      this._resetPasswordUseCase,
      this._customerDetailUpdateUseCase,
      this._customerDeleteAccountUseCase,
      this._customerProfileImageUseCase)
      : super(const CustomerProfileDetailState.initial());

  Future<Either<Failure, CustomerProfileDetailModel>>
      getCustomerProfileDetail() async {
    state.copyWith(isLoading: true);
    final result = await _customerProfileDetailUseCase();
    state.copyWith(isLoading: false);
    return result;
  }

  Future<Either<Failure, dynamic>> resetPassword(
      ResetPasswordEntities resetPasswordEntities) async {
    state.copyWith(isLoading: true);
    final result = await _resetPasswordUseCase(resetPasswordEntities);
    state.copyWith(isLoading: false);
    return result;
  }

  Future<Either<Failure, dynamic>> customerDetailUpdate(
      CustomerDetailUpdateEntities customerDetailUpdateEntities) async {
    state.copyWith(isLoading: true);
    final result =
        await _customerDetailUpdateUseCase(customerDetailUpdateEntities);
    return result;
  }

  Future<Either<Failure, dynamic>> customerDeleteAccount(
      CustomerDeleteAccountEntities customerDeleteAccountEntities) async {
    state.copyWith(isLoading: true);
    final result =
        await _customerDeleteAccountUseCase(customerDeleteAccountEntities);
    return result;
  }

  Future<Either<Failure, dynamic>> customerProfileImageUpdate(
      CustomerProfileImageUpdateEntities
          customerProfileImageUpdateEntities) async {
    state.copyWith(isLoading: true);
    final result =
        await _customerProfileImageUseCase(customerProfileImageUpdateEntities);
    return result;
  }
}
