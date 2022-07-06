// To parse this JSON data, do
//
//     final addLocationResponseModel = addLocationResponseModelFromJson(jsonString);

import 'dart:convert';

AddLocationResponseModel addLocationResponseModelFromJson(String str) => AddLocationResponseModel.fromJson(json.decode(str));

String addLocationResponseModelToJson(AddLocationResponseModel data) => json.encode(data.toJson());

class AddLocationResponseModel {
    AddLocationResponseModel({
        this.status,
        this.message,
        this.returnObject,
    });

    final bool? status;
    final String? message;
    final int? returnObject;

    factory AddLocationResponseModel.fromJson(Map<String, dynamic> json) => AddLocationResponseModel(
        status: json["status"],
        message: json["message"],
        returnObject: json["returnObject"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "returnObject": returnObject,
    };
}
