import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pams/authentication/auth.dart';
import 'package:pams/authentication/login.dart';
import 'package:pams/utils/custom_colors.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final scaffoldkey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff194A00),
      key: scaffoldkey,
      body: Container(
        child: ListView(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: SvgPicture.asset('assets/register_img.svg',
                  height: 300, width: MediaQuery.of(context).size.width),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Form(
                key: formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: TextFormField(
                        validator: (input) => input!.length < 6
                            ? "First name should not be empty"
                            : null,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.account_box_sharp,
                            color: Colors.white,
                            size: 22,
                          ),
                          hintStyle: TextStyle(color: Colors.white),
                          hintText: ' First name',
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        validator: (input) => input!.length < 6
                            ? "Last name should not be empty"
                            : null,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.account_box_sharp,
                            color: Colors.white,
                            size: 22,
                          ),
                          hintStyle: TextStyle(color: Colors.white),
                          hintText: ' Last name',
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: TextFormField(
                        validator: (input) => input!.length < 11
                            ? "Phone number should be at least 11 characters"
                            : null,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.phone,
                            color: Colors.white,
                            size: 22,
                          ),
                          hintStyle: TextStyle(color: Colors.white),
                          hintText: 'Phone number',
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: TextFormField(
                        validator: (input) => !input!.contains("@")
                            ? "Email Id should be valid"
                            : null,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.white,
                            size: 22,
                          ),
                          hintText: 'Email',
                          hintStyle: TextStyle(color: Colors.white),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        validator: (input) => input!.length < 6
                            ? "Password should be at least 6 characters"
                            : null,
                        obscureText: true,
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.white,
                            size: 22,
                          ),
                          hintStyle: TextStyle(color: Colors.white),
                          hintText: 'password',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: TextFormField(
                        keyboardType: TextInputType.phone,
                        validator: (input) => input!.length < 4
                            ? "Activation code should be at least 4 characters"
                            : null,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.volunteer_activism,
                            color: Colors.white,
                            size: 22,
                          ),
                          hintStyle: TextStyle(color: Colors.white),
                          hintText: 'Activation code',
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          'Already have an Account?',
                          style: TextStyle(color: Colors.white),
                        ),
                        MaterialButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()));
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(fontSize: 17, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 40),
                      child: MaterialButton(
                        color: Colors.white,
                        height: 50,
                        minWidth: 600,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        onPressed: () {
                          final form = formKey.currentState;
                          if (form!.validate()) {
                            form.save();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AuthPage()));
                          }
                        },
                        child: Text("Register",
                            style: TextStyle(
                                fontSize: 17,
                                color: CustomColors.mainDarkGreen)),
                      ),
                    ),
                    SizedBox(height: 10),
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
