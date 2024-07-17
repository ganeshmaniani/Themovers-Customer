import 'package:equatable/equatable.dart';

class PlaceEntities extends Equatable {
  final String query;
  final String key;

  const PlaceEntities({
    required this.query,
    required this.key,
  });

  @override
  List<Object> get props {
    return [
      query,
      key,
    ];
  }

  @override
  bool get stringify => true;

  PlaceEntities copyWith({
    final String? query,
    final String? key,
  }) {
    return PlaceEntities(
      query: query ?? this.query,
      key: key ?? this.key,
    );
  }
}
