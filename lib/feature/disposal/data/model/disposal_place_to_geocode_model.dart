class DisposalPlaceToGeocodeModel {
  List<DisposalGeocodeList>? geocode;
  String? status;

  DisposalPlaceToGeocodeModel({this.geocode, this.status});

  DisposalPlaceToGeocodeModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      geocode = <DisposalGeocodeList>[];
      json['results'].forEach((v) {
        geocode!.add(DisposalGeocodeList.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (geocode != null) {
      data['results'] = geocode!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    return data;
  }
}

class DisposalGeocodeList {
  List<DisposalAddressComponents>? addressComponents;
  String? formattedAddress;
  DisposalGeometry? geometry;
  String? placeId;
  List<String>? types;

  DisposalGeocodeList(
      {this.addressComponents,
      this.formattedAddress,
      this.geometry,
      this.placeId,
      this.types});

  DisposalGeocodeList.fromJson(Map<String, dynamic> json) {
    if (json['address_components'] != null) {
      addressComponents = <DisposalAddressComponents>[];
      json['address_components'].forEach((v) {
        addressComponents!.add(DisposalAddressComponents.fromJson(v));
      });
    }
    formattedAddress = json['formatted_address'];
    geometry = json['geometry'] != null
        ? DisposalGeometry.fromJson(json['geometry'])
        : null;
    placeId = json['place_id'];
    types = json['types'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (addressComponents != null) {
      data['address_components'] =
          addressComponents!.map((v) => v.toJson()).toList();
    }
    data['formatted_address'] = formattedAddress;
    if (geometry != null) {
      data['geometry'] = geometry!.toJson();
    }
    data['place_id'] = placeId;
    data['types'] = types;
    return data;
  }
}

class DisposalAddressComponents {
  String? longName;
  String? shortName;
  List<String>? types;

  DisposalAddressComponents({this.longName, this.shortName, this.types});

  DisposalAddressComponents.fromJson(Map<String, dynamic> json) {
    longName = json['long_name'];
    shortName = json['short_name'];
    types = json['types'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['long_name'] = longName;
    data['short_name'] = shortName;
    data['types'] = types;
    return data;
  }
}

class DisposalGeometry {
  DisposalCommonDirection? bounds;
  DisposalCommonLatLng? location;
  String? locationType;
  DisposalCommonDirection? viewport;

  DisposalGeometry(
      {this.bounds, this.location, this.locationType, this.viewport});

  DisposalGeometry.fromJson(Map<String, dynamic> json) {
    bounds = json['bounds'] != null
        ? DisposalCommonDirection.fromJson(json['bounds'])
        : null;
    location = json['location'] != null
        ? DisposalCommonLatLng.fromJson(json['location'])
        : null;
    locationType = json['location_type'];
    viewport = json['viewport'] != null
        ? DisposalCommonDirection.fromJson(json['viewport'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (bounds != null) {
      data['bounds'] = bounds!.toJson();
    }
    if (location != null) {
      data['location'] = location!.toJson();
    }
    data['location_type'] = locationType;
    if (viewport != null) {
      data['viewport'] = viewport!.toJson();
    }
    return data;
  }
}

class DisposalCommonDirection {
  DisposalCommonLatLng? northeast;
  DisposalCommonLatLng? southwest;

  DisposalCommonDirection({this.northeast, this.southwest});

  DisposalCommonDirection.fromJson(Map<String, dynamic> json) {
    northeast = json['northeast'] != null
        ? DisposalCommonLatLng.fromJson(json['northeast'])
        : null;
    southwest = json['southwest'] != null
        ? DisposalCommonLatLng.fromJson(json['southwest'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (northeast != null) {
      data['northeast'] = northeast!.toJson();
    }
    if (southwest != null) {
      data['southwest'] = southwest!.toJson();
    }
    return data;
  }
}

class DisposalCommonLatLng {
  double? lat;
  double? lng;

  DisposalCommonLatLng({this.lat, this.lng});

  DisposalCommonLatLng.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat;
    data['lng'] = lng;
    return data;
  }
}
