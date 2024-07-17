import 'package:equatable/equatable.dart';

class TumpangPlaceToGeocodeEntities extends Equatable {
  final String placeId;
  final String key;

  const TumpangPlaceToGeocodeEntities(
      {required this.placeId, required this.key});

  @override
  List<Object> get props {
    return [placeId, key];
  }

  @override
  bool get stringify => true;

  TumpangPlaceToGeocodeEntities copyWith(
      {final String? placeId, final String? key}) {
    return TumpangPlaceToGeocodeEntities(
        placeId: placeId ?? this.placeId, key: key ?? this.key);
  }
}
