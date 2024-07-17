import 'package:equatable/equatable.dart';

class PremiumPlaceEntities extends Equatable {
  final String query;
  final String key;

  const PremiumPlaceEntities({required this.query, required this.key});

  @override
  List<Object> get props {
    return [query, key];
  }

  @override
  bool get stringify => true;

  PremiumPlaceEntities copyWith({final String? query, final String? key}) {
    return PremiumPlaceEntities(
        query: query ?? this.query, key: key ?? this.key);
  }
}
