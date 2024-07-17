import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TumpangDirectionEntities extends Equatable {
  final LatLng origin;
  final LatLng destination;
  final String key;

  const TumpangDirectionEntities({
    required this.origin,
    required this.destination,
    required this.key,
  });

  @override
  List<Object> get props {
    return [
      origin,
      destination,
      key,
    ];
  }

  @override
  bool get stringify => true;

  TumpangDirectionEntities copyWith({
    final LatLng? origin,
    final LatLng? destination,
    final String? key,
  }) {
    return TumpangDirectionEntities(
      origin: origin ?? this.origin,
      destination: destination ?? this.destination,
      key: key ?? this.key,
    );
  }
}
