import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PremiumDirectionEntities extends Equatable {
  final LatLng origin;
  final LatLng destination;
  final String key;

  const PremiumDirectionEntities({
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

  PremiumDirectionEntities copyWith({
    final LatLng? origin,
    final LatLng? destination,
    final String? key,
  }) {
    return PremiumDirectionEntities(
      origin: origin ?? this.origin,
      destination: destination ?? this.destination,
      key: key ?? this.key,
    );
  }
}
