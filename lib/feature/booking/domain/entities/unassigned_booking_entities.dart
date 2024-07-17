import 'package:equatable/equatable.dart';

class UnAssignedBookingEntities extends Equatable {
  final String customerId;
  final String bookingStatusId;

  const UnAssignedBookingEntities(
      {required this.customerId, required this.bookingStatusId});

  @override
  List<Object> get props {
    return [customerId, bookingStatusId];
  }

  @override
  bool get stringify => true;

  UnAssignedBookingEntities copyWith(
      {final String? customerId, final String? bookingStatusId}) {
    return UnAssignedBookingEntities(
      customerId: customerId ?? this.customerId,
      bookingStatusId: bookingStatusId ?? this.bookingStatusId,
    );
  }
}
