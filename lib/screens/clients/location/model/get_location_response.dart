// To parse this JSON data, do
//
//     final locationResponseModel = locationResponseModelFromJson(jsonString);

import 'dart:convert';

LocationResponseModel locationResponseModelFromJson(String str) => LocationResponseModel.fromJson(json.decode(str));

String locationResponseModelToJson(LocationResponseModel data) => json.encode(data.toJson());

class LocationResponseModel {
    LocationResponseModel({
        this.status,
        this.message,
        this.returnObject,
    });

    final bool? status;
    final String? message;
    final List<ReturnObject>? returnObject;

    factory LocationResponseModel.fromJson(Map<String, dynamic> json) => LocationResponseModel(
        status: json["status"],
        message: json["message"],
        returnObject: List<ReturnObject>.from(json["returnObject"].map((x) => ReturnObject.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "returnObject": List<dynamic>.from(returnObject!.map((x) => x.toJson())),
    };
}

class ReturnObject {
    ReturnObject({
        this.sampleLocationId,
        this.name,
        this.description,
    });

    final int? sampleLocationId;
    final String? name;
    final String? description;

    factory ReturnObject.fromJson(Map<String, dynamic> json) => ReturnObject(
        sampleLocationId: json["sampleLocationId"],
        name: json["name"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "sampleLocationId": sampleLocationId,
        "name": name,
        "description": description,
    };
}
