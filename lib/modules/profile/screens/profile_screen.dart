import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:office_spacez/utils/user_state.dart';

import '../bloc/event_state.dart';

import '../bloc/profile_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final Profile _profileBloc = Profile();
  @override
  void initState() {
    super.initState();
    _profileBloc.add(GetProfile());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop(); // Navigate back when button is pressed
          },
        ),
        centerTitle: true,
        title: Text(
          'Profile',
        ),
      ),
      body:  BlocProvider(
        create: (_) => _profileBloc,
        child: BlocListener<Profile, EventState>(
          listener: (context, state) {
            if (state is EventError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message!),
                ),
              );
            }
          },
          child: BlocBuilder<Profile, EventState>(
            builder: (context, state) {
              if (state is EventInitial) {
                return _buildLoading();
              } else if (state is EventLoading) {
                return _buildLoading();
              } else if (state is ProfileLoaded) {
                return Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Stack(children: [
                      Container(
                        margin: EdgeInsets.only(top: 45,left: 10,right: 10),
                        height: 200,
                        width: double.infinity,
                        child: Card(
                          elevation: 10,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text( state.profile.firstName+" "+state.profile.lastName,style: TextStyle(color: Colors.black)),
                              SizedBox(
                                height: 10,
                              ),
                              Text(state.profile.userID.toString(),style: TextStyle(color: Colors.black)),
                              SizedBox(
                                height: 10,
                              ),
                              Text(state.profile.role,style: TextStyle(color: Colors.black)),
                              SizedBox(
                                height: 10,
                              ),
                              Text(state.profile.email,style: TextStyle(color: Colors.black)),
                            ],
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                      Align(
                          alignment: Alignment.topCenter,
                          child: SizedBox(
                            child: Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.white),
                              child: Icon(Icons.person, color: Colors.grey, size: 100.0),
                              alignment: Alignment.center,
                            ),
                          )),
                    ]),

                    Expanded(
                        child: Align(
                            alignment: FractionalOffset.bottomCenter,
                            child:  Container(
                              width: 300, // Match parent width
                              height: 50, // Match parent height
                              child: OutlinedButton(
                                onPressed: () {
                                  // LogOut user and send back to splash screen then login
                                  // set userId to empty in shared preferences
                                  setUserInfo();
                                  // Navigate to the splash screen ////////////////////////////// redirect to Splash Screen
                                  Navigator.of(context).pushNamedAndRemoveUntil('/splash', (route) => false);
                                },
                                style: OutlinedButton.styleFrom(
                                  side : BorderSide(color: Colors.deepOrange),

                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),

                                ),

                                // ignore: prefer_const_constructors
                                child: Text(
                                  'Logout',
                                  style: TextStyle(color: Colors.deepOrange),
                                ),
                              ),
                            ))),
                    SizedBox(
                      height: 50,
                    ),
                  ],
                );
              } else if (state is EventError) {
                return Container();
              } else {
                return Container();
              }
            },
          ),
        ),
      ),




    );
  }
  Widget _buildLoading() => Center(child: CircularProgressIndicator());

}