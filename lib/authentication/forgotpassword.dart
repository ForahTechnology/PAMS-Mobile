import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pams/authentication/auth.dart';
import 'package:pams/utils/custom_buttons.dart';
import 'package:pams/utils/custom_colors.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: CustomColors.lightDarkGreen,
      body: Center(
        child: ListView(
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: SvgPicture.asset(
                'assets/auth_logo.svg',
                height: 150,
                width: 350,
              ),
            ),
            Center(
              child: Form(
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 300,
                      height: 200,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage("assets/logoo.png"))),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "Please enter your email address to search for your account",
                        style: TextStyle(fontSize: 15),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: CustomColors.mainDarkGreen))),
                      child: TextFormField(
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(RegExp('[ ]')),
                        ],
                        //controller: _emailTextController,
                        // validator: (value) {
                        //   return Validators.isEmailStr(value.toString());
                        // },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.email_rounded,
                            color: CustomColors.mainDarkGreen,
                            size: 28,
                          ),
                          border:
                              UnderlineInputBorder(borderSide: BorderSide.none),
                          hintText: 'Email',
                        ),
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 20),
                    //   child: CustomButton(
                    //     bgColor: Colors.grey,
                    //     isBorder: true,
                    //     onclick: () {
                    //       Navigator.of(context).pop();
                    //     },
                    //     title: Text("Cancel",
                    //         style: TextStyle(
                    //             fontWeight: FontWeight.bold,
                    //             color: Colors.black)),
                    //   ),
                    // ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: CustomButton(
                        bgColor: CustomColors.mainDarkGreen,
                        onclick: () {},
                        isBorder: false,
                        title: Text("Proceed",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
