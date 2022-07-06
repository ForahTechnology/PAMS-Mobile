import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pams/screens/clients/dpr/dpr_implementation.dart';
import 'package:pams/screens/clients/dpr/run_test.dart';
import 'package:pams/screens/clients/dpr/submit_data_model.dart';
import 'package:pams/screens/clients/dpr/submit_dpr.dart';
import 'package:pams/utils/constants.dart';
import 'package:pams/utils/custom_colors.dart';

class DPRScreen extends StatefulWidget {
  final int? locationId;

  const DPRScreen({Key? key, this.locationId}) : super(key: key);

  @override
  _DPRScreenState createState() => _DPRScreenState();
}

class _DPRScreenState extends State<DPRScreen> {
  Map<String, dynamic>? dprtemplates;
  @override
  void initState() {
    super.initState();
    getDPRtemplates();
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
  Future getDPRtemplates() async {
    final result = await DPRImplementation().getDPRTemplates(widget.locationId);
    if (result != null) {
      setState(() {
        dprtemplates = result;
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
          title: Text("DPR Template",
              style: TextStyle(color: Colors.black, fontSize: 20)),
        ),
        backgroundColor: CustomColors.background,
        body: dprtemplates == null
            ? Center(
                child: SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    color: CustomColors.mainDarkGreen,
                  ),
                ),
              )
            : dprtemplates!['status'] == true
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
                          dprtemplates!['returnObject']['pmTest'],
                          'PM Test',
                          dprtemplates!['returnObject']['pmTest']['testName'],
                          dprtemplates!['returnObject']['pmTest']
                              ['testResult']),
                      listTemplateView(
                          dprtemplates!['returnObject']['hmTest'],
                          'HM Test',
                          dprtemplates!['returnObject']['hmTest']['testName'],
                          dprtemplates!['returnObject']['hmTest']
                              ['testResult']),
                      listTemplateView(
                          dprtemplates!['returnObject']['noiseTest'],
                          'Noise Test',
                          dprtemplates!['returnObject']['noiseTest']
                              ['testName'],
                          dprtemplates!['returnObject']['noiseTest']
                              ['testResult']),
                      listTemplateView(
                          dprtemplates!['returnObject']['nO2Test'],
                          'NO2 Test',
                          dprtemplates!['returnObject']['nO2Test']['testName'],
                          dprtemplates!['returnObject']['nO2Test']
                              ['testResult']),
                      listTemplateView(
                          dprtemplates!['returnObject']['sO2Test'],
                          'SO2 Test',
                          dprtemplates!['returnObject']['sO2Test']['testName'],
                          dprtemplates!['returnObject']['sO2Test']
                              ['testResult']),
                      listTemplateView(
                          dprtemplates!['returnObject']['h2STest'],
                          'H2S Test',
                          dprtemplates!['returnObject']['h2STest']['testName'],
                          dprtemplates!['returnObject']['h2STest']
                              ['testResult']),
                      listTemplateView(
                          dprtemplates!['returnObject']['combTest'],
                          'Comb Test',
                          dprtemplates!['returnObject']['combTest']['testName'],
                          dprtemplates!['returnObject']['combTest']
                              ['testResult']),
                      listTemplateView(
                          dprtemplates!['returnObject']['cO2Test'],
                          'CO2 Test',
                          dprtemplates!['returnObject']['cO2Test']['testName'],
                          dprtemplates!['returnObject']['cO2Test']
                              ['testResult']),
                      listTemplateView(
                          dprtemplates!['returnObject']['vocTest'],
                          'VOC Test',
                          dprtemplates!['returnObject']['vocTest']['testName'],
                          dprtemplates!['returnObject']['vocTest']
                              ['testResult']),
                      listTemplateView(
                          dprtemplates!['returnObject']['o2Test'],
                          'O2 Test',
                          dprtemplates!['returnObject']['o2Test']['testName'],
                          dprtemplates!['returnObject']['o2Test']
                              ['testResult']),
                      listTemplateView(
                          dprtemplates!['returnObject']['coTest'],
                          'CO Test',
                          dprtemplates!['returnObject']['coTest']['testName'],
                          dprtemplates!['returnObject']['coTest']
                              ['testResult']),
                      listTemplateView(
                          dprtemplates!['returnObject']['tempTest'],
                          'TEMP Test',
                          dprtemplates!['returnObject']['tempTest']['testName'],
                          dprtemplates!['returnObject']['tempTest']
                              ['testResult']),
                      listTemplateView(
                          dprtemplates!['returnObject']['pM5Test'],
                          'PM5 Test',
                          dprtemplates!['returnObject']['pM5Test']['testName'],
                          dprtemplates!['returnObject']['pM5Test']
                              ['testResult']),
                      SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () async {
                          // if (dprtemplates!['returnObject']['pmTest']['testResult'] == null ||
                          //     dprtemplates!['returnObject']['hmTest']['testResult'] ==
                          //         null ||
                          //     dprtemplates!['returnObject']['noiseTest']
                          //             ['testResult'] ==
                          //         null ||
                          //     dprtemplates!['returnObject']['nO2Test']
                          //             ['testResult'] ==
                          //         null ||
                          //     dprtemplates!['returnObject']['sO2Test']
                          //             ['testResult'] ==
                          //         null ||
                          //     dprtemplates!['returnObject']['h2STest']
                          //             ['testResult'] ==
                          //         null ||
                          //     dprtemplates!['returnObject']['combTest']
                          //             ['testResult'] ==
                          //         null ||
                          //     dprtemplates!['returnObject']['cO2Test']
                          //             ['testResult'] ==
                          //         null ||
                          //     dprtemplates!['returnObject']['vocTest']
                          //             ['testResult'] ==
                          //         null ||
                          //     dprtemplates!['returnObject']['o2Test']['testResult'] ==
                          //         null ||
                          //     dprtemplates!['returnObject']['coTest']
                          //             ['testResult'] ==
                          //         null ||
                          //     dprtemplates!['returnObject']['tempTest']
                          //             ['testResult'] ==
                          //         null ||
                          //     dprtemplates!['returnObject']['pM5Test']['testResult'] == null) {
                          //   Constants()
                          //       .notify('Please complete all test to proceed');
                          // } else {
                          SubmitData model = SubmitData(
                            samplePtId: dprtemplates!['returnObject']
                                ['samplePointLocationId'],
                            dprFieldId: dprtemplates!['returnObject']['id'],
                            latitude: latitude,
                            longitude: longitude,
                            pmTestLimit: dprtemplates!['returnObject']['pmTest']
                                ['testLimit'],
                            pmTestResult: dprtemplates!['returnObject']
                                ['pmTest']['testResult'],
                            hmTestLimit: dprtemplates!['returnObject']['hmTest']
                                ['testLimit'],
                            hmTestResult: dprtemplates!['returnObject']
                                ['hmTest']['testResult'],
                            noiseTestLimit: dprtemplates!['returnObject']
                                ['noiseTest']['testLimit'],
                            noiseTestResult: dprtemplates!['returnObject']
                                ['noiseTest']['testResult'],
                            no2TestLimit: dprtemplates!['returnObject']
                                ['nO2Test']['testLimit'],
                            no2TestResult: dprtemplates!['returnObject']
                                ['nO2Test']['testResult'],
                            so2TestLimit: dprtemplates!['returnObject']
                                ['sO2Test']['testLimit'],
                            so2TestResult: dprtemplates!['returnObject']
                                ['sO2Test']['testResult'],
                            h2STestLimit: dprtemplates!['returnObject']
                                ['h2STest']['testLimit'],
                            h2STestResult: dprtemplates!['returnObject']
                                ['h2STest']['testResult'],
                            combTestLimit: dprtemplates!['returnObject']
                                ['combTest']['testLimit'],
                            combTestResult: dprtemplates!['returnObject']
                                ['combTest']['testResult'],
                            co2TestLimit: dprtemplates!['returnObject']
                                ['cO2Test']['testLimit'],
                            co2TestResult: dprtemplates!['returnObject']
                                ['cO2Test']['testResult'],
                            vocTestLimit: dprtemplates!['returnObject']
                                ['vocTest']['testLimit'],
                            vocTestResult: dprtemplates!['returnObject']
                                ['vocTest']['testResult'],
                            o2TestLimit: dprtemplates!['returnObject']['o2Test']
                                ['testLimit'],
                            o2TestResult: dprtemplates!['returnObject']
                                ['o2Test']['testResult'],
                            coTestLimit: dprtemplates!['returnObject']['coTest']
                                ['testLimit'],
                            coTestResult: dprtemplates!['returnObject']
                                ['coTest']['testResult'],
                            tempTestLimit: dprtemplates!['returnObject']
                                ['tempTest']['testLimit'],
                            tempTestResult: dprtemplates!['returnObject']
                                ['tempTest']['testResult'],
                            pm5TestLimit: dprtemplates!['returnObject']
                                ['tempTest']['testLimit'],
                            pm5TestResult: dprtemplates!['returnObject']
                                ['tempTest']['testResult'],
                            picture: '',
                          );
                          var result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SubmitDPRPage(
                                        locationId: widget.locationId,
                                        model: model,
                                      )));

                          if (result != null) {
                            getDPRtemplates();
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
                        builder: (context) => RunTestScreen(
                              data: data,
                              title: title,
                            )));
                if (result != null) {
                  await getDPRtemplates();
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
