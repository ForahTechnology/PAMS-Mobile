// To parse this JSON data, do
//
//     final getAllFmenvSubmittedTest = getAllFmenvSubmittedTestFromJson(jsonString);

import 'dart:convert';

GetAllFmenvSubmittedTest getAllFmenvSubmittedTestFromJson(String str) => GetAllFmenvSubmittedTest.fromJson(json.decode(str));

String getAllFmenvSubmittedTestToJson(GetAllFmenvSubmittedTest data) => json.encode(data.toJson());

class GetAllFmenvSubmittedTest {
    GetAllFmenvSubmittedTest({
        this.status,
        this.message,
        this.returnObject,
    });

    final bool? status;
    final String? message;
    final ReturnObject? returnObject;

    factory GetAllFmenvSubmittedTest.fromJson(Map<String, dynamic> json) => GetAllFmenvSubmittedTest(
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
    final List<FMENVList>? data;

    factory ReturnObject.fromJson(Map<String, dynamic> json) => ReturnObject(
        pageNumber: json["pageNumber"],
        pageSize: json["pageSize"],
        total: json["total"],
        data: List<FMENVList>.from(json["data"].map((x) => FMENVList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "pageNumber": pageNumber,
        "pageSize": pageSize,
        "total": total,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class FMENVList {
    FMENVList({
        this.id,
        this.samplePointLocationId,
        this.clientName,
        this.analystFullName,
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
    final String? clientName;
    final String? analystFullName;
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
    final dynamic imageDetails;

    factory FMENVList.fromJson(Map<String, dynamic> json) => FMENVList(
        id: json["id"],
        samplePointLocationId: json["samplePointLocationId"],
        clientName: json["clientName"],
        analystFullName: json["analystFullName"],
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
        imageDetails: json["imageDetails"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "samplePointLocationId": samplePointLocationId,
        "clientName": clientName,
        "analystFullName": analystFullName,
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
        "imageDetails": imageDetails,
    };
}

class Test {
    Test({
        this.id,
        this.fmEnvId,
        this.testName,
        this.testUnit,
        this.testLimit,
        this.testResult,
    });

    final int? id;
    final int? fmEnvId;
    final String? testName;
    final String? testUnit;
    final String? testLimit;
    final String? testResult;

    factory Test.fromJson(Map<String, dynamic> json) => Test(
        id: json["id"],
        fmEnvId: json["fmEnvId"],
        testName: json["testName"],
        testUnit: json["testUnit"],
        testLimit: json["testLimit"] == null ? null : json["testLimit"],
        testResult: json["testResult"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "fmEnvId": fmEnvId,
        "testName": testName,
        "testUnit": testUnit,
        "testLimit": testLimit == null ? null : testLimit,
        "testResult": testResult,
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
