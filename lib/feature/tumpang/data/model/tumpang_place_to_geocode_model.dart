class TumpangPlaceToGeocodeModel {
  List<TumpangGeocodeList>? geocode;
  String? status;

  TumpangPlaceToGeocodeModel({this.geocode, this.status});

  TumpangPlaceToGeocodeModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      geocode = <TumpangGeocodeList>[];
      json['results'].forEach((v) {
        geocode!.add(TumpangGeocodeList.fromJson(v));
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

class TumpangGeocodeList {
  List<TumpangAddressComponents>? addressComponents;
  String? formattedAddress;
  TumpangGeometry? geometry;
  String? placeId;
  List<String>? types;

  TumpangGeocodeList(
      {this.addressComponents,
      this.formattedAddress,
      this.geometry,
      this.placeId,
      this.types});

  TumpangGeocodeList.fromJson(Map<String, dynamic> json) {
    if (json['address_components'] != null) {
      addressComponents = <TumpangAddressComponents>[];
      json['address_components'].forEach((v) {
        addressComponents!.add(TumpangAddressComponents.fromJson(v));
      });
    }
    formattedAddress = json['formatted_address'];
    geometry = json['geometry'] != null
        ? TumpangGeometry.fromJson(json['geometry'])
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

class TumpangAddressComponents {
  String? longName;
  String? shortName;
  List<String>? types;

  TumpangAddressComponents({this.longName, this.shortName, this.types});

  TumpangAddressComponents.fromJson(Map<String, dynamic> json) {
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

class TumpangGeometry {
  TumpangCommonDirection? bounds;
  TumpangCommonLatLng? location;
  String? locationType;
  TumpangCommonDirection? viewport;

  TumpangGeometry(
      {this.bounds, this.location, this.locationType, this.viewport});

  TumpangGeometry.fromJson(Map<String, dynamic> json) {
    bounds = json['bounds'] != null
        ? TumpangCommonDirection.fromJson(json['bounds'])
        : null;
    location = json['location'] != null
        ? TumpangCommonLatLng.fromJson(json['location'])
        : null;
    locationType = json['location_type'];
    viewport = json['viewport'] != null
        ? TumpangCommonDirection.fromJson(json['viewport'])
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

class TumpangCommonDirection {
  TumpangCommonLatLng? northeast;
  TumpangCommonLatLng? southwest;

  TumpangCommonDirection({this.northeast, this.southwest});

  TumpangCommonDirection.fromJson(Map<String, dynamic> json) {
    northeast = json['northeast'] != null
        ? TumpangCommonLatLng.fromJson(json['northeast'])
        : null;
    southwest = json['southwest'] != null
        ? TumpangCommonLatLng.fromJson(json['southwest'])
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

class TumpangCommonLatLng {
  double? lat;
  double? lng;

  TumpangCommonLatLng({this.lat, this.lng});

  TumpangCommonLatLng.fromJson(Map<String, dynamic> json) {
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
