// To parse this JSON data, do
//
//     final customerResponseModel = customerResponseModelFromJson(jsonString);

import 'dart:convert';

CustomerResponseModel customerResponseModelFromJson(String str) =>
    CustomerResponseModel.fromJson(json.decode(str));

String customerResponseModelToJson(CustomerResponseModel data) =>
    json.encode(data.toJson());

class CustomerResponseModel {
  CustomerResponseModel({
    this.status,
    this.message,
    this.returnObject,
  });

  final bool? status;
  final String? message;
  final ReturnObject? returnObject;

  factory CustomerResponseModel.fromJson(Map<String, dynamic> json) =>
      CustomerResponseModel(
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
    this.pageNumber,
    this.pageSize,
    this.total,
    this.data,
  });

  final int? pageNumber;
  final int? pageSize;
  final int? total;
  final List<CustomerDataList>? data;

  factory ReturnObject.fromJson(Map<String, dynamic> json) => ReturnObject(
        pageNumber: json["pageNumber"],
        pageSize: json["pageSize"],
        total: json["total"],
        data: List<CustomerDataList>.from(
            json["data"].map((x) => CustomerDataList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "pageNumber": pageNumber,
        "pageSize": pageSize,
        "total": total,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class CustomerDataList {
  CustomerDataList({
    this.id,
    this.name,
    this.email,
    this.address,
    this.contactPerson,
    this.registeredDate,
    this.samplePointLocations,
    this.samplings,
    this.invoices,
    this.templates,
  });

  final String? id;
  final String? name;
  final String? email;
  final String? address;
  final String? contactPerson;
  final DateTime? registeredDate;
  final List<SamplePointLocation>? samplePointLocations;
  final List<Sampling>? samplings;
  final List<Invoice>? invoices;
  final List<String>? templates;

  factory CustomerDataList.fromJson(Map<String, dynamic> json) =>
      CustomerDataList(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        address: json["address"],
        contactPerson:
            json["contactPerson"] == null ? null : json["contactPerson"],
        registeredDate: DateTime.parse(json["registeredDate"]),
        samplePointLocations: List<SamplePointLocation>.from(
            json["samplePointLocations"]
                .map((x) => SamplePointLocation.fromJson(x))),
        samplings: List<Sampling>.from(
            json["samplings"].map((x) => Sampling.fromJson(x))),
        invoices: List<Invoice>.from(
            json["invoices"].map((x) => Invoice.fromJson(x))),
        templates: List<String>.from(json["templates"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "address": address,
        "contactPerson": contactPerson == null ? null : contactPerson,
        "registeredDate": registeredDate!.toIso8601String(),
        "samplePointLocations":
            List<dynamic>.from(samplePointLocations!.map((x) => x.toJson())),
        "samplings": List<dynamic>.from(samplings!.map((x) => x.toJson())),
        "invoices": List<dynamic>.from(invoices!.map((x) => x.toJson())),
        "templates": List<dynamic>.from(templates!.map((x) => x)),
      };
}

class Invoice {
  Invoice({
    this.items,
    this.paid,
    this.inoviceNumber,
    this.dueDate,
    this.dateGenerated,
    this.clientId,
    this.samplingId,
    this.id,
  });

  final String? items;
  final bool? paid;
  final String? inoviceNumber;
  final DateTime? dueDate;
  final DateTime? dateGenerated;
  final String? clientId;
  final String? samplingId;
  final String? id;

  factory Invoice.fromJson(Map<String, dynamic> json) => Invoice(
        items: json["items"],
        paid: json["paid"],
        inoviceNumber: json["inoviceNumber"],
        dueDate: DateTime.parse(json["dueDate"]),
        dateGenerated: DateTime.parse(json["dateGenerated"]),
        clientId: json["clientID"],
        samplingId: json["samplingID"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "items": items,
        "paid": paid,
        "inoviceNumber": inoviceNumber,
        "dueDate": dueDate!.toIso8601String(),
        "dateGenerated": dateGenerated!.toIso8601String(),
        "clientID": clientId,
        "samplingID": samplingId,
        "id": id,
      };
}

class SamplePointLocation {
  SamplePointLocation({
    this.clientId,
    this.client,
    this.name,
    this.description,
    this.nesreaFields,
    this.fmenvFields,
    this.dprFields,
    this.id,
    this.timeCreated,
    this.timeModified,
  });

  final String? clientId;
  final dynamic client;
  final String? name;
  final String? description;
  final dynamic nesreaFields;
  final dynamic fmenvFields;
  final dynamic dprFields;
  final int? id;
  final DateTime? timeCreated;
  final DateTime? timeModified;

  factory SamplePointLocation.fromJson(Map<String, dynamic> json) =>
      SamplePointLocation(
        clientId: json["clientID"],
        client: json["client"],
        name: json["name"],
        description: json["description"],
        nesreaFields: json["nesreaFields"],
        fmenvFields: json["fmenvFields"],
        dprFields: json["dprFields"],
        id: json["id"],
        timeCreated: DateTime.parse(json["timeCreated"]),
        timeModified: DateTime.parse(json["timeModified"]),
      );

  Map<String, dynamic> toJson() => {
        "clientID": clientId,
        "client": client,
        "name": name,
        "description": description,
        "nesreaFields": nesreaFields,
        "fmenvFields": fmenvFields,
        "dprFields": dprFields,
        "id": id,
        "timeCreated": timeCreated!.toIso8601String(),
        "timeModified": timeModified!.toIso8601String(),
      };
}

class Sampling {
  Sampling({
    this.clientId,
    this.staffId,
    this.staffName,
    this.samplingTime,
    this.samplingDate,
    this.status,
    this.gpsLocation,
    this.isReportCreated,
    this.picture,
    this.microBiologicalAnalyses,
    this.physicoChemicalAnalyses,
    this.id,
  });

  final String? clientId;
  final String? staffId;
  final String? staffName;
  final DateTime? samplingTime;
  final DateTime? samplingDate;
  final int? status;
  final String? gpsLocation;
  final bool? isReportCreated;
  final String? picture;
  final List<MicroBiologicalAnalysis>? microBiologicalAnalyses;
  final List<PhysicoChemicalAnalysis>? physicoChemicalAnalyses;
  final String? id;

  factory Sampling.fromJson(Map<String, dynamic> json) => Sampling(
        clientId: json["clientID"],
        staffId: json["staffId"],
        staffName: json["staffName"],
        samplingTime: DateTime.parse(json["samplingTime"]),
        samplingDate: DateTime.parse(json["samplingDate"]),
        status: json["status"],
        gpsLocation: json["gpsLocation"],
        isReportCreated: json["isReportCreated"],
        picture: json["picture"],
        microBiologicalAnalyses: List<MicroBiologicalAnalysis>.from(
            json["microBiologicalAnalyses"]
                .map((x) => MicroBiologicalAnalysis.fromJson(x))),
        physicoChemicalAnalyses: List<PhysicoChemicalAnalysis>.from(
            json["physicoChemicalAnalyses"]
                .map((x) => PhysicoChemicalAnalysis.fromJson(x))),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "clientID": clientId,
        "staffId": staffId,
        "staffName": staffName,
        "samplingTime": samplingTime!.toIso8601String(),
        "samplingDate": samplingDate!.toIso8601String(),
        "status": status,
        "gpsLocation": gpsLocation,
        "isReportCreated": isReportCreated,
        "picture": picture,
        "microBiologicalAnalyses":
            List<dynamic>.from(microBiologicalAnalyses!.map((x) => x.toJson())),
        "physicoChemicalAnalyses":
            List<dynamic>.from(physicoChemicalAnalyses!.map((x) => x.toJson())),
        "id": id,
      };
}

class MicroBiologicalAnalysis {
  MicroBiologicalAnalysis({
    this.samplingId,
    this.microbialGroup,
    this.result,
    this.unit,
    this.limit,
    this.testMethod,
    this.id,
  });

  final String? samplingId;
  final String? microbialGroup;
  final String? result;
  final String? unit;
  final String? limit;
  final String? testMethod;
  final String? id;

  factory MicroBiologicalAnalysis.fromJson(Map<String, dynamic> json) =>
      MicroBiologicalAnalysis(
        samplingId: json["samplingID"],
        microbialGroup: json["microbial_Group"],
        result: json["result"],
        unit: json["unit"],
        limit: json["limit"],
        testMethod: json["test_Method"] == null ? null : json["test_Method"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "samplingID": samplingId,
        "microbial_Group": microbialGroup,
        "result": result,
        "unit": unit,
        "limit": limit,
        "test_Method": testMethod == null ? null : testMethod,
        "id": id,
      };
}

class PhysicoChemicalAnalysis {
  PhysicoChemicalAnalysis({
    this.samplingId,
    this.testPerformedAndUnit,
    this.result,
    this.uc,
    this.limit,
    this.testMethod,
    this.type,
    this.id,
  });

  final String? samplingId;
  final String? testPerformedAndUnit;
  final String? result;
  final String? uc;
  final String? limit;
  final String? testMethod;
  final int? type;
  final String? id;

  factory PhysicoChemicalAnalysis.fromJson(Map<String, dynamic> json) =>
      PhysicoChemicalAnalysis(
        samplingId: json["samplingID"],
        testPerformedAndUnit: json["test_Performed_And_Unit"],
        result: json["result"],
        uc: json["uc"] == null ? null : json["uc"],
        limit: json["limit"],
        testMethod: json["test_Method"] == null ? null : json["test_Method"],
        type: json["type"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "samplingID": samplingId,
        "test_Performed_And_Unit": testPerformedAndUnit,
        "result": result,
        "uc": uc == null ? null : uc,
        "limit": limit,
        "test_Method": testMethod == null ? null : testMethod,
        "type": type,
        "id": id,
      };
}
