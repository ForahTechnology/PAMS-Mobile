import 'package:flutter/material.dart';
import 'package:pams/screens/clients/client_implementation.dart';
import 'package:pams/screens/clients/customer_response_model.dart';
import 'package:pams/utils/custom_colors.dart';
import 'package:pams/utils/list_widget.dart';

import 'add_customer.dart';
import 'location/client_location.dart';

class CustomerList extends StatefulWidget {
  @override
  _CustomerListState createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList> {
    List<CustomerDataList>? customers;

  Future getClients() async {
     setState(() {
      _isFirstLoadRunning = true;
    });
    final result = await ClientImplementation().getAllClients(pageNumber);
    if (result != null) {
      setState(() {
        customers = result.returnObject!.data!;
      });
    }
     setState(() {
      _isFirstLoadRunning = false;
    });
    return result;
  }
    @override
  void initState() {
    super.initState();
    getClients();
    _controller = new ScrollController()..addListener(_loadMore);
  }

  @override
  void dispose() {
    _controller.removeListener(_loadMore);
    super.dispose();
  }


  int pageNumber = 1;
  bool _isFirstLoadRunning = false;
  bool _isLoadMoreRunning = false;
  bool _hasNextPage = true;
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
        final res = await ClientImplementation().getAllClients(pageNumber);

        if (res!.returnObject!.data!.length > 0) {
          setState(() {
           customers!.addAll(res.returnObject!.data!);
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
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: InkWell(
              onTap: () async {
                var result = await Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AddCustomerPage()));
                if (result != null) {
                  await getClients();
                }
              },
              child: Icon(
                Icons.add,
                color: Colors.black,
              ),
            ),
          )
        ],
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("Customer List",
            style: TextStyle(color: Colors.black, fontSize: 20)),
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // SizedBox(
          //   height: 20,
          // ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          //   child: TextFormField(
          //       inputFormatters: [
          //         FilteringTextInputFormatter.deny(RegExp('[ ]')),
          //       ],
          //     decoration: InputDecoration(
          //         hintText: 'Search Customers',
          //         prefixIcon: Icon(
          //           Icons.search,
          //           color: Colors.black,
          //         ),
          //         border: OutlineInputBorder(
          //             borderRadius: BorderRadius.circular(10))),
          //   ),
          // ),
          // SizedBox(
          //   height: 20,
          // ),
           _isFirstLoadRunning
            ? Center(
                child: SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    color: CustomColors.mainDarkGreen,
                  ),
                ),
              )
            : customers!.length == 0
                  ? Center(
                      child: Text('No Customers Yet'),
                    )
                  : Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                           controller: _controller,
                            shrinkWrap: true,
                           // physics: NeverScrollableScrollPhysics(),
                            itemCount: customers!.length,
                            itemBuilder: (BuildContext context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => ClientLocation(
                                            clientId: customers![index].id,
                                            clientName: customers![index].name,
                                          )));
                                },
                                child: ListWidget(
                                  title: customers![index].name,
                                  subTitle: customers![index].email,
                                  trailing: Icon(
                                    Icons.arrow_forward_ios,
                                    size: 17,
                                  ),
                                ),
                              );
                            }),
                      ),
                   
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
                          'You have fetched all data',
                          style: TextStyle(color: CustomColors.background),
                        ),
                      ),
                    ),
                    ],
                  )
        ],
      ),
    );
  }
}
