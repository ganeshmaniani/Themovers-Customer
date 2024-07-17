import 'package:equatable/equatable.dart';

class ManpowerPlaceEntities extends Equatable {
  final String query;
  final String key;

  const ManpowerPlaceEntities({
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

  ManpowerPlaceEntities copyWith({
    final String? query,
    final String? key,
  }) {
    return ManpowerPlaceEntities(
      query: query ?? this.query,
      key: key ?? this.key,
    );
  }
}
