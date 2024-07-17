class PlaceToGeocodeModel {
  List<GeocodeList>? geocode;
  String? status;

  PlaceToGeocodeModel({this.geocode, this.status});

  PlaceToGeocodeModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      geocode = <GeocodeList>[];
      json['results'].forEach((v) {
        geocode!.add(GeocodeList.fromJson(v));
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

class GeocodeList {
  List<AddressComponents>? addressComponents;
  String? formattedAddress;
  Geometry? geometry;
  String? placeId;
  List<String>? types;

  GeocodeList(
      {this.addressComponents,
      this.formattedAddress,
      this.geometry,
      this.placeId,
      this.types});

  GeocodeList.fromJson(Map<String, dynamic> json) {
    if (json['address_components'] != null) {
      addressComponents = <AddressComponents>[];
      json['address_components'].forEach((v) {
        addressComponents!.add(AddressComponents.fromJson(v));
      });
    }
    formattedAddress = json['formatted_address'];
    geometry =
        json['geometry'] != null ? Geometry.fromJson(json['geometry']) : null;
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

class AddressComponents {
  String? longName;
  String? shortName;
  List<String>? types;

  AddressComponents({this.longName, this.shortName, this.types});

  AddressComponents.fromJson(Map<String, dynamic> json) {
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

class Geometry {
  CommonDirection? bounds;
  CommonLatLng? location;
  String? locationType;
  CommonDirection? viewport;

  Geometry({this.bounds, this.location, this.locationType, this.viewport});

  Geometry.fromJson(Map<String, dynamic> json) {
    bounds = json['bounds'] != null
        ? CommonDirection.fromJson(json['bounds'])
        : null;
    location = json['location'] != null
        ? CommonLatLng.fromJson(json['location'])
        : null;
    locationType = json['location_type'];
    viewport = json['viewport'] != null
        ? CommonDirection.fromJson(json['viewport'])
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

class CommonDirection {
  CommonLatLng? northeast;
  CommonLatLng? southwest;

  CommonDirection({this.northeast, this.southwest});

  CommonDirection.fromJson(Map<String, dynamic> json) {
    northeast = json['northeast'] != null
        ? CommonLatLng.fromJson(json['northeast'])
        : null;
    southwest = json['southwest'] != null
        ? CommonLatLng.fromJson(json['southwest'])
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

class CommonLatLng {
  double? lat;
  double? lng;

  CommonLatLng({this.lat, this.lng});

  CommonLatLng.fromJson(Map<String, dynamic> json) {
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
