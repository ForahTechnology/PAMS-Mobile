import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pams/models/customer_response_model.dart';
import 'package:pams/providers/clients_data_provider.dart';
import 'package:pams/providers/provider_services.dart';
import 'package:pams/styles/custom_colors.dart';
import 'package:pams/utils/controller.dart';
import 'package:pams/utils/db.dart';
import 'package:pams/utils/notify_user.dart';
import 'package:pams/views/clients/location/add_location.dart';
import 'package:pams/views/clients/location/edit_location.dart';
import 'package:pams/views/clients/location/offline/add_offline_location.dart';
import 'package:pams/views/field_sampling/result_template_screen.dart';
import 'package:pams/widgets/list_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ClientLocation extends ConsumerStatefulWidget {
  const ClientLocation({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ClientLocationState();
}

class _ClientLocationState extends ConsumerState<ClientLocation> {
  var _controller = Get.put(PamsStateController());
  var db = PamsDatabase.init();
  @override
  Widget build(BuildContext context) {
    // var _authViewModel = ref.watch(authViewModel);
    // var _clientViewmodel = ref.watch(clientViewModel);
    var _phoneMode = ref.watch(appMode.state);
    var clientData = ModalRoute.of(context)?.settings.arguments as CustomerReturnObject;
    var _clientViewModel = ref.watch(clientViewModel);

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
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AddLocation(
                      clientID: clientData.id,
                    ),
                  ),
                );
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
        title: Text(
          "Sample Points",
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
      ),
      backgroundColor: CustomColors.background,
      body: _clientViewModel.clientData.loading
          ? Center(
              child: SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            )
          : Stack(
              children: [
                SizedBox(
                  height: 30,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Text(
                      clientData.name!,
                      style: TextStyle(fontSize: 16.sp),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: DefaultTabController(
                    initialIndex: _phoneMode.state == true ? 0 : 1,
                    length: 2,
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TabBar(
                                unselectedLabelColor: Colors.grey,
                                indicatorSize: TabBarIndicatorSize.label,
                                labelColor: Colors.black,
                                indicator: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(width: 1, color: CustomColors.mainDarkGreen),
                                  ),
                                ),
                                tabs: [
                                  Tab(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text("Online Points"),
                                    ),
                                  ),
                                  Tab(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text("Offline Points"),
                                    ),
                                  ),
                                ]),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TabBarView(children: [
                              //Online Tab
                              Padding(
                                padding: const EdgeInsets.only(left: 10, right: 10),
                                child: clientData.samplePointLocations!.isEmpty == true
                                    ? Center(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text('No Locations yet'),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            InkWell(
                                              onTap: () async {
                                                // _clientViewmodel.getClientLocation(
                                                //     clientId: clientData.id!);
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) => AddLocation(
                                                      clientID: clientData.id,
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Text(
                                                'Create one',
                                                style: TextStyle(color: CustomColors.mainDarkGreen, fontWeight: FontWeight.bold, fontSize: 17.sp),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    : ListView(
                                        physics: BouncingScrollPhysics(),
                                        children: [
                                          SizedBox(
                                            height: 20,
                                          ),
                                          // Padding(
                                          //   padding: const EdgeInsets.symmetric(
                                          //       horizontal: 20, vertical: 10),
                                          //   child: TextFormField(
                                          //     inputFormatters: [
                                          //       FilteringTextInputFormatter.deny(
                                          //           RegExp('[ ]'),),
                                          //     ],
                                          //     decoration: InputDecoration(
                                          //         hintText: 'Sample Points',
                                          //         prefixIcon: Icon(
                                          //           Icons.search,
                                          //           color: Colors.black,
                                          //         ),
                                          //         border: OutlineInputBorder(
                                          //             borderRadius:
                                          //                 BorderRadius.circular(
                                          //                     10),),),
                                          //   ),
                                          // ),
                                          ListView.builder(
                                              itemCount: clientData.samplePointLocations!.length,
                                              physics: NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemBuilder: (context, index) {
                                                _controller.offlinePoint.value = false;
                                                var data = clientData.samplePointLocations;
                                                return InkWell(
                                                  onTap: () {
                                                    Get.to(
                                                        () => ResultTemplatePage(
                                                              samplePointName: data![index].name,
                                                              samplePointIndex: index,
                                                              samplePointId: data[index].sampleLocationId,
                                                            ),
                                                        arguments: clientData);
                                                  },
                                                  child: ListWidget(
                                                    title: data![index].name,
                                                    subTitle: data[index].description,
                                                    trailing: SizedBox(
                                                      width: 100,
                                                      child: Row(
                                                        children: [
                                                          InkWell(
                                                            onTap: () {
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder: (context) => EditLocationPage(
                                                                    clientID: clientData.id,
                                                                    name: data[index].name,
                                                                    description: data[index].description,
                                                                    locatoionId: data[index].sampleLocationId,
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                            child: Icon(
                                                              Icons.edit,
                                                              color: CustomColors.mainDarkGreen,
                                                            ),
                                                          ),
                                                          SizedBox(width: 15),
                                                          IconButton(
                                                            onPressed: () {
                                                              var loading = false.obs;
                                                              showDialog(
                                                                  context: context,
                                                                  barrierDismissible: false,
                                                                  builder: (context) {
                                                                    return AlertDialog(
                                                                      title: Text('Delete Sample Point?'),
                                                                      content: Text('Are you sure you want to delete this sample point "${data[index].name}"?'),
                                                                      actions: [
                                                                        TextButton(
                                                                          onPressed: () {
                                                                            Navigator.pop(context);
                                                                          },
                                                                          child: Text(
                                                                            'Cancel',
                                                                            style: TextStyle(color: Colors.grey),
                                                                          ),
                                                                        ),
                                                                        Obx(() {
                                                                          return TextButton(
                                                                            onPressed: loading.value
                                                                                ? null
                                                                                : () async {
                                                                                    loading.value = true;
                                                                                    GetStorage box = GetStorage();
                                                                                    var token = box.read('token');
                                                                                    var response = await http.delete(
                                                                                      Uri.parse("http://sethlab-001-site1.itempurl.com/api/v1/FieldScientistAnalysisNesrea/delete-a-client-sample-location/${data[index].sampleLocationId}"),
                                                                                      headers: {
                                                                                        'Authorization': 'Bearer $token',
                                                                                        'Accept': '*/*',
                                                                                        'Content-Type': 'application/json',
                                                                                      },
                                                                                    );
                                                                                    loading.value = false;
                                                                                    NotifyUser.showAlert(jsonDecode(response.body)['message'].toString());
                                                                                    Navigator.pop(context);
                                                                                    _clientViewModel.getAllClients();
                                                                                    // Navigator.restorablePopAndPushNamed(context, '/clientLocation');
                                                                                  },
                                                                            child: loading.value
                                                                                ? SizedBox(width: 15, height: 15, child: CircularProgressIndicator(strokeWidth: 1.5, color: Colors.grey))
                                                                                : Text(
                                                                                    'Delete',
                                                                                    style: TextStyle(color: Colors.red),
                                                                                  ),
                                                                          );
                                                                        }),
                                                                      ],
                                                                    );
                                                                  });
                                                            },
                                                            icon: Icon(Icons.delete, color: Colors.red),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              })
                                        ],
                                      ),
                              ),

                              //Offline Tab
                              Padding(
                                padding: const EdgeInsets.only(left: 10, right: 10),
                                child: FutureBuilder(
                                  future: PamsDatabase.fetch(db, 'ClientLocation'),
                                  builder: ((context, snapshot) {
                                    if (snapshot.data == null) {
                                      return Center(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text('No Locations yet'),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            InkWell(
                                              onTap: () async {
                                                // _clientViewmodel.getClientLocation(
                                                //     clientId: clientData.id!);
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) => AddOfflineLocationScreen(
                                                      clientID: clientData.id,
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Text(
                                                'Create one',
                                                style: TextStyle(color: CustomColors.mainDarkGreen, fontWeight: FontWeight.bold, fontSize: 17.sp),
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    } else if (snapshot.hasData) {
                                      _controller.offlinePoint.value = true;
                                      List<dynamic> _data = json.decode(jsonEncode(snapshot.data));

                                      return ListView(
                                        physics: BouncingScrollPhysics(),
                                        children: [
                                          SizedBox(
                                            height: 20,
                                          ),
                                          ListView.builder(
                                              itemCount: _data.length,
                                              physics: NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemBuilder: (context, index) {
                                                // var data = clientData
                                                //     .samplePointLocations;
                                                return FutureBuilder(
                                                    future: ClientLocationData.fetch(_data[index]['id'].toString()),
                                                    builder: (context, snapshot) {
                                                      if (snapshot.hasData) {
                                                        List<dynamic> _dataParams = json.decode(jsonEncode(snapshot.data));
                                                        return InkWell(
                                                          child: ListWidget(
                                                            title: _dataParams[0]['name'],
                                                            subTitle: _dataParams[0]['description'],
                                                          ),
                                                        );
                                                      } else if (snapshot.connectionState == ConnectionState.waiting) {
                                                        return SizedBox(
                                                          width: 10,
                                                          height: 10,
                                                          child: CircularProgressIndicator(strokeWidth: 2),
                                                        );
                                                      } else {
                                                        return Container();
                                                      }
                                                    });
                                              })
                                        ],
                                      );
                                    } else {
                                      return Center(
                                        child: SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: CircularProgressIndicator(),
                                        ),
                                      );
                                    }
                                  }),
                                ),
                              ),
                            ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  bool delete = false;

  // void deleteLocationDialog(int id) {
  //   showDialog(
  //     context: context,
  //     builder: (_) {
  //       return StatefulBuilder(builder: (context, setState) {
  //         return AlertDialog(
  //           content: Container(
  //             width: MediaQuery.of(context).size.width,
  //             height: 200.h,
  //             child: delete
  //                 ? Center(
  //                     child: SizedBox(
  //                       height: 20,
  //                       width: 20,
  //                       child: CircularProgressIndicator(
  //                         color: CustomColors.mainDarkGreen,
  //                       ),
  //                     ),
  //                   )
  //                 : Column(
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: [
  //                       Text('Delete Location'),
  //                       SizedBox(
  //                         height: 20.h,
  //                       ),
  //                       Text(
  //                         'Sure you wanna delete this location?',
  //                       ),
  //                       SizedBox(
  //                         height: 20.h,
  //                       ),
  //                       Row(
  //                         mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                         children: [
  //                           TextButton(
  //                             onPressed: () => Navigator.pop(context),
  //                             child: Text('Cancel'),
  //                           ),
  //                           TextButton(
  //                             onPressed: () async {
  //                               setState(() {
  //                                 delete = true;
  //                               });
  //                               final result = await LocationImplementation()
  //                                   .deleteClientLocation(id)
  //                                   .catchError((onError) {
  //                                 setState(() {
  //                                   delete = false;
  //                                 });
  //                                 Constants().notify(
  //                                     'Oops...Something went wrong. Try again later');
  //                               });
  //                               if (result!['Status'] == true) {
  //                                 await getLocation();
  //                                 setState(() {
  //                                   delete = false;
  //                                 });
  //                                 Constants().notify(result['message']);
  //                                 Navigator.pop(context);
  //                               } else {
  //                                 setState(() {
  //                                   delete = false;
  //                                 });
  //                                 Constants().notify(result['Message']);
  //                               }
  //                             },
  //                             child: Text('Yes'),
  //                           ),
  //                         ],
  //                       )
  //                     ],
  //                   ),
  //           ),
  //         );
  //       });
  //     },
  //   );
  // }

}
