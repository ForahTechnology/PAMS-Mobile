// To parse this JSON data, do
//
//     final getAllNesreaSubmittedTest = getAllNesreaSubmittedTestFromJson(jsonString);

import 'dart:convert';

GetAllNesreaSubmittedTest getAllNesreaSubmittedTestFromJson(String str) => GetAllNesreaSubmittedTest.fromJson(json.decode(str));

String getAllNesreaSubmittedTestToJson(GetAllNesreaSubmittedTest data) => json.encode(data.toJson());

class GetAllNesreaSubmittedTest {
    GetAllNesreaSubmittedTest({
        this.status,
        this.message,
        this.returnObject,
    });

    final bool? status;
    final String? message;
    final ReturnObject? returnObject;

    factory GetAllNesreaSubmittedTest.fromJson(Map<String, dynamic> json) => GetAllNesreaSubmittedTest(
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
    final List<NESREAList>? data;

    factory ReturnObject.fromJson(Map<String, dynamic> json) => ReturnObject(
        pageNumber: json["pageNumber"],
        pageSize: json["pageSize"],
        total: json["total"],
        data: List<NESREAList>.from(json["data"].map((x) => NESREAList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "pageNumber": pageNumber,
        "pageSize": pageSize,
        "total": total,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class NESREAList {
    NESREAList({
        this.id,
        this.samplePointLocationId,
        this.analystFullName,
        this.clientName,
        this.samplePointName,
        this.name,
        this.location,
        this.pmTest,
        this.hmTest,
        this.noiseTest,
        this.nO2Test,
        this.sO2Test,
        this.h2STest,
        this.combTest,
        this.cO2Test,
        this.vocTest,
        this.o2Test,
        this.coTest,
        this.tempTest,
        this.pM5Test,
        this.time,
        this.imageDetails,
    });

    final int? id;
    final int? samplePointLocationId;
    final String? analystFullName;
    final String? clientName;
    final String? samplePointName;
    final String? name;
    final Location? location;
    final Test? pmTest;
    final Test? hmTest;
    final Test? noiseTest;
    final Test? nO2Test;
    final Test? sO2Test;
    final Test? h2STest;
    final Test? combTest;
    final Test? cO2Test;
    final Test? vocTest;
    final Test? o2Test;
    final Test? coTest;
    final Test? tempTest;
    final Test? pM5Test;
    final DateTime? time;
    final ImageDetails? imageDetails;

    factory NESREAList.fromJson(Map<String, dynamic> json) => NESREAList(
        id: json["id"],
        samplePointLocationId: json["samplePointLocationId"],
        analystFullName: json["analystFullName"],
        clientName: json["clientName"],
        samplePointName: json["samplePointName"],
        name: json["name"],
        location: Location.fromJson(json["location"]),
        pmTest: Test.fromJson(json["pmTest"]),
        hmTest: Test.fromJson(json["hmTest"]),
        noiseTest: Test.fromJson(json["noiseTest"]),
        nO2Test: Test.fromJson(json["nO2Test"]),
        sO2Test: Test.fromJson(json["sO2Test"]),
        h2STest: Test.fromJson(json["h2STest"]),
        combTest: Test.fromJson(json["combTest"]),
        cO2Test: Test.fromJson(json["cO2Test"]),
        vocTest: Test.fromJson(json["vocTest"]),
        o2Test: Test.fromJson(json["o2Test"]),
        coTest: Test.fromJson(json["coTest"]),
        tempTest: Test.fromJson(json["tempTest"]),
        pM5Test: Test.fromJson(json["pM5Test"]),
        time: DateTime.parse(json["time"]),
        imageDetails: ImageDetails.fromJson(json["imageDetails"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "samplePointLocationId": samplePointLocationId,
        "analystFullName": analystFullName,
        "clientName": clientName,
        "samplePointName": samplePointName,
        "name": name,
        "location": location!.toJson(),
        "pmTest": pmTest!.toJson(),
        "hmTest": hmTest!.toJson(),
        "noiseTest": noiseTest!.toJson(),
        "nO2Test": nO2Test!.toJson(),
        "sO2Test": sO2Test!.toJson(),
        "h2STest": h2STest!.toJson(),
        "combTest": combTest!.toJson(),
        "cO2Test": cO2Test!.toJson(),
        "vocTest": vocTest!.toJson(),
        "o2Test": o2Test!.toJson(),
        "coTest": coTest!.toJson(),
        "tempTest": tempTest!.toJson(),
        "pM5Test": pM5Test!.toJson(),
        "time": time!.toIso8601String(),
        "imageDetails": imageDetails!.toJson(),
    };
}

class Test {
    Test({
        this.id,
        this.nesreaFieldId,
        this.testName,
        this.testUnit,
        this.testLimit,
        this.testResult,
    });

    final int? id;
    final int? nesreaFieldId;
    final String? testName;
    final String? testUnit;
    final String? testLimit;
    final String? testResult;

    factory Test.fromJson(Map<String, dynamic> json) => Test(
        id: json["id"],
        nesreaFieldId: json["nesreaFieldId"],
        testName: json["testName"],
        testUnit: json["testUnit"],
        testLimit: json["testLimit"] == null ? null : json["testLimit"],
        testResult: json["testResult"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nesreaFieldId": nesreaFieldId,
        "testName": testName,
        "testUnit": testUnit,
        "testLimit": testLimit == null ? null : testLimit,
        "testResult": testResult,
    };
}

class ImageDetails {
    ImageDetails({
        this.fullName,
        this.fileBase64,
    });

    final dynamic fullName;
    final dynamic fileBase64;

    factory ImageDetails.fromJson(Map<String, dynamic> json) => ImageDetails(
        fullName: json["fullName"],
        fileBase64: json["fileBase64"],
    );

    Map<String, dynamic> toJson() => {
        "fullName": fullName,
        "fileBase64": fileBase64,
    };
}

class Location {
    Location({
        this.latitude,
        this.longitude,
    });

    final String? latitude;
    final String? longitude;

    factory Location.fromJson(Map<String, dynamic> json) => Location(
        latitude: json["latitude"],
        longitude: json["longitude"],
    );

    Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
    };
}
