import 'package:equatable/equatable.dart';

class ManpowerPlaceToGeocodeEntities extends Equatable {
  final String placeId;
  final String key;

  const ManpowerPlaceToGeocodeEntities({
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

  ManpowerPlaceToGeocodeEntities copyWith({
    final String? placeId,
    final String? key,
  }) {
    return ManpowerPlaceToGeocodeEntities(
      placeId: placeId ?? this.placeId,
      key: key ?? this.key,
    );
  }
}
