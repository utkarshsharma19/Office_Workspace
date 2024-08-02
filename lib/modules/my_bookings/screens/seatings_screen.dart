import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../components/ammenity_card.dart';
import '../bloc/seatings/seating_bloc.dart';
import '../bloc/seatings/seating_state.dart';
import '../model/seating_model.dart';
class SeatingPage extends StatefulWidget {
  const SeatingPage({super.key});

  @override
  State<SeatingPage> createState() => _SeatingPageState();
}

class _SeatingPageState extends State<SeatingPage> {
  final Seating _newsBloc = Seating();
  DateTime? selectedDate;
  @override
  void initState() {
    super.initState();
    _newsBloc.add(GetSeating());
  }
  @override
  Widget build(BuildContext context)  {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 15,left: 7,right: 7),
        child: BlocProvider(
          create: (_) => _newsBloc,
          child: BlocListener<Seating, SeatingState>(
            listener: (context, state) {
              if (state is SeatingError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message!),
                  ),
                );
              }
            },
            child: BlocBuilder<Seating, SeatingState>(
              builder: (context, state) {
                if (state is SeatingInitial) {
                  return _buildLoading();
                } else if (state is SeatingLoading) {
                  return _buildLoading();
                } else if (state is SeatingLoaded) {
                  return _buildCard(context, state.meetingList);
                } else if (state is SeatingError) {
                  return Container();
                } else {
                  return Container();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
Widget _buildCard(BuildContext context, List<SeatingClass> meetingData) {
  return ListView.builder(
      shrinkWrap: true,
      itemCount: meetingData.length,
      itemBuilder: (context, index) {
        final meeting = meetingData[index];
        return GestureDetector(
          onTap: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => NextPage(
            //       meeting: meeting,
            //     ),
            //   ),
            // );
          },
          child: AmmenityCard(ammenityType: AmmenityType.SEATS, titleText: "Seating Room", scheduleText: 
        "${meeting.date.split("T")[0]}",
         locationText: " Floor-${meeting.floorNumber}",bookingId: meeting.bookingId)
//         return Card(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10.0),
//           ),
//           elevation: 5.0,
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Container(
//                   margin: const EdgeInsets.all(16),
//                   child: ClipRRect(
//                   borderRadius: BorderRadius.circular(20.0),
//                   child: Container(
//                     padding: EdgeInsets.all(8.0),
//                     color: Theme.of(context).colorScheme.secondary,
//                     child: Icon(
//                       Icons.workspaces,
//                       size: 40.0,
//                       color: Theme.of(context).colorScheme.primary,
//                     ),
//                   ),
//                               ),
//                 ),
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(left: 7),
//                     child: Text("Seating",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black),),
//                   ),
//                   SizedBox(height: 7,),
//                   Row(
//                     children: [
//                       // Image.asset(
//                       //   "assets/images/Access time.png",
//                       //   height: 20,
//                       //   width: 30,
//                       //   color: Colors.black87,
//                       // ),
//                       Text(DateFormat('h:mm a').format(DateTime.parse(meeting.date)),style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black),),
//                       SizedBox(width: 7,),
//                       Text(DateFormat.MMMd().format(DateTime.parse(meeting.date)),style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black87),),
//                     ],
//                   ),
//                   const SizedBox(height: 7,),
//                   Row(children: [
//                     // Image.asset(
//                     //   "assets/images/Location on.png",
//                     //   height: 20,
//                     //   width: 30,
//                     //   color: Colors.black87,
//                     // ),
//                     Text("Floor Number"+" "+meeting.floorNumber.toString(),style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black87),)

//                   ],)
//                 ],),
//               Spacer(),
//               Padding(
//                 padding: const EdgeInsets.only(right: 5),
//                 child: Row(children: [
//                   // Image.asset(
//                   //   "assets/images/Edit-Square.png",
//                   //   height: 40,
//                   //   width: 40,
//                   // ),
//                   // Image.asset(
//                   //   "assets/images/Delete.png",
//                   //   height: 40,
//                   //   width: 40,
//                   // ),
//                 ],),
//               )
//             ],
//           ),
        );
      });
}

Widget _buildLoading() => Center(child: CircularProgressIndicator());

String convertDate(String inputDate) {
  // Parse the input date string
  DateTime dateTime = DateTime.parse(inputDate);

  // Define the desired output format
  DateFormat outputFormat = DateFormat('MMM d');

  // Format the date using the desired format
  String formattedDate = outputFormat.format(dateTime);

  return formattedDate;
}