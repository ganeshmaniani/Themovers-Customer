import 'package:equatable/equatable.dart';

class StatusUpdateEntities extends Equatable {
  final String bookingId;
  final String paymentMode;

  const StatusUpdateEntities(
      {required this.bookingId, required this.paymentMode});

  @override
  List<Object> get props {
    return [bookingId, paymentMode];
  }

  @override
  bool get stringify => true;

  StatusUpdateEntities copyWith(
      {final String? bookingId, final String? paymentMode}) {
    return StatusUpdateEntities(
      bookingId: bookingId ?? this.bookingId,
      paymentMode: paymentMode ?? this.paymentMode,
    );
  }
}
