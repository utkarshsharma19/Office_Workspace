  // import 'dart:html';

  import 'package:flutter_bloc/flutter_bloc.dart';
  import 'package:flutter/material.dart';
  import 'package:intl/intl.dart';
import 'package:office_spacez/components/ammenity_card.dart';


  // import '../NextPage.dart';
  import '../bloc/meeting_bloc.dart';
  import '../bloc/meeting_state.dart';
  import '../model/MeetingModel.dart';

  class MeetingPage extends StatefulWidget {
    const MeetingPage({super.key});

    @override
    State<MeetingPage> createState() => _MeetingPageState();
  }

  class _MeetingPageState extends State<MeetingPage> {
    final Meeting _newsBloc = Meeting();
    DateTime? selectedDate;
    @override
    void initState() {
      super.initState();
      _newsBloc.add(GetMeeting());
    }
    @override
    Widget build(BuildContext context)  {
      return Scaffold(
        backgroundColor: Colors.grey.shade200,
        body: SingleChildScrollView(
          padding: EdgeInsets.only(top: 15,left: 7,right: 7),
          child: BlocProvider(
            create: (_) => _newsBloc,
            child: BlocListener<Meeting, MeetingState>(
              listener: (context, state) {
                if (state is MeetingError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message!),
                    ),
                  );
                }
              },
              child: BlocBuilder<Meeting, MeetingState>(
                builder: (context, state) {
                  if (state is MeetingInitial) {
                    return _buildLoading();
                  } else if (state is MeetingLoading) {
                    return _buildLoading();
                  } else if (state is MeetingLoaded) {
                    return _buildCard(context, state.meetingList);
                  } else if (state is MeetingError) {
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
  Widget _buildCard(BuildContext context, List<SeatingData> meetingData) {
    
    return ListView.builder(
      shrinkWrap: true,
        itemCount: meetingData.length,
        itemBuilder: (context, index) {
          final meeting = meetingData[index]; 
          final meets = "${meeting.date.split("T")[0]}(${meeting.startTime.split("T")[1].split(".")[0]}) to ${meeting.date.split("T")[0]}(${meeting.endTime.split("T")[1].split(".")[0]})";
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
        child: AmmenityCard(ammenityType: AmmenityType.MEETING_ROOM, titleText: "Meeting Room", scheduleText: 
        "${meeting.date.split("T")[0]} : ${meeting.startTime.split("T")[1].split(".")[0]} - ${meeting.endTime.split("T")[1].split(".")[0]}",
         locationText: "${meeting.roomName} - Floor - ${meeting.floorNumber}",bookingId: meeting.bookingId,)
  // Card(
          
  //           shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(10.0),
  //           ),
  //           elevation: 5.0,
  //           child: Row(
  //             crossAxisAlignment: CrossAxisAlignment.center,
  //             children: [
  //               // Container(
  //               //   decoration: BoxDecoration(
  //               //     color: Colors.grey.shade300,
  //               //     borderRadius:  BorderRadius.circular(10),
  //               //   ),
  //               //   margin: const EdgeInsets.all(10),
  //               //   height: 78,
  //               //   width: 74,
  //               // ),
  //               Container(
  //                 margin: const EdgeInsets.all(16),
  //                 child: ClipRRect(
  //                 borderRadius: BorderRadius.circular(20.0),
  //                 child: Container(
  //                   padding: EdgeInsets.all(8.0),
  //                   color: Theme.of(context).colorScheme.secondary,
  //                   child: Icon(
  //                     Icons.meeting_room,
  //                     size: 40.0,
  //                     color: Theme.of(context).colorScheme.primary,
  //                   ),
  //                 ),
  //                             ),
  //               ),
  //               Column(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   // Padding(
  //                   //   padding: const EdgeInsets.only(left: 7),
  //                   //   child: Text(meeting.amenity,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black),),
  //                   // ),
  //                   SizedBox(height: 7,),

  //                   Text("Meeting Room", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.0),),
                    
  //                   SizedBox(height: 7,),

  //                   Row(
  //                     children: [
  //                       // Image.asset(
  //                       //   "assets/images/Access time.png",
  //                       //   height: 20,
  //                       //   width: 30,
  //                       //   color: Colors.black87,
  //                       // ),
  // Icon(
  //       Icons.access_time,
  //       size: 18,
  //       color: Colors.black,
  //     ),
  //     SizedBox(width: 4),
  //     Text(
  //       DateFormat.MMMd().format(DateTime.parse(meeting.startTime)),
  //       style: TextStyle(
  //         fontSize: 14,
  //         fontWeight: FontWeight.w400,
  //         color: Colors.black87,
  //       ),
  //     ),
  //     SizedBox(width: 7),
  //     Text(
  //       DateFormat('h:mm a').format(DateTime.parse(meeting.startTime)),
  //       style: TextStyle(
  //         fontSize: 14,
  //         fontWeight: FontWeight.w400,
  //         color: Colors.black,
  //       ),
  //     ),
  //     SizedBox(width: 10),
  //     Text(
  //       "-",
  //       style: TextStyle(
  //         fontSize: 14,
  //         fontWeight: FontWeight.w400,
  //         color: Colors.black,
  //       ),
  //     ),
  //     SizedBox(width: 10),
  //     Text(
  //       DateFormat.MMMd().format(DateTime.parse(meeting.endTime)),
  //       style: TextStyle(
  //         fontSize: 14,
  //         fontWeight: FontWeight.w400,
  //         color: Colors.black87,
  //       ),
  //     ),
  //     SizedBox(width: 7),
  //     Text(
  //       DateFormat('h:mm a').format(DateTime.parse(meeting.endTime)),
  //       style: TextStyle(
  //         fontSize: 14,
  //         fontWeight: FontWeight.w400,
  //         color: Colors.black,
  //       ),
  //     ),
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
  //                     Icon(
  //       Icons.location_on,
  //       size: 18,
  //       color: Colors.black,
  //     ),
  //     SizedBox(width: 4),
  //     Text(
  //       meeting.roomName,
  //       style: TextStyle(
  //         fontSize: 14,
  //         fontWeight: FontWeight.w400,
  //         color: Colors.black87,
  //       ),
  //     ),
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
  //       ),
          );
        });
  }

  Widget _buildLoading() => Center(child: CircularProgressIndicator());

  // todayDate() {
  //     var now = new DateTime.now();
  //     var formatter = new DateFormat('dd-MM-yyyy');
  //     String formattedTime = DateFormat('kk:mm:a').format(now);
  //     String formattedDate = formatter.format(now);
  //     print(formattedTime);
  //     print(formattedDate);
  //   }

  String convertDate(String inputDate) {
    // Parse the input date string
    DateTime dateTime = DateTime.parse(inputDate);

    // Define the desired output format
    DateFormat outputFormat = DateFormat('MMM d');

    // Format the date using the desired format
    String formattedDate = outputFormat.format(dateTime);

    return formattedDate;
  }
