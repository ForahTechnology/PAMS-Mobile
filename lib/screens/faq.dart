import 'package:flutter/material.dart';

class FAQPage extends StatefulWidget {
  @override
  _FAQPageState createState() => _FAQPageState();
}

class _FAQPageState extends State<FAQPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        elevation: 0,
        //backgroundColor: HexColor("#26E07F"),
        title: Text("FAQ", style: TextStyle(color: Colors.black, fontSize: 20)),
      ),
      backgroundColor: Colors.white,
      body: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, int) {
            return Container(
              margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
              width: MediaQuery.of(context).size.width / 1.4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
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
                color: Colors.white,
              ),
              child: ExpansionTile(
                trailing: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  
                ),
                title: Text(
                  "What is PAMS?",
                  style: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                    
                  ),
                ),
                children: <Widget>[
                  ListTile(
                    title: Text(
                      "The BuddySafe App is an app developed to help people in danger to get help from people near-by. Individuals in an emergency like robbery or acute health breakdown etc. can through the app send a notification requesting assistance.",
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}
