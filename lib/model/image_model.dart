// To parse this JSON data, do
//
//     final dalleModel = dalleModelFromJson(jsonString);

import 'dart:convert';

DalleModel dalleModelFromJson(String str) =>
    DalleModel.fromJson(json.decode(str));

String dalleModelToJson(DalleModel data) => json.encode(data.toJson());

class DalleModel {
  DalleModel({
    required this.created,
    required this.data,
  });

  int created;
  List<Datum> data;

  factory DalleModel.fromJson(Map<String, dynamic> json) => DalleModel(
        created: json["created"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "created": created,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.url,
  });

  String url;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
      };
}
