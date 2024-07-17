import 'package:equatable/equatable.dart';

class TumpangPlaceEntities extends Equatable {
  final String query;
  final String key;

  const TumpangPlaceEntities({required this.query, required this.key});

  @override
  List<Object> get props {
    return [query, key];
  }

  @override
  bool get stringify => true;

  TumpangPlaceEntities copyWith({final String? query, final String? key}) {
    return TumpangPlaceEntities(
        query: query ?? this.query, key: key ?? this.key);
  }
}
