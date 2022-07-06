import 'package:flutter/material.dart';
import 'package:pams/screens/clients/dpr/dpr_screen.dart';

import '../../../utils/constants.dart';
import '../../../utils/custom_colors.dart';
import 'nesrea_implementation.dart';

class RunNESREATestScreen extends StatefulWidget {
  final Map<String, dynamic>? data;
  final String? title;
  final int? locationId;

  const RunNESREATestScreen({Key? key, this.data, this.title, this.locationId})
      : super(key: key);

  @override
  _RunNESREATestScreenState createState() => _RunNESREATestScreenState();
}

class _RunNESREATestScreenState extends State<RunNESREATestScreen> {
  TextEditingController testName = TextEditingController();
  TextEditingController testUnit = TextEditingController();
  TextEditingController testLimit = TextEditingController();
  TextEditingController testResult = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    updateFields();
  }

  updateFields() async {
    testName.text = widget.data!['testName'];
    testUnit.text = widget.data!['testUnit'];
    if (widget.data!['testLimit'] == null) {
      setState(() {
        testLimit.text = '';
      });
    } else {
      setState(() {
        testLimit.text = widget.data!['testLimit'];
      });
    }
    if (widget.data!['testResult'] == 0.0) {
      setState(() {
        testResult.text = '';
      });
    } else {
      setState(() {
        testResult.text = widget.data!['testResult'].toString();
      });
    }
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
        title: Text(widget.title!,
            style: TextStyle(color: Colors.black, fontSize: 20)),
      ),
      backgroundColor: CustomColors.background,
      body: Container(
        margin: EdgeInsets.fromLTRB(20, 40, 20, 0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: testName,
                readOnly: true,
                validator: (value) {
                  if (value!.isEmpty == true) {
                    return 'Field is required';
                  }
                },
                decoration: InputDecoration(
                    label: Text('Test Name'),
                    hintText: 'Test Name',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              SizedBox(
                height: 40,
              ),
              TextFormField(
                controller: testUnit,
                readOnly: true,
                validator: (value) {
                  if (value!.isEmpty == true) {
                    return 'Field is required';
                  }
                },
                decoration: InputDecoration(
                    label: Text('Test Unit'),
                    hintText: 'Test Unit',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              SizedBox(
                height: 40,
              ),
              TextFormField(
                controller: testLimit,
                validator: (value) {
                  if (value!.isEmpty == true) {
                    return 'Field is required';
                  }
                },
                decoration: InputDecoration(
                    label: Text('Test Limit'),
                    hintText: 'Test Limit',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              SizedBox(
                height: 40,
              ),
              TextFormField(
                controller: testResult,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty == true) {
                    return 'Field is required';
                  }
                },
                decoration: InputDecoration(
                    label: Text('Test Result'),
                    hintText: 'Test Result',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Colors.white,
        child: InkWell(
          onTap: () async {
            runTest();
          },
          child: Container(
            margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
            height: 60,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: CustomColors.mainDarkGreen,
                borderRadius: BorderRadius.circular(10)),
            child: Center(
              child: update
                  ? SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: CustomColors.background,
                      ),
                    )
                  : Text(
                      'Save',
                      style: TextStyle(
                          color: CustomColors.background, fontSize: 18),
                    ),
            ),
          ),
        ),
      ),
    );
  }

  bool update = false;
  Future runTest() async {
    setState(() {
      update = true;
    });

    final form = _formKey.currentState;
    if (!form!.validate()) {
      setState(() {
        update = false;
      });
    } else {
      form.save();
      final result = await NESREAImplementation()
          .runTest(widget.data!['nesreaFieldId'], testName.text.toString(), testLimit.text.toString(),
              testResult.text.toString())
          .catchError((onError) {
        setState(() {
          update = false;
        });
        Constants().notify('Oops... Something went wrong, Try again later');
      });
      print('done $result');
      if (result!['status'] == true) {
        Constants().notify(result['returnObject']);
        await getNESREAtemplates();
        if (nesreatemplates != null) {
          setState(() {
            update = false;
          });
          Navigator.of(context).pop(nesreatemplates);
        }
      } else {
        setState(() {
          update = false;
        });
      }
    }
  }

  // execute this function below after a running the above function.
  Map<String, dynamic>? nesreatemplates;

  Future getNESREAtemplates() async {
    final result =
        await NESREAImplementation().getNESREATemplates(widget.locationId);
    if (result != null) {
      setState(() {
        nesreatemplates = result;
      });
    }
  }
}
