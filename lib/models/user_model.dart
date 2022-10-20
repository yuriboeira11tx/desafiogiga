import 'package:desafiogigaservices/models/dob_model.dart';
import 'package:desafiogigaservices/models/id_model.dart';
import 'package:desafiogigaservices/models/location_model.dart';
import 'package:desafiogigaservices/models/login_model.dart';
import 'package:desafiogigaservices/models/name_model.dart';
import 'package:desafiogigaservices/models/picture_model.dart';

class User {
  String? gender;
  Name? name;
  Location? location;
  String? email;
  Login? login;
  Dob? dob;
  Dob? registered;
  String? phone;
  String? cell;
  Id? id;
  Picture? picture;
  String? nat;

  User({
    this.gender,
    this.name,
    this.location,
    this.email,
    this.login,
    this.dob,
    this.registered,
    this.phone,
    this.cell,
    this.id,
    this.picture,
    this.nat,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      gender: json['gender'],
      name: json['name'] != null ? Name.fromJson(json['name']) : null,
      location:
          json['location'] != null ? Location.fromJson(json['location']) : null,
      email: json['email'],
      login: json['login'] != null ? Login.fromJson(json['login']) : null,
      dob: json['dob'] != null ? Dob.fromJson(json['dob']) : null,
      registered:
          json['registered'] != null ? Dob.fromJson(json['registered']) : null,
      phone: json['phone'],
      cell: json['cell'],
      id: json['id'] != null ? Id.fromJson(json['id']) : null,
      picture:
          json['picture'] != null ? Picture.fromJson(json['picture']) : null,
      nat: json['nat'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['gender'] = gender;
    if (name != null) {
      data['name'] = name!.toJson();
    }
    if (location != null) {
      data['location'] = location!.toJson();
    }
    data['email'] = email;
    if (login != null) {
      data['login'] = login!.toJson();
    }
    if (dob != null) {
      data['dob'] = dob!.toJson();
    }
    if (registered != null) {
      data['registered'] = registered!.toJson();
    }
    data['phone'] = phone;
    data['cell'] = cell;
    if (id != null) {
      data['id'] = id!.toJson();
    }
    if (picture != null) {
      data['picture'] = picture!.toJson();
    }
    data['nat'] = nat;
    return data;
  }
}
