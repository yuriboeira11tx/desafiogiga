import 'package:desafiogigaservices/models/coordinates_model.dart';
import 'package:desafiogigaservices/models/street_model.dart';
import 'package:desafiogigaservices/models/timezone_model.dart';

class Location {
  Street? street;
  String? city;
  String? state;
  String? country;
  String? postcode;
  Coordinates? coordinates;
  Timezone? timezone;

  Location({
    this.street,
    this.city,
    this.state,
    this.country,
    this.postcode,
    this.coordinates,
    this.timezone,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      street: json['street'] != null ? Street.fromJson(json['street']) : null,
      city: json['city'],
      state: json['state'],
      country: json['country'],
      postcode: json['postcode'].toString(),
      coordinates: json['coordinates'] != null
          ? Coordinates.fromJson(json['coordinates'])
          : null,
      timezone:
          json['timezone'] != null ? Timezone.fromJson(json['timezone']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (street != null) {
      data['street'] = street!.toJson();
    }
    data['city'] = city;
    data['state'] = state;
    data['country'] = country;
    data['postcode'] = postcode;
    if (coordinates != null) {
      data['coordinates'] = coordinates!.toJson();
    }
    if (timezone != null) {
      data['timezone'] = timezone!.toJson();
    }
    return data;
  }
}
