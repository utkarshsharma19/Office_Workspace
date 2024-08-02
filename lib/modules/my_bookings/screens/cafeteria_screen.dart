// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// import '../../../components/ammenity_card.dart';
// import '../bloc/cafeteria_bloc/cafeteria_bloc.dart';
// import '../bloc/cafeteria_bloc/cafeteria_state.dart';
// import '../model/cafeteria_model.dart';

// class CafeteriaPage extends StatefulWidget {
//   const CafeteriaPage({super.key});

//   @override
//   State<CafeteriaPage> createState() => _CafeteriaPageState();
// }

// class _CafeteriaPageState extends State<CafeteriaPage> {
//   final Cafeteria _newsBloc = Cafeteria();
//   DateTime? selectedDate;
//   @override
//   void initState() {
//     super.initState();
//     _newsBloc.add(GetCafeteria());
//   }
//   @override
//   Widget build(BuildContext context)  {
//     return Scaffold(
//       backgroundColor: Colors.grey.shade200,
//       body: SingleChildScrollView(
//         padding: EdgeInsets.only(top: 15,left: 7,right: 7),
//         child: BlocProvider(
//           create: (_) => _newsBloc,
//           child: BlocListener<Cafeteria, CafeteriaState>(
//             listener: (context, state) {
//               if (state is CafeteriaError) {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(
//                     content: Text(state.message!),
//                   ),
//                 );
//               }
//             },
//             child: BlocBuilder<Cafeteria, CafeteriaState>(
//               builder: (context, state) {
//                 if (state is CafeteriaInitial) {
//                   return _buildLoading();
//                 } else if (state is CafeteriaLoading) {
//                   return _buildLoading();
//                 } else if (state is CafeteriaLoaded) {
//                   return _buildCard(context, state.meetingList);
//                 } else if (state is CafeteriaError) {
//                   return Container();
//                 } else {
//                   return Container();
//                 }
//               },
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
// Widget _buildCard(BuildContext context, List<CafeteriaData> meetingData) {
//   return ListView.builder(
//       shrinkWrap: true,
//       itemCount: meetingData.length,
//       itemBuilder: (context, index) {
//         final meeting = meetingData[index];
//         return GestureDetector(
//           onTap: () {
//             // Navigator.push(
//             //   context,
//             //   MaterialPageRoute(
//             //     builder: (context) => NextPage(
//             //       meeting: meeting,
//             //     ),
//             //   ),
//             // );
//           },

//         child: AmmenityCard(ammenityType: AmmenityType.CAFETERIA, titleText: "Cafeteria", scheduleText: 
//         "${meeting.date.split("T")[0]} : ${meeting.startTime.split("T")[1].split(".")[0]} - ${meeting.endTime.split("T")[1].split(".")[0]}",
//         locationText:"5th Floor",)
// //         return Card(
// //           shape: RoundedRectangleBorder(
// //             borderRadius: BorderRadius.circular(10.0),
// //           ),
// //           elevation: 5.0,
// //           child: Row(
// //             crossAxisAlignment: CrossAxisAlignment.center,
// //             children: [
// //               Container(
// //                 decoration: BoxDecoration(
// //                   color: Colors.grey.shade300,
// //                   borderRadius:  BorderRadius.circular(10),
// //                 ),
// //                 margin: const EdgeInsets.all(10),
// //                 height: 78,
// //                 width: 74,
// //               ),
// //               Column(
// //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   Padding(
// //                     padding: const EdgeInsets.only(left: 7),
// //                     child: Text(meeting.amenity,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black),),
// //                   ),
// //                   SizedBox(height: 7,),
// //                   Row(
// //                     children: [
// //                       // Image.asset(
// //                       //   "assets/images/Access time.png",
// //                       //   height: 20,
// //                       //   width: 30,
// //                       //   color: Colors.black87,
// //                       // ),
// //                       Text(DateFormat('h:mm a').format(DateTime.parse(meeting.startTime)),style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black),),
// //                       SizedBox(width: 7,),
// //                       Text(DateFormat.MMMd().format(DateTime.parse(meeting.startTime)),style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black87),),
// //                     ],
// //                   ),
// //                   const SizedBox(height: 7,),
// //                   Row(children: [
// //                     // Image.asset(
// //                     //   "assets/images/Location on.png",
// //                     //   height: 20,
// //                     //   width: 30,
// //                     //   color: Colors.black87,
// //                     // ),
// //                     Text(meeting.meetingRoomName,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black87),)

// //                   ],)
// //                 ],),
// //               Spacer(),
// //               Padding(
// //                 padding: const EdgeInsets.only(right: 5),
// //                 child: Row(children: [
// //                   // Image.asset(
// //                   //   "assets/images/Edit-Square.png",
// //                   //   height: 40,
// //                   //   width: 40,
// //                   // ),
// //                   // Image.asset(
// //                   //   "assets/images/Delete.png",
// //                   //   height: 40,
// //                   //   width: 40,
// //                   // ),
// //                 ],),
// //               )
// //             ],
// //           ),
//         );
//       });
// }

// Widget _buildLoading() => Center(child: CircularProgressIndicator());

// String convertDate(String inputDate) {
//   // Parse the input date string
//   DateTime dateTime = DateTime.parse(inputDate);

//   // Define the desired output format
//   DateFormat outputFormat = DateFormat('MMM d');

//   // Format the date using the desired format
//   String formattedDate = outputFormat.format(dateTime);

//   return formattedDate;
// }
