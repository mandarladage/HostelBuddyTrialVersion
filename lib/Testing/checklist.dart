import 'package:firbaseauth/Testing/firebasemethods/database.dart';
import 'package:firbaseauth/Testing/firebasemethods/userchecklist.dart';
import 'package:firbaseauth/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TestCheckBox extends StatefulWidget {
  @override
  _TestCheckBoxState createState() => _TestCheckBoxState();
}

class _TestCheckBoxState extends State<TestCheckBox> {
  final Database databaseService = Database();
  final AuthService authService = AuthService();
  List<String> data = ["Hot Water", "Fan", "Mess", "Ironing"];

  List<String> userChecked = [];

  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    final checkModel = Provider.of<UserCheckList?>(context);

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
                                  value: userChecked.contains(data[i]) &&
                                      checkModel!.userCheckedFire
                                          .contains(data[i]),
                                  onChanged: (val) {
                                    setState(() {
                                      print(val);
                                      if (val == true) {
                                        userChecked.add(data[i]);
                                        checkModel!.userCheckedFire
                                            .add(data[i]);
                                      } else {
                                        userChecked.remove(data[i]);
                                        checkModel!.userCheckedFire
                                            .remove(data[i]);
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
                          print(checkModel!.userCheckedFire);
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

    return StreamProvider.value(
      value: Database().getCheckbox,
      initialData: null,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('UserCheckList'),
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
                    _showCheckList();
                  },
                  child: Text('Open Bottom Sheet',
                      style: TextStyle(color: Colors.white)),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.red)),
                ),
                Text(userChecked.join(",")),
                Text(checkModel!.userCheckedFire.toString()),
              ],
            ),
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
