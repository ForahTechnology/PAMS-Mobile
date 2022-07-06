import 'package:flutter/material.dart';
import 'package:pams/utils/custom_colors.dart';

class EditEmail extends StatefulWidget {
  @override
  _EditEmailState createState() => _EditEmailState();
}

class _EditEmailState extends State<EditEmail> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: CustomColors.background,
        title: Text("Update email",
            style: TextStyle(color: Colors.black, fontSize: 20)),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                height: 200,
                width: 230,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage("assets/email update.png"))),
              ),
              Text("Update your email address", style: TextStyle(fontSize: 24)),
              SizedBox(
                height: 50,
              ),
              Text("Please enter your new email address",
                  style: TextStyle(fontSize: 18)),
              Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  boxShadow: [
                    // to make elevation
                    BoxShadow(
                      color: Colors.grey[300]!,
                      offset: Offset(0, 2),
                      blurRadius: 4,
                    ),
                    // to make the coloured border
                    BoxShadow(
                      offset: Offset(0, 0.5),
                    ),
                  ],
                  color: Colors.grey[200],
                ),
                margin: EdgeInsets.all(20),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.email_rounded,
                        size: 28,
                      ),
                      hintText: 'Email',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 140,
              ),
              InkWell(
                onTap: () async {
                  setState(() {
                    isLoading = true;
                  });
                  await Future.delayed(Duration(seconds: 3))
                      .then((value) => setState(() async {
                            isLoading = false;
                          }));
                  setState(() async {
                    isLoading = false;
                  });
                },
                child: Container(
                  margin: EdgeInsets.fromLTRB(20, 30, 20, 10),
                  height: 50,
                  width: 200,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  child: isLoading
                      ? Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.white,
                          ),
                        )
                      : Center(
                          child: Text("Continue",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
