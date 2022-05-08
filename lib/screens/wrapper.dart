import 'package:firbaseauth/Calculatingdistance/frontscreen.dart';
import 'package:firbaseauth/models/user.dart';
import 'package:firbaseauth/screens/authenticate/authenticate.dart';
import 'package:firbaseauth/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserData?>(context);

    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
