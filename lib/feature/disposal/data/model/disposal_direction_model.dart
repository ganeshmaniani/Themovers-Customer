import 'package:flutter_polyline_points_plus/flutter_polyline_points_plus.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DisposalDirections {
  final LatLngBounds? bounds;
  final List<PointLatLng>? polylinePoints;
  final String? totalDistance;
  final String? totalDuration;

  const DisposalDirections({
    this.bounds,
    this.polylinePoints,
    this.totalDistance,
    this.totalDuration,
  });

  factory DisposalDirections.fromMap(Map<String, dynamic> map) {
    if ((map['routes'] as List).isEmpty) return const DisposalDirections();

    final data = Map<String, dynamic>.from(map['routes'][0]);

    final northeast = data['bounds']['northeast'];
    final southwest = data['bounds']['southwest'];

    final bounds = LatLngBounds(
      northeast: LatLng(northeast['lat'], northeast['lng']),
      southwest: LatLng(southwest['lat'], southwest['lng']),
    );

    String distance = '';
    String duration = '';
    if ((data['legs'] as List).isNotEmpty) {
      final leg = data['legs'][0];
      distance = leg['distance']['text'];
      duration = leg['duration']['text'];
    }

    return DisposalDirections(
      bounds: bounds,
      polylinePoints:
          PolylinePoints().decodePolyline(data['overview_polyline']['points']),
      totalDistance: distance,
      totalDuration: duration,
    );
  }
}
