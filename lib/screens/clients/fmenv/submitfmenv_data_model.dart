// To parse this JSON data, do
//
//     final submitFMENVData = submitFMENVDataFromJson(jsonString?);

import 'dart:convert';

SubmitFMENVData submitFMENVDataFromJson(String str) =>
    SubmitFMENVData.fromJson(json.decode(str));

String? submitFMENVDataToJson(SubmitFMENVData data) => json.encode(data.toJson());

class SubmitFMENVData {
  SubmitFMENVData({
    this.samplePtId,
    this.fmenvFieldId,
    this.latitude,
    this.longitude,
    this.pmTestLimit,
    this.pmTestResult,
    this.hmTestLimit,
    this.hmTestResult,
    this.noiseTestLimit,
    this.noiseTestResult,
    this.no2TestLimit,
    this.no2TestResult,
    this.so2TestLimit,
    this.so2TestResult,
    this.h2STestLimit,
    this.h2STestResult,
    this.combTestLimit,
    this.combTestResult,
    this.co2TestLimit,
    this.co2TestResult,
    this.vocTestLimit,
    this.vocTestResult,
    this.o2TestLimit,
    this.o2TestResult,
    this.coTestLimit,
    this.coTestResult,
    this.tempTestLimit,
    this.tempTestResult,
    this.pm5TestLimit,
    this.pm5TestResult,
    this.picture,
  });

  final int? samplePtId;
  final int? fmenvFieldId;
  final dynamic latitude;
  final dynamic longitude;
  final String? pmTestLimit;
  final String? pmTestResult;
  final String? hmTestLimit;
  final String? hmTestResult;
  final String? noiseTestLimit;
  final String? noiseTestResult;
  final String? no2TestLimit;
  final String? no2TestResult;
  final String? so2TestLimit;
  final String? so2TestResult;
  final String? h2STestLimit;
  final String? h2STestResult;
  final String? combTestLimit;
  final String? combTestResult;
  final String? co2TestLimit;
  final String? co2TestResult;
  final String? vocTestLimit;
  final String? vocTestResult;
  final String? o2TestLimit;
  final String? o2TestResult;
  final String? coTestLimit;
  final String? coTestResult;
  final String? tempTestLimit;
  final String? tempTestResult;
  final String? pm5TestLimit;
  final String? pm5TestResult;
  final dynamic picture;

  factory SubmitFMENVData.fromJson(Map<String?, dynamic> json) => SubmitFMENVData(
        samplePtId: json["samplePtId"],
        fmenvFieldId: json["FMEnvFieldId"],
        latitude: json["Latitude"],
        longitude: json["Longitude"],
        pmTestLimit: json["PmTestLimit"],
        pmTestResult: json["PmTestResult"],
        hmTestLimit: json["HmTestLimit"],
        hmTestResult: json["HmTestResult"],
        noiseTestLimit: json["NoiseTestLimit"],
        noiseTestResult: json["NoiseTestResult"],
        no2TestLimit: json["NO2TestLimit"],
        no2TestResult: json["No2TestResult"],
        so2TestLimit: json["SO2TestLimit"],
        so2TestResult: json["So2TestResult"],
        h2STestLimit: json["H2STestLimit"],
        h2STestResult: json["H2STestResult"],
        combTestLimit: json["CombTestLimit"],
        combTestResult: json["CombTestResult"],
        co2TestLimit: json["CO2TestLimit"],
        co2TestResult: json["Co2TestResult"],
        vocTestLimit: json["VocTestLimit"],
        vocTestResult: json["VocTestResult"],
        o2TestLimit: json["O2TestLimit"],
        o2TestResult: json["O2TestResult"],
        coTestLimit: json["CoTestLimit"],
        coTestResult: json["CoTestResult"],
        tempTestLimit: json["TempTestLimit"],
        tempTestResult: json["TempTestResult"],
        pm5TestLimit: json["Pm5TestLimit"],
        pm5TestResult: json["Pm5TestResult"],
        picture: json["Picture"],
      );

  Map<String, dynamic> toJson() => {
        "samplePtId": samplePtId,
        "FMEnvFieldId": fmenvFieldId,
        "Latitude": latitude,
        "Longitude": longitude,
        "PmTestLimit": pmTestLimit,
        "PmTestResult": pmTestResult,
        "HmTestLimit": hmTestLimit,
        "HmTestResult": hmTestResult,
        "NoiseTestLimit": noiseTestLimit,
        "NoiseTestResult": noiseTestResult,
        "NO2TestLimit": no2TestLimit,
        "No2TestResult": no2TestResult,
        "SO2TestLimit": so2TestLimit,
        "So2TestResult": so2TestResult,
        "H2STestLimit": h2STestLimit,
        "H2STestResult": h2STestResult,
        "CombTestLimit": combTestLimit,
        "CombTestResult": combTestResult,
        "CO2TestLimit": co2TestLimit,
        "Co2TestResult": co2TestResult,
        "VocTestLimit": vocTestLimit,
        "VocTestResult": vocTestResult,
        "O2TestLimit": o2TestLimit,
        "O2TestResult": o2TestResult,
        "CoTestLimit": coTestLimit,
        "CoTestResult": coTestResult,
        "TempTestLimit": tempTestLimit,
        "TempTestResult": tempTestResult,
        "Pm5TestLimit": pm5TestLimit,
        "Pm5TestResult": pm5TestResult,
        "Picture": picture,
      };
}
