import 'package:equatable/equatable.dart';

class DisposalPlaceToGeocodeEntities extends Equatable {
  final String placeId;
  final String key;

  const DisposalPlaceToGeocodeEntities({
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

  DisposalPlaceToGeocodeEntities copyWith({
    final String? placeId,
    final String? key,
  }) {
    return DisposalPlaceToGeocodeEntities(
      placeId: placeId ?? this.placeId,
      key: key ?? this.key,
    );
  }
}
