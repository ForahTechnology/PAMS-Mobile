import 'package:flutter/material.dart';
import 'package:pams/screens/clients/location/client_location.dart';
import 'package:pams/screens/clients/location/implementation.dart';
import 'package:pams/utils/constants.dart';
import 'package:pams/utils/custom_colors.dart';

import 'model/get_location_response.dart';

class EditLocation extends StatefulWidget {
  final String? name;
  final String? description;
  final int? locatoionId;
  final String? clientID;

  const EditLocation(
      {Key? key, this.name, this.description, this.locatoionId, this.clientID})
      : super(key: key);

  @override
  _EditLocationState createState() => _EditLocationState();
}

class _EditLocationState extends State<EditLocation> {
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    name.text = widget.name!;
    description.text = widget.description!;
    super.initState();
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
        title: Text("Edit Location",
            style: TextStyle(color: Colors.black, fontSize: 20)),
      ),
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.fromLTRB(20, 40, 20, 0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: name,
                validator: (value) {
                  if (value!.isEmpty == true) {
                    return 'Field is required';
                  }
                },
                decoration: InputDecoration(
                    hintText: 'Name',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              SizedBox(
                height: 40,
              ),
              TextFormField(
                controller: description,
                validator: (value) {
                  if (value!.isEmpty == true) {
                    return 'Field is required';
                  }
                },
                decoration: InputDecoration(
                    hintText: 'Description',
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
            await updateLocation();
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
                      'Edit Location',
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
  Future updateLocation() async {
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
      final result = await LocationImplementation()
          .updateClientLocation(
              widget.locatoionId!, name.text, description.text)
          .catchError((onError) {
        setState(() {
          update = false;
        });
        Constants().notify('Oops... Something went wrong, Try again later');
      });
      if (result != null) {
        Constants().notify(result.message!);
        await getLocation();
        if (myLocations != null) {
          setState(() {
            update = false;
          });
          Navigator.of(context).pop(myLocations);
        }
        // Navigator.pushAndRemoveUntil(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => ClientLocation(
        //               clientId: widget.clientID,
        //             )),
        //     (route) => false);
      } else {
        setState(() {
          update = false;
        });
        Constants().notify(result!.message!);
      }
    }
  }

  LocationResponseModel? myLocations;
  Future getLocation() async {
    final result =
        await LocationImplementation().getClientLocation(widget.clientID);
    if (result != null) {
      setState(() {
        myLocations = result;
      });
    }
  }
}
