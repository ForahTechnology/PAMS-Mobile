import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pams/screens/clients/customer_response_model.dart';
import 'package:pams/utils/custom_colors.dart';

import '../../utils/constants.dart';
import 'client_implementation.dart';

class AddCustomerPage extends StatefulWidget {
  const AddCustomerPage({Key? key}) : super(key: key);

  @override
  _AddCustomerPageState createState() => _AddCustomerPageState();
}

class _AddCustomerPageState extends State<AddCustomerPage> {
  TextEditingController customersName = TextEditingController();
  TextEditingController customerContactPerson = TextEditingController();
  TextEditingController customersPhoneNumber = TextEditingController();
  TextEditingController customersEmail = TextEditingController();
  TextEditingController customersAddress = TextEditingController();
  final _formKey = GlobalKey<FormState>();
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
        title: Text("Add Customer",
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
                controller: customersName,
                validator: (value) {
                  if (value!.isEmpty == true) {
                    return 'Field is required';
                  }
                },
                decoration: InputDecoration(
                    hintText: 'Customers name',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: customerContactPerson,
                validator: (value) {
                  if (value!.isEmpty == true) {
                    return 'Field is required';
                  }
                },
                decoration: InputDecoration(
                    hintText: 'Contact person',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: customersPhoneNumber,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty == true) {
                    return 'Field is required';
                  }
                },
                decoration: InputDecoration(
                    hintText: 'Phone number',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp('[ ]')),
                ],
                keyboardType: TextInputType.emailAddress,
                controller: customersEmail,
                validator: (value) {
                  if (value!.isEmpty == true) {
                    return 'Field is required';
                  }
                },
                decoration: InputDecoration(
                    hintText: 'Email address',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: customersAddress,
                validator: (value) {
                  if (value!.isEmpty == true) {
                    return 'Field is required';
                  }
                },
                decoration: InputDecoration(
                    hintText: 'Customer address',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Colors.white,
        child: InkWell(
          onTap: () async {
            await createClient();
          },
          child: Container(
            margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
            height: 60,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: CustomColors.mainDarkGreen,
                borderRadius: BorderRadius.circular(10)),
            child: Center(
              child: loader
                  ? SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    )
                  : Text(
                      'Add Customer',
                      style: TextStyle(
                          color: CustomColors.background, fontSize: 18),
                    ),
            ),
          ),
        ),
      ),
    );
  }

  bool loader = false;

  Future createClient() async {
    setState(() {
      loader = true;
    });
    final form = _formKey.currentState;
    if (!form!.validate()) {
      setState(() {
        loader = false;
      });
    } else {
      form.save();
      final result = await ClientImplementation().createClient(
          customersName.text,
          customersEmail.text,
          customersAddress.text,
          customerContactPerson.text,
          customersPhoneNumber.text);
      if (result != null) {
        await getClients();
        if (customers != null) {
          setState(() {
            loader = false;
          });
          Constants().notify(result['message']);
          Navigator.of(context).pop(customers);
        }
      } else {
        setState(() {
          loader = false;
        });
        // Constants().notify(result!['message']);
      }
    }
  }

  List<CustomerDataList>? customers;
  int pageNumber = 1;

  Future getClients() async {
    final result = await ClientImplementation().getAllClients(pageNumber);
    if (result != null) {
      setState(() {
        customers = result.returnObject!.data!;
      });
    }
    return result;
  }
}
