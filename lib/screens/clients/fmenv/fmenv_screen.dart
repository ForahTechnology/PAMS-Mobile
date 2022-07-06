import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pams/screens/clients/dpr/dpr_implementation.dart';
import 'package:pams/screens/clients/dpr/run_test.dart';
import 'package:pams/screens/clients/dpr/submit_dpr.dart';
import 'package:pams/screens/clients/fmenv/fmenv_implementation.dart';
import 'package:pams/screens/clients/fmenv/run_test.dart';
import 'package:pams/screens/clients/fmenv/submit_fmenv.dart';
import 'package:pams/screens/clients/fmenv/submitfmenv_data_model.dart';
import 'package:pams/utils/constants.dart';
import 'package:pams/utils/custom_colors.dart';

import '../dpr/submit_data_model.dart';

class FMENVScreen extends StatefulWidget {
  final int? locationId;

  const FMENVScreen({Key? key, this.locationId}) : super(key: key);

  @override
  _FMENVScreenState createState() => _FMENVScreenState();
}

class _FMENVScreenState extends State<FMENVScreen> {
  Map<String, dynamic>? fmenvtemplates;
  @override
  void initState() {
    super.initState();
    getFMENVtemplates();
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
  Future getFMENVtemplates() async {
    final result =
        await FMENVImplementation().getFMENVTemplates(widget.locationId);
    if (result != null) {
      setState(() {
        fmenvtemplates = result;
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
          title: Text("FMENV Template",
              style: TextStyle(color: Colors.black, fontSize: 20)),
        ),
        backgroundColor: CustomColors.background,
        body: fmenvtemplates == null
            ? Center(
                child: SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    color: CustomColors.mainDarkGreen,
                  ),
                ),
              )
            : fmenvtemplates!['status'] == true
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
                          fmenvtemplates!['returnObject']['pmTest'],
                          'PM Test',
                          fmenvtemplates!['returnObject']['pmTest']['testName'],
                          fmenvtemplates!['returnObject']['pmTest']
                              ['testResult']),
                      listTemplateView(
                          fmenvtemplates!['returnObject']['hmTest'],
                          'HM Test',
                          fmenvtemplates!['returnObject']['hmTest']['testName'],
                          fmenvtemplates!['returnObject']['hmTest']
                              ['testResult']),
                      listTemplateView(
                          fmenvtemplates!['returnObject']['noiseTest'],
                          'Noise Test',
                          fmenvtemplates!['returnObject']['noiseTest']
                              ['testName'],
                          fmenvtemplates!['returnObject']['noiseTest']
                              ['testResult']),
                      listTemplateView(
                          fmenvtemplates!['returnObject']['nO2Test'],
                          'NO2 Test',
                          fmenvtemplates!['returnObject']['nO2Test']
                              ['testName'],
                          fmenvtemplates!['returnObject']['nO2Test']
                              ['testResult']),
                      listTemplateView(
                          fmenvtemplates!['returnObject']['sO2Test'],
                          'SO2 Test',
                          fmenvtemplates!['returnObject']['sO2Test']
                              ['testName'],
                          fmenvtemplates!['returnObject']['sO2Test']
                              ['testResult']),
                      listTemplateView(
                          fmenvtemplates!['returnObject']['h2STest'],
                          'H2S Test',
                          fmenvtemplates!['returnObject']['h2STest']
                              ['testName'],
                          fmenvtemplates!['returnObject']['h2STest']
                              ['testResult']),
                      listTemplateView(
                          fmenvtemplates!['returnObject']['combTest'],
                          'Comb Test',
                          fmenvtemplates!['returnObject']['combTest']
                              ['testName'],
                          fmenvtemplates!['returnObject']['combTest']
                              ['testResult']),
                      listTemplateView(
                          fmenvtemplates!['returnObject']['cO2Test'],
                          'CO2 Test',
                          fmenvtemplates!['returnObject']['cO2Test']
                              ['testName'],
                          fmenvtemplates!['returnObject']['cO2Test']
                              ['testResult']),
                      listTemplateView(
                          fmenvtemplates!['returnObject']['vocTest'],
                          'VOC Test',
                          fmenvtemplates!['returnObject']['vocTest']
                              ['testName'],
                          fmenvtemplates!['returnObject']['vocTest']
                              ['testResult']),
                      listTemplateView(
                          fmenvtemplates!['returnObject']['o2Test'],
                          'O2 Test',
                          fmenvtemplates!['returnObject']['o2Test']['testName'],
                          fmenvtemplates!['returnObject']['o2Test']
                              ['testResult']),
                      listTemplateView(
                          fmenvtemplates!['returnObject']['coTest'],
                          'CO Test',
                          fmenvtemplates!['returnObject']['coTest']['testName'],
                          fmenvtemplates!['returnObject']['coTest']
                              ['testResult']),
                      listTemplateView(
                          fmenvtemplates!['returnObject']['tempTest'],
                          'TEMP Test',
                          fmenvtemplates!['returnObject']['tempTest']
                              ['testName'],
                          fmenvtemplates!['returnObject']['tempTest']
                              ['testResult']),
                      listTemplateView(
                          fmenvtemplates!['returnObject']['pM5Test'],
                          'PM5 Test',
                          fmenvtemplates!['returnObject']['pM5Test']
                              ['testName'],
                          fmenvtemplates!['returnObject']['pM5Test']
                              ['testResult']),
                      SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () async {
                          // if (fmenvtemplates!['returnObject']['pmTest']['testResult'] == null ||
                          //     fmenvtemplates!['returnObject']['hmTest']
                          //             ['testResult'] ==
                          //         null ||
                          //     fmenvtemplates!['returnObject']['noiseTest']
                          //             ['testResult'] ==
                          //         null ||
                          //     fmenvtemplates!['returnObject']['nO2Test']
                          //             ['testResult'] ==
                          //         null ||
                          //     fmenvtemplates!['returnObject']['sO2Test']
                          //             ['testResult'] ==
                          //         null ||
                          //     fmenvtemplates!['returnObject']['h2STest']
                          //             ['testResult'] ==
                          //         null ||
                          //     fmenvtemplates!['returnObject']['combTest']
                          //             ['testResult'] ==
                          //         null ||
                          //     fmenvtemplates!['returnObject']['cO2Test']
                          //             ['testResult'] ==
                          //         null ||
                          //     fmenvtemplates!['returnObject']['vocTest']
                          //             ['testResult'] ==
                          //         null ||
                          //     fmenvtemplates!['returnObject']['o2Test']
                          //             ['testResult'] ==
                          //         null ||
                          //     fmenvtemplates!['returnObject']['coTest']
                          //             ['testResult'] ==
                          //         null ||
                          //     fmenvtemplates!['returnObject']['tempTest']
                          //             ['testResult'] ==
                          //         null ||
                          //     fmenvtemplates!['returnObject']['pM5Test']['testResult'] == null) {
                          //   Constants()
                          //       .notify('Please complete all test to proceed');
                          // } else {
                            SubmitFMENVData model = SubmitFMENVData(
                              samplePtId: fmenvtemplates!['returnObject']
                                  ['samplePointLocationId'],
                              fmenvFieldId: fmenvtemplates!['returnObject']
                                  ['id'],
                              latitude: latitude,
                              longitude: longitude,
                              pmTestLimit: fmenvtemplates!['returnObject']
                                  ['pmTest']['testLimit'],
                              pmTestResult: fmenvtemplates!['returnObject']
                                  ['pmTest']['testResult'],
                              hmTestLimit: fmenvtemplates!['returnObject']
                                  ['hmTest']['testLimit'],
                              hmTestResult: fmenvtemplates!['returnObject']
                                  ['hmTest']['testResult'],
                              noiseTestLimit: fmenvtemplates!['returnObject']
                                  ['noiseTest']['testLimit'],
                              noiseTestResult: fmenvtemplates!['returnObject']
                                  ['noiseTest']['testResult'],
                              no2TestLimit: fmenvtemplates!['returnObject']
                                  ['nO2Test']['testLimit'],
                              no2TestResult: fmenvtemplates!['returnObject']
                                  ['nO2Test']['testResult'],
                              so2TestLimit: fmenvtemplates!['returnObject']
                                  ['sO2Test']['testLimit'],
                              so2TestResult: fmenvtemplates!['returnObject']
                                  ['sO2Test']['testResult'],
                              h2STestLimit: fmenvtemplates!['returnObject']
                                  ['h2STest']['testLimit'],
                              h2STestResult: fmenvtemplates!['returnObject']
                                  ['h2STest']['testResult'],
                              combTestLimit: fmenvtemplates!['returnObject']
                                  ['combTest']['testLimit'],
                              combTestResult: fmenvtemplates!['returnObject']
                                  ['combTest']['testResult'],
                              co2TestLimit: fmenvtemplates!['returnObject']
                                  ['cO2Test']['testLimit'],
                              co2TestResult: fmenvtemplates!['returnObject']
                                  ['cO2Test']['testResult'],
                              vocTestLimit: fmenvtemplates!['returnObject']
                                  ['vocTest']['testLimit'],
                              vocTestResult: fmenvtemplates!['returnObject']
                                  ['vocTest']['testResult'],
                              o2TestLimit: fmenvtemplates!['returnObject']
                                  ['o2Test']['testLimit'],
                              o2TestResult: fmenvtemplates!['returnObject']
                                  ['o2Test']['testResult'],
                              coTestLimit: fmenvtemplates!['returnObject']
                                  ['coTest']['testLimit'],
                              coTestResult: fmenvtemplates!['returnObject']
                                  ['coTest']['testResult'],
                              tempTestLimit: fmenvtemplates!['returnObject']
                                  ['tempTest']['testLimit'],
                              tempTestResult: fmenvtemplates!['returnObject']
                                  ['tempTest']['testResult'],
                              pm5TestLimit: fmenvtemplates!['returnObject']
                                  ['tempTest']['testLimit'],
                              pm5TestResult: fmenvtemplates!['returnObject']
                                  ['tempTest']['testResult'],
                              picture: '',
                            );
                            var result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SubmitFMENVPage(
                                      locationId: widget.locationId,
                                          model: model,
                                        )));
                            if (result != null) {
                              getFMENVtemplates();
                            }
                         // }
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

  listTemplateView(
      Map<String, dynamic> data, String title, String subtitle, String? result) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ListTile(
              onTap: () async {
                var result = await Navigator.push(
                    context,
                    MaterialPageRoute<Map<String, dynamic>>(
                        builder: (context) => RunFMENVTestScreen(
                              data: data,
                              title: title,
                            )));
                if (result != null) {
                  await getFMENVtemplates();
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
