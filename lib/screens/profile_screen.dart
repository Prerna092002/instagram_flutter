import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:instagram_flutter/utils/colors.dart';

import '../widgets/follow_button.dart';
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        centerTitle: false,
        title:const Text('username'),
      ),
      body: ListView(
        children: [
          Padding(padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey,
                    backgroundImage: NetworkImage("https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png"),
                    radius: 40,
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            buildStatColumn(10, 'Posts'),
                            buildStatColumn(100, 'Followers'),
                            buildStatColumn(90, 'Following'),
                            ],
                        ),
                         Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FollowButton(
                        text: 'Edit Profile',
                        backgroundColor: mobileBackgroundColor,
                        textColor: primaryColor,
                        borderColor: Colors.grey,
                        function: () {
                          
                        },
                      ),
                    ],
                  )
                      ],
                    ),
                  ),
                 
                ],
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding:const EdgeInsets.only(top:15),
                child: Text('username',style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),),
              ),
               Container(
                alignment: Alignment.centerLeft,
                padding:const EdgeInsets.only(top:1),
                child: Text('Some Description',),
              ),
            ],
          ),
          ),
           const Divider(),
        ],),
    );
  }
  Column buildStatColumn(int num,String label){
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          num.toString(),
          style:const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
         Container(
          margin:const EdgeInsets.only(top:4),
           child: Text(
            label,
            style:const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Colors.grey
            ),
        ),
         )
      ],
    );
  }
}