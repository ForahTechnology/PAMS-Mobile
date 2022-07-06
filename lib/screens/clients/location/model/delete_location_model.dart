// To parse this JSON data, do
//
//     final deleteLocationResponseModel = deleteLocationResponseModelFromJson(jsonString);

import 'dart:convert';

DeleteLocationResponseModel deleteLocationResponseModelFromJson(String str) => DeleteLocationResponseModel.fromJson(json.decode(str));

String deleteLocationResponseModelToJson(DeleteLocationResponseModel data) => json.encode(data.toJson());

class DeleteLocationResponseModel {
    DeleteLocationResponseModel({
        this.status,
        this.message,
        this.returnObject,
    });

    final bool? status;
    final String? message;
    final int? returnObject;

    factory DeleteLocationResponseModel.fromJson(Map<String, dynamic> json) => DeleteLocationResponseModel(
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
