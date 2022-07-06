import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pams/screens/clients/dpr/dpr_implementation.dart';
import 'package:pams/screens/clients/dpr/run_test.dart';
import 'package:pams/screens/clients/dpr/submit_dpr.dart';
import 'package:pams/screens/clients/fmenv/fmenv_implementation.dart';
import 'package:pams/screens/clients/fmenv/run_test.dart';
import 'package:pams/screens/clients/nesrea/run_test.dart';
import 'package:pams/screens/clients/nesrea/submit_nesrea.dart';
import 'package:pams/screens/clients/nesrea/submit_nesrea_data_model.dart';
import 'package:pams/utils/constants.dart';
import 'package:pams/utils/custom_colors.dart';

import 'nesrea_implementation.dart';

class NESREAScreen extends StatefulWidget {
  final int? locationId;

  const NESREAScreen({Key? key, this.locationId}) : super(key: key);

  @override
  _NESREAScreenState createState() => _NESREAScreenState();
}

class _NESREAScreenState extends State<NESREAScreen> {
  Map<String, dynamic>? nesreatemplates;
  @override
  void initState() {
    super.initState();
    getNESREAtemplates();
    getLocation();
  }

  getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      latitude = position.latitude;
      longitude = position.longitude;
    });
  }

  var latitude;
  var longitude;
  Future getNESREAtemplates() async {
    final result =
        await NESREAImplementation().getNESREATemplates(widget.locationId);
    if (result != null) {
      setState(() {
        nesreatemplates = result;
      });
    }
  }

  bool sendLoader = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: BackButton(
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text("NESREA Template",
              style: TextStyle(color: Colors.black, fontSize: 20)),
        ),
        backgroundColor: CustomColors.background,
        body: nesreatemplates == null
            ? Center(
                child: SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    color: CustomColors.mainDarkGreen,
                  ),
                ),
              )
            : nesreatemplates!['status'] == true
                ? ListView(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text('Available test'),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      listTemplateView(
                          nesreatemplates!['returnObject']['pmTest'],
                          'PM Test',
                          nesreatemplates!['returnObject']['pmTest']
                              ['testName'],
                          nesreatemplates!['returnObject']['pmTest']
                              ['testResult']),
                      listTemplateView(
                          nesreatemplates!['returnObject']['hmTest'],
                          'HM Test',
                          nesreatemplates!['returnObject']['hmTest']
                              ['testName'],
                          nesreatemplates!['returnObject']['hmTest']
                              ['testResult']),
                      listTemplateView(
                          nesreatemplates!['returnObject']['noiseTest'],
                          'Noise Test',
                          nesreatemplates!['returnObject']['noiseTest']
                              ['testName'],
                          nesreatemplates!['returnObject']['noiseTest']
                              ['testResult']),
                      listTemplateView(
                          nesreatemplates!['returnObject']['nO2Test'],
                          'NO2 Test',
                          nesreatemplates!['returnObject']['nO2Test']
                              ['testName'],
                          nesreatemplates!['returnObject']['nO2Test']
                              ['testResult']),
                      listTemplateView(
                          nesreatemplates!['returnObject']['sO2Test'],
                          'SO2 Test',
                          nesreatemplates!['returnObject']['sO2Test']
                              ['testName'],
                          nesreatemplates!['returnObject']['sO2Test']
                              ['testResult']),
                      listTemplateView(
                          nesreatemplates!['returnObject']['h2STest'],
                          'H2S Test',
                          nesreatemplates!['returnObject']['h2STest']
                              ['testName'],
                          nesreatemplates!['returnObject']['h2STest']
                              ['testResult']),
                      listTemplateView(
                          nesreatemplates!['returnObject']['combTest'],
                          'Comb Test',
                          nesreatemplates!['returnObject']['combTest']
                              ['testName'],
                          nesreatemplates!['returnObject']['combTest']
                              ['testResult']),
                      listTemplateView(
                          nesreatemplates!['returnObject']['cO2Test'],
                          'CO2 Test',
                          nesreatemplates!['returnObject']['cO2Test']
                              ['testName'],
                          nesreatemplates!['returnObject']['cO2Test']
                              ['testResult']),
                      listTemplateView(
                          nesreatemplates!['returnObject']['vocTest'],
                          'VOC Test',
                          nesreatemplates!['returnObject']['vocTest']
                              ['testName'],
                          nesreatemplates!['returnObject']['vocTest']
                              ['testResult']),
                      listTemplateView(
                          nesreatemplates!['returnObject']['o2Test'],
                          'O2 Test',
                          nesreatemplates!['returnObject']['o2Test']
                              ['testName'],
                          nesreatemplates!['returnObject']['o2Test']
                              ['testResult']),
                      listTemplateView(
                          nesreatemplates!['returnObject']['coTest'],
                          'CO Test',
                          nesreatemplates!['returnObject']['coTest']
                              ['testName'],
                          nesreatemplates!['returnObject']['coTest']
                              ['testResult']),
                      listTemplateView(
                          nesreatemplates!['returnObject']['tempTest'],
                          'TEMP Test',
                          nesreatemplates!['returnObject']['tempTest']
                              ['testName'],
                          nesreatemplates!['returnObject']['tempTest']
                              ['testResult']),
                      listTemplateView(
                          nesreatemplates!['returnObject']['pM5Test'],
                          'PM5 Test',
                          nesreatemplates!['returnObject']['pM5Test']
                              ['testName'],
                          nesreatemplates!['returnObject']['pM5Test']
                              ['testResult']),
                      SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () async {
                          // if (nesreatemplates!['returnObject']['pmTest']['testResult'] == null ||
                          //     nesreatemplates!['returnObject']['hmTest']
                          //             ['testResult'] ==
                          //         null ||
                          //     nesreatemplates!['returnObject']['noiseTest']
                          //             ['testResult'] ==
                          //         null ||
                          //     nesreatemplates!['returnObject']['nO2Test']
                          //             ['testResult'] ==
                          //         null ||
                          //     nesreatemplates!['returnObject']['sO2Test']
                          //             ['testResult'] ==
                          //         null ||
                          //     nesreatemplates!['returnObject']['h2STest']
                          //             ['testResult'] ==
                          //         null ||
                          //     nesreatemplates!['returnObject']['combTest']
                          //             ['testResult'] ==
                          //         null ||
                          //     nesreatemplates!['returnObject']['cO2Test']
                          //             ['testResult'] ==
                          //         null ||
                          //     nesreatemplates!['returnObject']['vocTest']
                          //             ['testResult'] ==
                          //         null ||
                          //     nesreatemplates!['returnObject']['o2Test']
                          //             ['testResult'] ==
                          //         null ||
                          //     nesreatemplates!['returnObject']['coTest']
                          //             ['testResult'] ==
                          //         null ||
                          //     nesreatemplates!['returnObject']['tempTest']
                          //             ['testResult'] ==
                          //         null ||
                          //     nesreatemplates!['returnObject']['pM5Test']['testResult'] == null) {
                          //   Constants()
                          //       .notify('Please complete all test to proceed');
                          // } else {
                          SubmitNESREAData model = SubmitNESREAData(
                            samplePtId: nesreatemplates!['returnObject']
                                ['samplePointLocationId'],
                            nesreaFieldId: nesreatemplates!['returnObject']
                                ['id'],
                            latitude: latitude,
                            longitude: longitude,
                            pmTestLimit: nesreatemplates!['returnObject']
                                ['pmTest']['testLimit'],
                            pmTestResult: nesreatemplates!['returnObject']
                                ['pmTest']['testResult'],
                            hmTestLimit: nesreatemplates!['returnObject']
                                ['hmTest']['testLimit'],
                            hmTestResult: nesreatemplates!['returnObject']
                                ['hmTest']['testResult'],
                            noiseTestLimit: nesreatemplates!['returnObject']
                                ['noiseTest']['testLimit'],
                            noiseTestResult: nesreatemplates!['returnObject']
                                ['noiseTest']['testResult'],
                            no2TestLimit: nesreatemplates!['returnObject']
                                ['nO2Test']['testLimit'],
                            no2TestResult: nesreatemplates!['returnObject']
                                ['nO2Test']['testResult'],
                            so2TestLimit: nesreatemplates!['returnObject']
                                ['sO2Test']['testLimit'],
                            so2TestResult: nesreatemplates!['returnObject']
                                ['sO2Test']['testResult'],
                            h2STestLimit: nesreatemplates!['returnObject']
                                ['h2STest']['testLimit'],
                            h2STestResult: nesreatemplates!['returnObject']
                                ['h2STest']['testResult'],
                            combTestLimit: nesreatemplates!['returnObject']
                                ['combTest']['testLimit'],
                            combTestResult: nesreatemplates!['returnObject']
                                ['combTest']['testResult'],
                            co2TestLimit: nesreatemplates!['returnObject']
                                ['cO2Test']['testLimit'],
                            co2TestResult: nesreatemplates!['returnObject']
                                ['cO2Test']['testResult'],
                            vocTestLimit: nesreatemplates!['returnObject']
                                ['vocTest']['testLimit'],
                            vocTestResult: nesreatemplates!['returnObject']
                                ['vocTest']['testResult'],
                            o2TestLimit: nesreatemplates!['returnObject']
                                ['o2Test']['testLimit'],
                            o2TestResult: nesreatemplates!['returnObject']
                                ['o2Test']['testResult'],
                            coTestLimit: nesreatemplates!['returnObject']
                                ['coTest']['testLimit'],
                            coTestResult: nesreatemplates!['returnObject']
                                ['coTest']['testResult'],
                            tempTestLimit: nesreatemplates!['returnObject']
                                ['tempTest']['testLimit'],
                            tempTestResult: nesreatemplates!['returnObject']
                                ['tempTest']['testResult'],
                            pm5TestLimit: nesreatemplates!['returnObject']
                                ['tempTest']['testLimit'],
                            pm5TestResult: nesreatemplates!['returnObject']
                                ['tempTest']['testResult'],
                            picture: '',
                          );
                          var result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SubmitNESREAPage(
                                        locationId: widget.locationId,
                                        model: model,
                                      )));
                          if (result != null) {
                            getNESREAtemplates();
                          }
                          //  }
                        },
                        child: Container(
                          margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
                          height: 60,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: CustomColors.mainDarkGreen,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: sendLoader
                                ? SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      color: CustomColors.background,
                                    ),
                                  )
                                : Text(
                                    'Submit',
                                    style: TextStyle(
                                        color: CustomColors.background,
                                        fontSize: 18),
                                  ),
                          ),
                        ),
                      ),
                    ],
                  )
                : Center(
                    child: Text('No templates available'),
                  ));
  }

  listTemplateView(Map<String, dynamic> data, String title, String subtitle,
      String? result) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ListTile(
              onTap: () async {
                var result = await Navigator.push(
                    context,
                    MaterialPageRoute<Map<String, dynamic>>(
                        builder: (context) => RunNESREATestScreen(
                              data: data,
                              title: title,
                            )));
                if (result != null) {
                  await getNESREAtemplates();
                }
              },
              title: Text(title),
              subtitle: Text(subtitle),
              trailing: result == null
                  ? CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.grey,
                    )
                  : CircleAvatar(
                      radius: 10,
                      backgroundColor: CustomColors.mainDarkGreen,
                      child: Icon(
                        Icons.check,
                        color: CustomColors.background,
                        size: 10,
                      ),
                    )),
        ),
        Divider()
      ],
    );
  }
}
