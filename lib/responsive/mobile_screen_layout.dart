import 'package:flutter/material.dart';
import 'package:instagram_flutter/models/user.dart' as model;
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';
class MobileScreenLayout extends StatelessWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    model.User user=Provider.of<UserProvider>(context).getUser;
     return Scaffold(body: Center(child: Text(user.bio),),);
  }
}