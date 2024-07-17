import 'dart:io';

import 'package:equatable/equatable.dart';

class CustomerProfileImageUpdateEntities extends Equatable {
  final int id;
  final File profileImage;

  const CustomerProfileImageUpdateEntities(
      {required this.id, required this.profileImage});

  @override
  List<Object?> get props {
    return [id, profileImage];
  }

  @override
  bool get stringify => true;

  CustomerProfileImageUpdateEntities copyWith(
      {final int? id, final File? profileImage}) {
    return CustomerProfileImageUpdateEntities(
        id: id ?? this.id, profileImage: profileImage ?? this.profileImage);
  }
}
