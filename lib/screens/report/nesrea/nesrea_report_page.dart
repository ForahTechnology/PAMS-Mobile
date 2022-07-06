import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:pams/samples/custom_drop_down.dart';
import 'package:pams/screens/report/dpr/view_submitted_dpr_test.dart';
import 'package:pams/screens/report/nesrea/submitted_nesrea_implementation.dart';
import 'package:pams/utils/custom_colors.dart';

import 'get_all_nesrea_submitted_test.dart';

class NESREAReportPage extends StatefulWidget {
  @override
  _NESREAReportPageState createState() => _NESREAReportPageState();
}

class _NESREAReportPageState extends State<NESREAReportPage> {
 
 @override
  void initState() {
    super.initState();
    getAllData();
    _controller = new ScrollController()..addListener(_loadMore);
  }

  @override
  void dispose() {
    _controller.removeListener(_loadMore);
    super.dispose();
  }

  List<NESREAList>? data;
  int pageNumber = 1;
  bool _isFirstLoadRunning = false;
  bool _isLoadMoreRunning = false;
  bool _hasNextPage = true;

  Future getAllData() async {
    setState(() {
      _isFirstLoadRunning = true;
    });
    final result =
       await SubmittedNESREAImplementation()
        .getNESREASubmittedResult(pageNumber);
    if (result!.returnObject!.data!.isNotEmpty) {
      setState(() {
        data = result.returnObject!.data;
      });
    }
    setState(() {
      _isFirstLoadRunning = false;
    });
  }

// This function will be triggered whenver the user scroll
  // to near the bottom of the list view
  void _loadMore() async {
    if (_hasNextPage == true &&
        _isFirstLoadRunning == false &&
        _isLoadMoreRunning == false &&
        _controller.position.extentAfter < 300) {
      setState(() {
        _isLoadMoreRunning = true; // Display a progress indicator at the bottom
      });
      pageNumber += 1; // Increase _page by 1
      try {
        final res = await SubmittedNESREAImplementation()
        .getNESREASubmittedResult(pageNumber);

        if (res!.returnObject!.data!.length > 0) {
          setState(() {
            data!.addAll(res.returnObject!.data!);
          });
        } else {
          // This means there is no more data
          // and therefore, we will not send another GET request
          setState(() {
            _hasNextPage = false;
          });
        }
      } catch (err) {
        print('Something went wrong!');
      }

      setState(() {
        _isLoadMoreRunning = false;
      });
    }
  }

  late ScrollController _controller;
  @override
 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        //backgroundColor: HexColor("#26E07F"),
        title: Text(" DPR Activities",
            style: TextStyle(color: Colors.black, fontSize: 20.sp)),
      ),
      backgroundColor: Colors.white,
      body: Container(
        child: _isFirstLoadRunning
            ? Center(
                child: SizedBox(
                  height: 20.w,
                  width: 20.w,
                  child: CircularProgressIndicator(
                    color: CustomColors.mainDarkGreen,
                  ),
                ),
              )
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        controller: _controller,
                        itemCount: data!.length,
                        itemBuilder: (context, index) {
                          return Container(
                              margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
                              //height: 70,
                              width: MediaQuery.of(context).size.width / 1.4,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey[300]!,
                                    offset: Offset(0, 2),
                                    blurRadius: 4,
                                  ),
                                  BoxShadow(
                                    offset: Offset(0, 0.5),
                                  ),
                                ],
                                color: Colors.white,
                              ),
                              child: CustomDropDown(
                                downloadFile: () {},
                                title: Row(
                                  children: [
                                    Text(
                                      data![index].clientName!,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: CustomColors.mainblueColor
                                              .withOpacity(0.8)),
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Text(
                                      data![index].samplePointName!,
                                    ),
                                  ],
                                ),
                                body: Column(
                                  children: [
                                    ListView(
                                      padding: EdgeInsets.all(0),
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      children: [
                                        ListTile(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ViewSubmittedDPRtest(
                                                          testName: 'PMTest',
                                                          name: data![index]
                                                              .pmTest!
                                                              .testName!,
                                                          unit: data![index]
                                                              .pmTest!
                                                              .testUnit!,
                                                          limit: data![index]
                                                                      .pmTest!
                                                                      .testLimit ==
                                                                  null
                                                              ? 'null'
                                                              : data![index]
                                                                  .pmTest!
                                                                  .testLimit,
                                                          result: data![index]
                                                              .pmTest!
                                                              .testResult!,
                                                        )));
                                          },
                                          title: Row(children: <Widget>[
                                            Text("PMTest", style: TextStyle()),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                                "${data![index].pmTest!.testName!}",
                                                style: TextStyle()),
                                          ]),
                                          subtitle: Row(
                                            children: <Widget>[
                                              Text(DateFormat('d MMMM y')
                                                  .format(
                                                    data![index].time!,
                                                  )
                                                  .toString()),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(DateFormat('HH:mm:ss')
                                                  .format(
                                                    data![index].time!,
                                                  )
                                                  .toString()),
                                            ],
                                          ),
                                          trailing: Text("Delivered",
                                              style: TextStyle()),
                                        ),
                                        Divider(),
                                        ListTile(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ViewSubmittedDPRtest(
                                                           testName: 'HMTest',
                                                          name: data![index]
                                                              .hmTest!
                                                              .testName!,
                                                          unit: data![index]
                                                              .hmTest!
                                                              .testUnit!,
                                                          limit: data![index]
                                                                      .hmTest!
                                                                      .testLimit ==
                                                                  null
                                                              ? 'null'
                                                              : data![index]
                                                                  .hmTest!
                                                                  .testLimit,
                                                          result: data![index]
                                                              .hmTest!
                                                              .testResult!,
                                                        )));
                                          },
                                          title: Row(children: <Widget>[
                                            Text("HMTest", style: TextStyle()),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                                "${data![index].hmTest!.testName!}",
                                                style: TextStyle()),
                                          ]),
                                          subtitle: Row(
                                            children: <Widget>[
                                              Text(DateFormat('d MMMM y')
                                                  .format(
                                                    data![index].time!,
                                                  )
                                                  .toString()),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(DateFormat('HH:mm:ss')
                                                  .format(
                                                    data![index].time!,
                                                  )
                                                  .toString()),
                                            ],
                                          ),
                                          trailing: Text("Delivered",
                                              style: TextStyle()),
                                        ),
                                        Divider(),
                                        ListTile(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ViewSubmittedDPRtest(
                                                          testName: 'NoiseTest',
                                                          name: data![index]
                                                              .noiseTest!
                                                              .testName!,
                                                          unit: data![index]
                                                              .noiseTest!
                                                              .testUnit!,
                                                          limit: data![index]
                                                                      .noiseTest!
                                                                      .testLimit ==
                                                                  null
                                                              ? 'null'
                                                              : data![index]
                                                                  .noiseTest!
                                                                  .testLimit,
                                                          result: data![index]
                                                              .noiseTest!
                                                              .testResult!,
                                                        )));
                                          },
                                          title: Row(children: <Widget>[
                                            Text("NoiseTest",
                                                style: TextStyle()),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                                "${data![index].noiseTest!.testName!}",
                                                style: TextStyle()),
                                          ]),
                                          subtitle: Row(
                                            children: <Widget>[
                                              Text(DateFormat('d MMMM y')
                                                  .format(
                                                    data![index].time!,
                                                  )
                                                  .toString()),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(DateFormat('HH:mm:ss')
                                                  .format(
                                                    data![index].time!,
                                                  )
                                                  .toString()),
                                            ],
                                          ),
                                          trailing: Text("Delivered",
                                              style: TextStyle()),
                                        ),
                                        Divider(),
                                        ListTile(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ViewSubmittedDPRtest(
                                                           testName: 'NO2Test',
                                                          name: data![index]
                                                              .nO2Test!
                                                              .testName!,
                                                          unit: data![index]
                                                              .nO2Test!
                                                              .testUnit!,
                                                          limit: data![index]
                                                                      .nO2Test!
                                                                      .testLimit ==
                                                                  null
                                                              ? 'null'
                                                              : data![index]
                                                                  .nO2Test!
                                                                  .testLimit,
                                                          result: data![index]
                                                              .nO2Test!
                                                              .testResult!,
                                                        )));
                                          },
                                          title: Row(children: <Widget>[
                                            Text("NO2Test", style: TextStyle()),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                                "${data![index].nO2Test!.testName!}",
                                                style: TextStyle()),
                                          ]),
                                          subtitle: Row(
                                            children: <Widget>[
                                              Text(DateFormat('d MMMM y')
                                                  .format(
                                                    data![index].time!,
                                                  )
                                                  .toString()),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(DateFormat('HH:mm:ss')
                                                  .format(
                                                    data![index].time!,
                                                  )
                                                  .toString()),
                                            ],
                                          ),
                                          trailing: Text("Delivered",
                                              style: TextStyle()),
                                        ),
                                        Divider(),
                                        ListTile(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ViewSubmittedDPRtest(
                                                           testName: 'SO2Test',
                                                          name: data![index]
                                                              .sO2Test!
                                                              .testName!,
                                                          unit: data![index]
                                                              .sO2Test!
                                                              .testUnit!,
                                                          limit: data![index]
                                                                      .sO2Test!
                                                                      .testLimit ==
                                                                  null
                                                              ? 'null'
                                                              : data![index]
                                                                  .sO2Test!
                                                                  .testLimit,
                                                          result: data![index]
                                                              .sO2Test!
                                                              .testResult!,
                                                        )));
                                          },
                                          title: Row(children: <Widget>[
                                            Text("SO2Test", style: TextStyle()),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                                "${data![index].sO2Test!.testName!}",
                                                style: TextStyle()),
                                          ]),
                                          subtitle: Row(
                                            children: <Widget>[
                                              Text(DateFormat('d MMMM y')
                                                  .format(
                                                    data![index].time!,
                                                  )
                                                  .toString()),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(DateFormat('HH:mm:ss')
                                                  .format(
                                                    data![index].time!,
                                                  )
                                                  .toString()),
                                            ],
                                          ),
                                          trailing: Text("Delivered",
                                              style: TextStyle()),
                                        ),
                                        Divider(),
                                        ListTile(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ViewSubmittedDPRtest(
                                                          testName: 'H2STest',
                                                          name: data![index]
                                                              .h2STest!
                                                              .testName!,
                                                          unit: data![index]
                                                              .h2STest!
                                                              .testUnit!,
                                                          limit: data![index]
                                                                      .h2STest!
                                                                      .testLimit ==
                                                                  null
                                                              ? 'null'
                                                              : data![index]
                                                                  .h2STest!
                                                                  .testLimit,
                                                          result: data![index]
                                                              .h2STest!
                                                              .testResult!,
                                                        )));
                                          },
                                          title: Row(children: <Widget>[
                                            Text("H2STest", style: TextStyle()),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                                "${data![index].h2STest!.testName!}",
                                                style: TextStyle()),
                                          ]),
                                          subtitle: Row(
                                            children: <Widget>[
                                              Text(DateFormat('d MMMM y')
                                                  .format(
                                                    data![index].time!,
                                                  )
                                                  .toString()),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(DateFormat('HH:mm:ss')
                                                  .format(
                                                    data![index].time!,
                                                  )
                                                  .toString()),
                                            ],
                                          ),
                                          trailing: Text("Delivered",
                                              style: TextStyle()),
                                        ),
                                        Divider(),
                                        ListTile(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ViewSubmittedDPRtest(
                                                           testName: 'CombTest',
                                                          name: data![index]
                                                              .combTest!
                                                              .testName!,
                                                          unit: data![index]
                                                              .combTest!
                                                              .testUnit!,
                                                          limit: data![index]
                                                                      .combTest!
                                                                      .testLimit ==
                                                                  null
                                                              ? 'null'
                                                              : data![index]
                                                                  .combTest!
                                                                  .testLimit,
                                                          result: data![index]
                                                              .combTest!
                                                              .testResult!,
                                                        )));
                                          },
                                          title: Row(children: <Widget>[
                                            Text("CombTest",
                                                style: TextStyle()),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                                "${data![index].combTest!.testName!}",
                                                style: TextStyle()),
                                          ]),
                                          subtitle: Row(
                                            children: <Widget>[
                                              Text(DateFormat('d MMMM y')
                                                  .format(
                                                    data![index].time!,
                                                  )
                                                  .toString()),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(DateFormat('HH:mm:ss')
                                                  .format(
                                                    data![index].time!,
                                                  )
                                                  .toString()),
                                            ],
                                          ),
                                          trailing: Text("Delivered",
                                              style: TextStyle()),
                                        ),
                                        Divider(),
                                        ListTile(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ViewSubmittedDPRtest(
                                                           testName: 'CO2Test',
                                                          name: data![index]
                                                              .cO2Test!
                                                              .testName!,
                                                          unit: data![index]
                                                              .cO2Test!
                                                              .testUnit!,
                                                          limit: data![index]
                                                                      .cO2Test!
                                                                      .testLimit ==
                                                                  null
                                                              ? 'null'
                                                              : data![index]
                                                                  .cO2Test!
                                                                  .testLimit,
                                                          result: data![index]
                                                              .cO2Test!
                                                              .testResult!,
                                                        )));
                                          },
                                          title: Row(children: <Widget>[
                                            Text("CO2Test", style: TextStyle()),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                                "${data![index].cO2Test!.testName!}",
                                                style: TextStyle()),
                                          ]),
                                          subtitle: Row(
                                            children: <Widget>[
                                              Text(DateFormat('d MMMM y')
                                                  .format(
                                                    data![index].time!,
                                                  )
                                                  .toString()),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(DateFormat('HH:mm:ss')
                                                  .format(
                                                    data![index].time!,
                                                  )
                                                  .toString()),
                                            ],
                                          ),
                                          trailing: Text("Delivered",
                                              style: TextStyle()),
                                        ),
                                        Divider(),
                                        ListTile(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ViewSubmittedDPRtest(
                                                           testName: 'VocTest',
                                                          name: data![index]
                                                              .vocTest!
                                                              .testName!,
                                                          unit: data![index]
                                                              .vocTest!
                                                              .testUnit!,
                                                          limit: data![index]
                                                                      .vocTest!
                                                                      .testLimit ==
                                                                  null
                                                              ? 'null'
                                                              : data![index]
                                                                  .vocTest!
                                                                  .testLimit,
                                                          result: data![index]
                                                              .vocTest!
                                                              .testResult!,
                                                        )));
                                          },
                                          title: Row(children: <Widget>[
                                            Text("VocTest", style: TextStyle()),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                                "${data![index].vocTest!.testName!}",
                                                style: TextStyle()),
                                          ]),
                                          subtitle: Row(
                                            children: <Widget>[
                                              Text(DateFormat('d MMMM y')
                                                  .format(
                                                    data![index].time!,
                                                  )
                                                  .toString()),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(DateFormat('HH:mm:ss')
                                                  .format(
                                                    data![index].time!,
                                                  )
                                                  .toString()),
                                            ],
                                          ),
                                          trailing: Text("Delivered",
                                              style: TextStyle()),
                                        ),
                                        Divider(),
                                        ListTile(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ViewSubmittedDPRtest(
                                                          testName: 'O2Test',
                                                          name: data![index]
                                                              .o2Test!
                                                              .testName!,
                                                          unit: data![index]
                                                              .o2Test!
                                                              .testUnit!,
                                                          limit: data![index]
                                                                      .o2Test!
                                                                      .testLimit ==
                                                                  null
                                                              ? 'null'
                                                              : data![index]
                                                                  .o2Test!
                                                                  .testLimit,
                                                          result: data![index]
                                                              .o2Test!
                                                              .testResult!,
                                                        )));
                                          },
                                          title: Row(children: <Widget>[
                                            Text("O2Test", style: TextStyle()),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                                "${data![index].o2Test!.testName!}",
                                                style: TextStyle()),
                                          ]),
                                          subtitle: Row(
                                            children: <Widget>[
                                              Text(DateFormat('d MMMM y')
                                                  .format(
                                                    data![index].time!,
                                                  )
                                                  .toString()),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(DateFormat('HH:mm:ss')
                                                  .format(
                                                    data![index].time!,
                                                  )
                                                  .toString()),
                                            ],
                                          ),
                                          trailing: Text("Delivered",
                                              style: TextStyle()),
                                        ),
                                        Divider(),
                                        ListTile(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ViewSubmittedDPRtest(
                                                          testName: 'CoTest',
                                                          name: data![index]
                                                              .coTest!
                                                              .testName!,
                                                          unit: data![index]
                                                              .coTest!
                                                              .testUnit!,
                                                          limit: data![index]
                                                                      .coTest!
                                                                      .testLimit ==
                                                                  null
                                                              ? 'null'
                                                              : data![index]
                                                                  .coTest!
                                                                  .testLimit,
                                                          result: data![index]
                                                              .coTest!
                                                              .testResult!,
                                                        )));
                                          },
                                          title: Row(children: <Widget>[
                                            Text("CoTest", style: TextStyle()),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                                "${data![index].coTest!.testName!}",
                                                style: TextStyle()),
                                          ]),
                                          subtitle: Row(
                                            children: <Widget>[
                                              Text(DateFormat('d MMMM y')
                                                  .format(
                                                    data![index].time!,
                                                  )
                                                  .toString()),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(DateFormat('HH:mm:ss')
                                                  .format(
                                                    data![index].time!,
                                                  )
                                                  .toString()),
                                            ],
                                          ),
                                          trailing: Text("Delivered",
                                              style: TextStyle()),
                                        ),
                                        Divider(),
                                        ListTile(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ViewSubmittedDPRtest(
                                                          testName: 'TempTest',
                                                          name: data![index]
                                                              .tempTest!
                                                              .testName!,
                                                          unit: data![index]
                                                              .tempTest!
                                                              .testUnit!,
                                                          limit: data![index]
                                                                      .tempTest!
                                                                      .testLimit ==
                                                                  null
                                                              ? 'null'
                                                              : data![index]
                                                                  .tempTest!
                                                                  .testLimit,
                                                          result: data![index]
                                                              .tempTest!
                                                              .testResult!,
                                                        )));
                                          },
                                          title: Row(children: <Widget>[
                                            Text("TempTest",
                                                style: TextStyle()),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                                "${data![index].tempTest!.testName!}",
                                                style: TextStyle()),
                                          ]),
                                          subtitle: Row(
                                            children: <Widget>[
                                              Text(DateFormat('d MMMM y')
                                                  .format(
                                                    data![index].time!,
                                                  )
                                                  .toString()),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(DateFormat('HH:mm:ss')
                                                  .format(
                                                    data![index].time!,
                                                  )
                                                  .toString()),
                                            ],
                                          ),
                                          trailing: Text("Delivered",
                                              style: TextStyle()),
                                        ),
                                        Divider(),
                                        ListTile(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ViewSubmittedDPRtest(
                                                          testName: 'PM5Test',
                                                          name: data![index]
                                                              .pM5Test!
                                                              .testName!,
                                                          unit: data![index]
                                                              .pM5Test!
                                                              .testUnit!,
                                                          limit: data![index]
                                                                      .pM5Test!
                                                                      .testLimit ==
                                                                  null
                                                              ? 'null'
                                                              : data![index]
                                                                  .pM5Test!
                                                                  .testLimit,
                                                          result: data![index]
                                                              .pM5Test!
                                                              .testResult!,
                                                        )));
                                          },
                                          title: Row(children: <Widget>[
                                            Text("PM5Test", style: TextStyle()),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                                "${data![index].pM5Test!.testName!}",
                                                style: TextStyle()),
                                          ]),
                                          subtitle: Row(
                                            children: <Widget>[
                                              Text(DateFormat('d MMMM y')
                                                  .format(
                                                    data![index].time!,
                                                  )
                                                  .toString()),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(DateFormat('HH:mm:ss')
                                                  .format(
                                                    data![index].time!,
                                                  )
                                                  .toString()),
                                            ],
                                          ),
                                          trailing: Text("Delivered",
                                              style: TextStyle()),
                                        ),
                                        Divider(),
                                      ],
                                    ),
                                  ],
                                ),
                              ));
                        }),
                  ),
                  // when the _loadMore function is running
                  if (_isLoadMoreRunning == true)
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 40),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),

                  // When nothing else to load
                  if (_hasNextPage == false)
                    Container(
                      padding: const EdgeInsets.only(top: 30, bottom: 40),
                      color: CustomColors.mainDarkGreen,
                      child: Center(
                        child: Text(
                          'You have fetched all of data',
                          style: TextStyle(color: CustomColors.background),
                        ),
                      ),
                    ),
                ],
              ),
      ),
    );
  }


}
