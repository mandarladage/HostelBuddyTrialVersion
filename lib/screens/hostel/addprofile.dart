import 'package:firbaseauth/models/hostel/hosteluserprofile.dart';
import 'package:firbaseauth/screens/authenticate/authenticate.dart';
import 'package:firbaseauth/screens/wrapper.dart';
import 'package:firbaseauth/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddProfile extends StatelessWidget {
  final AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    final hostelProfile = Provider.of<HostelUserProfile?>(context);

    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        title: Text('Name'),
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
              onPressed: () async {
                await authService.signOut();

                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => Wrapper()),
                    (Route<dynamic> route) => false);
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Column(
        children: [
          Text(hostelProfile?.firstname ?? ''),
          Text(hostelProfile?.lastname ?? ''),
          Text(hostelProfile?.contactnumber ?? ''),
          Text(hostelProfile?.address ?? ''),
        ],
      ),
    );
  }
}
