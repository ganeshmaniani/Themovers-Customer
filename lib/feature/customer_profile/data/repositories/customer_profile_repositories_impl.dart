import 'package:dartz/dartz.dart';
import 'package:themovers/core/errors/failure.dart';
import 'package:themovers/feature/customer_profile/customer_profile.dart';
import 'package:themovers/feature/customer_profile/domain/entities/customer_delete_account.dart';
import 'package:themovers/feature/customer_profile/domain/entities/customer_profile_image_update.dart';

class CustomerProfileRepositoryImpl implements CustomerProfileRepository {
  final CustomerProfileDataSource _dataSource;

  CustomerProfileRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, CustomerProfileDetailModel>>
      getCustomerProfile() async {
    return await _dataSource.getCustomerProfileDetail();
  }

  @override
  Future<Either<Failure, dynamic>> resetPassword(
      ResetPasswordEntities resetPasswordEntities) async {
    return await _dataSource.resetPassword(resetPasswordEntities);
  }

  @override
  Future<Either<Failure, dynamic>> customerDetailUpdate(
      CustomerDetailUpdateEntities customerDetailUpdateEntities) async {
    return await _dataSource.customerDetailUpdate(customerDetailUpdateEntities);
  }

  @override
  Future<Either<Failure, dynamic>> customerDeleteAccount(
      CustomerDeleteAccountEntities customerDeleteAccountEntities) async {
    return await _dataSource
        .customerDeleteAccount(customerDeleteAccountEntities);
  }

  @override
  Future<Either<Failure, dynamic>> customerProfileImageUpdate(
      CustomerProfileImageUpdateEntities
          customerProfileImageUpdateEntities) async {
    return await _dataSource
        .customerProfileImageUpdate(customerProfileImageUpdateEntities);
  }
}
