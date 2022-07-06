// To parse this JSON data, do
//
//     final updateLocationResponseModel = updateLocationResponseModelFromJson(jsonString);

import 'dart:convert';

UpdateLocationResponseModel updateLocationResponseModelFromJson(String str) => UpdateLocationResponseModel.fromJson(json.decode(str));

String updateLocationResponseModelToJson(UpdateLocationResponseModel data) => json.encode(data.toJson());

class UpdateLocationResponseModel {
    UpdateLocationResponseModel({
        this.status,
        this.message,
        this.returnObject,
    });

    final bool? status;
    final String? message;
    final ReturnObject? returnObject;

    factory UpdateLocationResponseModel.fromJson(Map<String, dynamic> json) => UpdateLocationResponseModel(
        status: json["status"],
        message: json["message"],
        returnObject: ReturnObject.fromJson(json["returnObject"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "returnObject": returnObject!.toJson(),
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
