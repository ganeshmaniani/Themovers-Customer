import 'dart:io';

import 'package:equatable/equatable.dart';

class TumpangEntities extends Equatable {
  final int customerId;
  final int serviceType;
  final String bookingDate;
  final String pickupAddress;
  final String dropOffAddress;
  final String distance;
  final String pickupLatitude;
  final String pickupLongitude;
  final String dropLatitude;
  final String dropLongitude;
  final String selectServicePeriod;
  final String serviceDateTimePeriod;
  final String description;
  final File profileUpload;

  const TumpangEntities({
    required this.customerId,
    required this.serviceType,
    required this.bookingDate,
    required this.pickupAddress,
    required this.dropOffAddress,
    required this.distance,
    required this.pickupLatitude,
    required this.pickupLongitude,
    required this.dropLatitude,
    required this.dropLongitude,
    required this.description,
    required this.selectServicePeriod,
    required this.serviceDateTimePeriod,
    required this.profileUpload,
  });

  @override
  List<Object> get props {
    return [
      customerId,
      serviceType,
      bookingDate,
      pickupAddress,
      dropOffAddress,
      distance,
      pickupLatitude,
      pickupLongitude,
      dropLatitude,
      dropLongitude,
      description,
      selectServicePeriod,
      serviceDateTimePeriod,
      profileUpload,
    ];
  }

  @override
  bool get stringify => true;

  TumpangEntities copyWith({
    final int? customerId,
    final int? serviceType,
    final String? bookingDate,
    final String? pickupAddress,
    final String? dropOffAddress,
    final String? distance,
    final double? amount,
    final String? pickupLatitude,
    final String? pickupLongitude,
    final String? dropLatitude,
    final String? dropLongitude,
    final String? description,
    final String? selectServicePeriod,
    final String? serviceDateTimePeriod,
    final File? profileUpload,
  }) {
    return TumpangEntities(
      customerId: customerId ?? this.customerId,
      serviceType: serviceType ?? this.serviceType,
      bookingDate: bookingDate ?? this.bookingDate,
      pickupAddress: pickupAddress ?? this.pickupAddress,
      dropOffAddress: dropOffAddress ?? this.dropOffAddress,
      distance: distance ?? this.distance,
      pickupLatitude: pickupLatitude ?? this.pickupLatitude,
      pickupLongitude: pickupLongitude ?? this.pickupLongitude,
      dropLatitude: dropLatitude ?? this.dropLatitude,
      dropLongitude: dropLongitude ?? this.dropLongitude,
      description: description ?? this.description,
      selectServicePeriod: selectServicePeriod ?? this.selectServicePeriod,
      serviceDateTimePeriod:
          serviceDateTimePeriod ?? this.serviceDateTimePeriod,
      profileUpload: profileUpload ?? this.profileUpload,
    );
  }
}
