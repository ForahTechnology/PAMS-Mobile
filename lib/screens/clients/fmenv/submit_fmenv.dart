import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pams/screens/clients/dpr/dpr_implementation.dart';
import 'package:pams/screens/clients/dpr/submit_data_model.dart';
import 'package:pams/screens/clients/fmenv/fmenv_implementation.dart';
import 'package:pams/screens/clients/fmenv/submitfmenv_data_model.dart';
import 'package:pams/screens/homepage.dart';
import 'package:pams/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/custom_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http_parser/http_parser.dart';

class SubmitFMENVPage extends StatefulWidget {
  final SubmitFMENVData? model;
  final int? locationId;

  const SubmitFMENVPage({Key? key, this.model, this.locationId})
      : super(key: key);

  @override
  _SubmitFMENVPageState createState() => _SubmitFMENVPageState();
}

class _SubmitFMENVPageState extends State<SubmitFMENVPage> {
  @override
  void initState() {
    super.initState();
  }

  XFile? _image;
  final ImagePicker _picker = ImagePicker();

  takePhoto(ImageSource source, cxt) async {
    final pickedFile = await _picker.pickImage(
        source: source, imageQuality: 50, maxHeight: 500.0, maxWidth: 500.0);
    setState(() {
      _image = pickedFile;
    });

    // Navigator.pop(cxt);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("Submit FMENV Test",
            style: TextStyle(color: Colors.black, fontSize: 20)),
      ),
      backgroundColor: CustomColors.background,
      body: Container(
        margin: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Take a photo to proceed',
              style: TextStyle(fontSize: 17.sp),
            ),
            SizedBox(
              height: 20.h,
            ),
            _image == null
                ? InkWell(
                    onTap: () async {
                      await takePhoto(ImageSource.camera, context);
                    },
                    child: Container(
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/field.jpg'),
                            fit: BoxFit.fitWidth),
                      ),
                    ),
                  )
                : InkWell(
                    onTap: () async {
                      await takePhoto(ImageSource.camera, context);
                    },
                    child: Container(
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.withOpacity(0.2)),
                        image: DecorationImage(
                            fit: BoxFit.contain,
                            image: FileImage(
                              File(_image!.path.toString()),
                            )),
                      ),
                    ),
                  ),
            SizedBox(
              height: 20.h,
            ),
            InkWell(
              onTap: () async {
                await takePhoto(ImageSource.camera, context);
              },
              child: Center(
                  child: Icon(
                Icons.camera,
                color: CustomColors.mainDarkGreen,
                size: 30,
              )),
            ),
            // Text(widget.latitude!.toString()),
            // Text(widget.longitude!.toString()),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Colors.white,
        child: InkWell(
          onTap: _image == null
              ? () async {
                  Constants().notify('Upload Image to proceed');
                }
              : () async {
                  await submitTest();
                },
          child: Container(
            margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
            height: 60,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color:
                    _image == null ? Colors.grey : CustomColors.mainDarkGreen,
                borderRadius: BorderRadius.circular(10)),
            child: Center(
              child: submit
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
                          color: CustomColors.background, fontSize: 18),
                    ),
            ),
          ),
        ),
      ),
    );
  }

  bool submit = false;
  Future submitTest() async {
    setState(() {
      submit = true;
    });
    String fileName = _image!.path.split('/').last;
    print(fileName);

    SubmitFMENVData model = SubmitFMENVData(
      samplePtId: widget.model!.samplePtId!,
      fmenvFieldId: widget.model!.fmenvFieldId,
      latitude: widget.model!.latitude,
      longitude: widget.model!.longitude,
      pmTestLimit: widget.model!.pmTestLimit,
      pmTestResult: widget.model!.pmTestResult,
      hmTestLimit: widget.model!.hmTestLimit,
      hmTestResult: widget.model!.hmTestResult,
      noiseTestLimit: widget.model!.noiseTestLimit,
      noiseTestResult: widget.model!.noiseTestResult,
      no2TestLimit: widget.model!.no2TestLimit,
      no2TestResult: widget.model!.no2TestResult,
      so2TestLimit: widget.model!.so2TestLimit,
      so2TestResult: widget.model!.so2TestResult,
      h2STestLimit: widget.model!.h2STestLimit,
      h2STestResult: widget.model!.h2STestResult,
      combTestLimit: widget.model!.combTestLimit,
      combTestResult: widget.model!.combTestResult,
      co2TestLimit: widget.model!.co2TestLimit,
      co2TestResult: widget.model!.co2TestResult,
      vocTestLimit: widget.model!.vocTestLimit,
      vocTestResult: widget.model!.vocTestResult,
      o2TestLimit: widget.model!.o2TestLimit,
      o2TestResult: widget.model!.o2TestResult,
      coTestLimit: widget.model!.coTestLimit,
      coTestResult: widget.model!.coTestResult,
      tempTestLimit: widget.model!.tempTestLimit,
      tempTestResult: widget.model!.tempTestResult,
      pm5TestLimit: widget.model!.pm5TestLimit,
      pm5TestResult: widget.model!.pm5TestResult,
      picture: await MultipartFile.fromFile(_image!.path,
          filename: fileName, contentType: MediaType('image', 'jpg')),
    );

    var dio = Dio();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('apiToken');
    var postbody = FormData.fromMap(model.toJson());

    var url = Constants.base_url +
        "/FieldScientistAnalysisFMEnv/submit-fmenv-test-Testresult";
    final response = await dio.post(url,
        data: postbody,
        options: Options(headers: {
          'content-type': 'multipart/form-data',
          'accept': 'application/json',
          'Authorization': 'Bearer $token',
        }));
    // print(postbody);
    // print(response.data);
    if (response.data['status'] == true) {
      await getFMENVtemplates();
      Constants().notify(response.data['returnObject']);
      if (fmenvtemplates != null) {
        setState(() {
          submit = false;
        });
        Navigator.of(context).pop(fmenvtemplates);
      }
    } else {
      setState(() {
        submit = false;
      });
      Constants().notify(response.data['returnObject']);
    }
    return (response.data);
  }

  Map<String, dynamic>? fmenvtemplates;
  Future getFMENVtemplates() async {
    final result =
        await FMENVImplementation().getFMENVTemplates(widget.locationId);
    if (result != null) {
      setState(() {
        fmenvtemplates = result;
      });
    }
  }
}
