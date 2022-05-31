// import 'package:flutter/material.dart';
// import 'package:pams/styles/custom_colors.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:pams/views/clients/dpr/dpr_screen.dart';

// import 'fmenv/fmenv_screen.dart';
// import 'nesrea/nesrea_screen.dart';

// class SelectSampleType extends StatefulWidget {
//   final String? clientName;
//   final String? clientId;
//   final int? locationId;

//   const SelectSampleType(
//       {Key? key, this.clientId, this.clientName, this.locationId})
//       : super(key: key);

//   @override
//   _SelectSampleTypeState createState() => _SelectSampleTypeState();
// }

// class _SelectSampleTypeState extends State<SelectSampleType> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   int? selected;

//   List<String> sampleType = ['DPR', 'FMENV', 'NESREA'];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         leading: BackButton(
//           color: Colors.black,
//         ),
//         title: Text('Select Sample Type',
//             style: TextStyle(color: Colors.black, fontSize: 16)),
//         backgroundColor: Colors.white,
//         elevation: 0,
//       ),
//       backgroundColor: Colors.white,
//       body: Container(
//         margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
//         child: ListView(
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: Text('Air Quality Analysis',
//                   style: TextStyle(color: Colors.black, fontSize: 16)),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             ListView.builder(
//                 itemCount: sampleType.length,
//                 physics: NeverScrollableScrollPhysics(),
//                 shrinkWrap: true,
//                 itemBuilder: (context, index) {
//                   return Padding(
//                     padding: const EdgeInsets.only(bottom: 20),
//                     child: InkWell(
//                         onTap: () {
//                           setState(() {
//                             selected = index;
//                           });
//                         },
//                         child: myListWidget(
//                             sampleType[index],
//                             selected == index
//                                 ? CustomColors.mainDarkGreen
//                                 : Colors.white,
//                             selected == index
//                                 ? CustomColors.background
//                                 : Colors.black)),
//                   );
//                 })
//           ],
//         ),
//       ),
//       bottomNavigationBar: BottomAppBar(
//         elevation: 0,
//         color: CustomColors.background,
//         child: InkWell(
//           onTap: selected == null
//               ? () {}
//               : () {
//                   switch (selected) {
//                     case 0:
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => DPRScreen(
//                                     locationId: widget.locationId,
//                                   )));

//                       break;
//                     case 1:
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) =>
//                                   FMENVScreen(locationId: widget.locationId)));

//                       break;
//                     case 2:
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => NESREAScreen(
//                                     locationId: widget.locationId,
//                                   )));
//                       break;
//                     default:
//                   }
//                 },
//           child: Container(
//             margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
//             decoration: BoxDecoration(
//                 color:
//                     selected == null ? Colors.grey : CustomColors.mainDarkGreen,
//                 borderRadius: BorderRadius.circular(10.r)),
//             height: 50.h,
//             width: MediaQuery.of(context).size.width,
//             child: Center(
//               child: Text(
//                 'Proceed',
//                 style:
//                     TextStyle(color: CustomColors.background, fontSize: 16.sp),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget myListWidget(String name, Color bg, Color text) {
//     return Container(
//       height: 70,
//       width: MediaQuery.of(context).size.width,
//       decoration: BoxDecoration(boxShadow: [
//         BoxShadow(
//           color: Colors.grey[300]!,
//           offset: Offset(0, 2),
//           blurRadius: 4,
//         ),
//         BoxShadow(
//           offset: Offset(0, 0.5),
//         ),
//       ], borderRadius: BorderRadius.circular(8), color: bg),
//       child: Center(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 '$name',
//                 style: TextStyle(
//                   color: text,
//                   fontSize: 17,
//                   fontWeight: FontWeight.w400,
//                 ),
//               ),
//               Icon(
//                 Icons.arrow_forward_ios,
//                 size: 16,
//                 color: text,
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }