import 'package:firbaseauth/models/hostel/hosteluserprofile.dart';
import 'package:firbaseauth/screens/hostel/addprofile.dart';
import 'package:firbaseauth/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HostelProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<HostelUserProfile?>.value(
        value: AuthService().hosteluserprofile,
        child: AddProfile(),
        initialData: null);
  }
}
