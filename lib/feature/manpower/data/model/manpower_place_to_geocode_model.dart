class ManpowerPlaceToGeocodeModel {
  List<ManpowerGeocodeList>? geocode;
  String? status;

  ManpowerPlaceToGeocodeModel({this.geocode, this.status});

  ManpowerPlaceToGeocodeModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      geocode = <ManpowerGeocodeList>[];
      json['results'].forEach((v) {
        geocode!.add(ManpowerGeocodeList.fromJson(v));
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

class ManpowerGeocodeList {
  List<ManpowerAddressComponents>? addressComponents;
  String? formattedAddress;
  ManpowerGeometry? geometry;
  String? placeId;
  List<String>? types;

  ManpowerGeocodeList(
      {this.addressComponents,
      this.formattedAddress,
      this.geometry,
      this.placeId,
      this.types});

  ManpowerGeocodeList.fromJson(Map<String, dynamic> json) {
    if (json['address_components'] != null) {
      addressComponents = <ManpowerAddressComponents>[];
      json['address_components'].forEach((v) {
        addressComponents!.add(ManpowerAddressComponents.fromJson(v));
      });
    }
    formattedAddress = json['formatted_address'];
    geometry = json['geometry'] != null
        ? ManpowerGeometry.fromJson(json['geometry'])
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

class ManpowerAddressComponents {
  String? longName;
  String? shortName;
  List<String>? types;

  ManpowerAddressComponents({this.longName, this.shortName, this.types});

  ManpowerAddressComponents.fromJson(Map<String, dynamic> json) {
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

class ManpowerGeometry {
  ManpowerCommonDirection? bounds;
  ManpowerCommonLatLng? location;
  String? locationType;
  ManpowerCommonDirection? viewport;

  ManpowerGeometry(
      {this.bounds, this.location, this.locationType, this.viewport});

  ManpowerGeometry.fromJson(Map<String, dynamic> json) {
    bounds = json['bounds'] != null
        ? ManpowerCommonDirection.fromJson(json['bounds'])
        : null;
    location = json['location'] != null
        ? ManpowerCommonLatLng.fromJson(json['location'])
        : null;
    locationType = json['location_type'];
    viewport = json['viewport'] != null
        ? ManpowerCommonDirection.fromJson(json['viewport'])
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

class ManpowerCommonDirection {
  ManpowerCommonLatLng? northeast;
  ManpowerCommonLatLng? southwest;

  ManpowerCommonDirection({this.northeast, this.southwest});

  ManpowerCommonDirection.fromJson(Map<String, dynamic> json) {
    northeast = json['northeast'] != null
        ? ManpowerCommonLatLng.fromJson(json['northeast'])
        : null;
    southwest = json['southwest'] != null
        ? ManpowerCommonLatLng.fromJson(json['southwest'])
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

class ManpowerCommonLatLng {
  double? lat;
  double? lng;

  ManpowerCommonLatLng({this.lat, this.lng});

  ManpowerCommonLatLng.fromJson(Map<String, dynamic> json) {
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
