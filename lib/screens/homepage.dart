import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pams/screens/clients/customerList.dart';
import 'package:pams/screens/notification.dart';
import 'package:pams/screens/profile.dart';
import 'package:pams/screens/report/dpr/dpr_report_page.dart';
import 'package:pams/screens/report/select_report_template_type.dart';
import 'package:pams/utils/custom_colors.dart';
import 'package:pams/utils/shared_pref_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String? myName;
  String? role;
  @override
  void initState() {
    super.initState();
    getDetails();
  }

  Future getDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var name = prefs.getString('fullname');
    var drole = prefs.getString('role');
    setState(() {
      myName = name;
      role = drole;
    });
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit an App'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: new Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 3.0,
              decoration: BoxDecoration(
                  color: CustomColors.mainDarkGreen,
                  image: DecorationImage(
                      fit: BoxFit.fill, image: AssetImage('assets/pams.png')),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30))),
              child: Container(
                margin: EdgeInsets.fromLTRB(15, 20, 15, 0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ProfilePage()));
                            },
                            icon: Icon(
                              Icons.menu,
                              size: 40,
                              color: Colors.black,
                            )),
                        InkWell(
                          onTap: () {
                            // Navigator.of(context).push(MaterialPageRoute(
                            //     builder: (context) => NotificationPage()));
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            //color: HexColor("#44F599")),
                            child: Icon(Icons.notification_important,
                                color: Colors.black),
                          ),
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 50),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Hello',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                      fontSize: 20)),
                              Text('$myName',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17))
                            ],
                          ),
                          SizedBox(width: 10.w),
                          Container(
                            height: 80.w,
                            width: 60.w,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage("assets/avatar.png")),
                                border: Border.all(
                                  color: Colors.white,
                                  style: BorderStyle.solid,
                                  width: 4.0,
                                ),
                                shape: BoxShape.circle),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'My Tasks',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 19.sp,
                        fontWeight: FontWeight.w500),
                  ),
                  Container(
                    height: 30.w,
                    width: 30.w,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.lightBlueAccent),
                    child: Icon(
                      Icons.calendar_today_outlined,
                      color: Colors.white,
                      size: 15,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            // myTaskWidget(
            //     'Failed', Icons.close, '5 tasks failed', Colors.red.shade300),
            // SizedBox(
            //   height: 20,
            // ),
            myTaskWidget(
              'Pending',
              Icons.timelapse_outlined,
              '3 tasks pending',
              Colors.orange,
            ),
            SizedBox(
              height: 20.h,
            ),
            myTaskWidget(
              'Delivered',
              Icons.done,
              '9 tasks delivered',
              Colors.green,
            ),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'What do you want to do today?',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(height: 50.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CustomerList()));
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height / 5,
                      width: MediaQuery.of(context).size.width / 2.5,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 1,
                              offset:
                                  Offset(0, 0.5), // changes position of shadow
                            ),
                          ],
                          color: CustomColors.Darkblue,
                          borderRadius: BorderRadius.circular(25)),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset('assets/sampling.svg'),
                            SizedBox(
                              height: 10.h,
                            ),
                            Center(
                                child: Text(
                              'Sampling',
                              style: TextStyle(
                                  color: CustomColors.background,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w500),
                            ))
                          ]),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SelectReportTemplateType()));
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height / 5,
                      width: MediaQuery.of(context).size.width / 2.5,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 1,
                              offset:
                                  Offset(0, 0.5), // changes position of shadow
                            ),
                          ],
                          color: CustomColors.mainDarkOrange,
                          borderRadius: BorderRadius.circular(25)),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset('assets/report.svg'),
                            SizedBox(
                              height: 10.h,
                            ),
                            Center(
                                child: Text('Report',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w500)))
                          ]),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget myTaskWidget(
      String title, IconData icon, String subTitle, Color iconBGColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Container(
              height: 20.w,
              width: 20.w,
              decoration:
                  BoxDecoration(color: iconBGColor, shape: BoxShape.circle),
              child: Icon(
                icon,
                color: Colors.white,
                size: 17,
              )),
          SizedBox(
            width: 10.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  )),
              Text(
                subTitle,
                style: TextStyle(fontSize: 12, color: Colors.black45),
              )
            ],
          )
        ],
      ),
    );
  }
}
