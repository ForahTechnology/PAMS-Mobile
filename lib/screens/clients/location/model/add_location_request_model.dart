// To parse this JSON data, do
//
//     final addLocationRequestModel = addLocationRequestModelFromJson(jsonString);

import 'dart:convert';

AddLocationRequestModel addLocationRequestModelFromJson(String str) => AddLocationRequestModel.fromJson(json.decode(str));

String addLocationRequestModelToJson(AddLocationRequestModel data) => json.encode(data.toJson());

class AddLocationRequestModel {
    AddLocationRequestModel({
        this.clientId,
        this.name,
        this.description,
    });

    final String? clientId;
    final String? name;
    final String? description;

    factory AddLocationRequestModel.fromJson(Map<String, dynamic> json) => AddLocationRequestModel(
        clientId: json["clientId"],
        name: json["name"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "clientId": clientId,
        "name": name,
        "description": description,
    };
}
