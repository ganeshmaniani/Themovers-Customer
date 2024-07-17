class PremiumPlaceToGeocodeModel {
  List<PremiumGeocodeList>? geocode;
  String? status;

  PremiumPlaceToGeocodeModel({this.geocode, this.status});

  PremiumPlaceToGeocodeModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      geocode = <PremiumGeocodeList>[];
      json['results'].forEach((v) {
        geocode!.add(PremiumGeocodeList.fromJson(v));
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

class PremiumGeocodeList {
  List<PremiumAddressComponents>? addressComponents;
  String? formattedAddress;
  PremiumGeometry? geometry;
  String? placeId;
  List<String>? types;

  PremiumGeocodeList(
      {this.addressComponents,
      this.formattedAddress,
      this.geometry,
      this.placeId,
      this.types});

  PremiumGeocodeList.fromJson(Map<String, dynamic> json) {
    if (json['address_components'] != null) {
      addressComponents = <PremiumAddressComponents>[];
      json['address_components'].forEach((v) {
        addressComponents!.add(PremiumAddressComponents.fromJson(v));
      });
    }
    formattedAddress = json['formatted_address'];
    geometry = json['geometry'] != null
        ? PremiumGeometry.fromJson(json['geometry'])
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

class PremiumAddressComponents {
  String? longName;
  String? shortName;
  List<String>? types;

  PremiumAddressComponents({this.longName, this.shortName, this.types});

  PremiumAddressComponents.fromJson(Map<String, dynamic> json) {
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

class PremiumGeometry {
  PremiumCommonDirection? bounds;
  PremiumCommonLatLng? location;
  String? locationType;
  PremiumCommonDirection? viewport;

  PremiumGeometry(
      {this.bounds, this.location, this.locationType, this.viewport});

  PremiumGeometry.fromJson(Map<String, dynamic> json) {
    bounds = json['bounds'] != null
        ? PremiumCommonDirection.fromJson(json['bounds'])
        : null;
    location = json['location'] != null
        ? PremiumCommonLatLng.fromJson(json['location'])
        : null;
    locationType = json['location_type'];
    viewport = json['viewport'] != null
        ? PremiumCommonDirection.fromJson(json['viewport'])
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

class PremiumCommonDirection {
  PremiumCommonLatLng? northeast;
  PremiumCommonLatLng? southwest;

  PremiumCommonDirection({this.northeast, this.southwest});

  PremiumCommonDirection.fromJson(Map<String, dynamic> json) {
    northeast = json['northeast'] != null
        ? PremiumCommonLatLng.fromJson(json['northeast'])
        : null;
    southwest = json['southwest'] != null
        ? PremiumCommonLatLng.fromJson(json['southwest'])
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

class PremiumCommonLatLng {
  double? lat;
  double? lng;

  PremiumCommonLatLng({this.lat, this.lng});

  PremiumCommonLatLng.fromJson(Map<String, dynamic> json) {
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
