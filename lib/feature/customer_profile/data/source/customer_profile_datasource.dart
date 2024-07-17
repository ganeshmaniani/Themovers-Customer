import 'package:dartz/dartz.dart';
import 'package:themovers/feature/customer_profile/customer_profile.dart';
import 'package:themovers/feature/customer_profile/domain/entities/customer_delete_account.dart';
import 'package:themovers/feature/customer_profile/domain/entities/customer_profile_image_update.dart';

import '../../../../core/errors/failure.dart';

abstract class CustomerProfileDataSource {
  Future<Either<Failure, CustomerProfileDetailModel>>
      getCustomerProfileDetail();

  Future<Either<Failure, dynamic>> resetPassword(
      ResetPasswordEntities resetPasswordEntities);

  Future<Either<Failure, dynamic>> customerDetailUpdate(
      CustomerDetailUpdateEntities customerDetailUpdateEntities);

  Future<Either<Failure, dynamic>> customerDeleteAccount(
      CustomerDeleteAccountEntities customerDeleteAccountEntities);

  Future<Either<Failure, dynamic>> customerProfileImageUpdate(
      CustomerProfileImageUpdateEntities customerProfileImageUpdateEntities);
}
