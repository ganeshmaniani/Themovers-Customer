import 'package:equatable/equatable.dart';

class PlaceToGeocodeEntities extends Equatable {
  final String placeId;
  final String key;

  const PlaceToGeocodeEntities({
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

  PlaceToGeocodeEntities copyWith({
    final String? placeId,
    final String? key,
  }) {
    return PlaceToGeocodeEntities(
      placeId: placeId ?? this.placeId,
      key: key ?? this.key,
    );
  }
}
