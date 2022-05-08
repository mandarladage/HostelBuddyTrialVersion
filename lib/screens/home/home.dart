import 'package:firbaseauth/Calculatingdistance/frontscreen.dart';
import 'package:firbaseauth/Testing/checklist.dart';
import 'package:firbaseauth/screens/hostel/hostelprofilescreen.dart';
import 'package:firbaseauth/services/auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService authService = AuthService();
  List<String> data = ["Hot Water", "Fan", "Mess", "Ironing"];

  List<String> userChecked = [];

  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    void _showCheckList() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return StatefulBuilder(builder: (context, StateSetter setState) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 2.0),
                child: Column(
                  children: [
                    Flexible(
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: data.length,
                          itemBuilder: (context, i) {
                            return ListTile(
                                title: Text(data[i]),
                                trailing: Checkbox(
                                  value: userChecked.contains(data[i]),
                                  onChanged: (val) {
                                    setState(() {
                                      print(val);
                                      if (val == true) {
                                        userChecked.add(data[i]);
                                      } else {
                                        userChecked.remove(data[i]);
                                      }
                                    });
                                    //_onSelected(val, data[i]);
                                  },
                                )
                                //you can use checkboxlistTile too
                                );
                          }),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          print(userChecked);
                          refreshPage();
                          Navigator.pop(context);
                          //userChecked.clear();
                        },
                        child: Text('Add In List'),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.pink)))
                  ],
                ),
              );
            });
          });
    }

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
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () async {
                  // Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (context) => HostelProfileScreen()));
                  //_showCheckList();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => GetCurrentLocation()));
                },
                child: Text('Retrive', style: TextStyle(color: Colors.white)),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.red)),
              ),
              Text(userChecked.join(",")),
            ],
          ),
        ),
      ),
    );
  }

  void refreshPage() {
    setState(() {
      print(userChecked);
    });
  }
}
