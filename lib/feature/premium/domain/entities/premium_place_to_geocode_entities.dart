import 'package:equatable/equatable.dart';

class PremiumPlaceToGeocodeEntities extends Equatable {
  final String placeId;
  final String key;

  const PremiumPlaceToGeocodeEntities({
    required this.placeId,
    required this.key,
  });

  @override
  List<Object> get props {
    return [
      placeId,
      key,
    ];
  }

  @override
  bool get stringify => true;

  PremiumPlaceToGeocodeEntities copyWith({
    final String? placeId,
    final String? key,
  }) {
    return PremiumPlaceToGeocodeEntities(
      placeId: placeId ?? this.placeId,
      key: key ?? this.key,
    );
  }
}
