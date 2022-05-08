import 'package:firbaseauth/Testing/firebasemethods/database.dart';
import 'package:firbaseauth/services/auth.dart';
import 'package:flutter/material.dart';

class RegisterUser extends StatefulWidget {
  final Function toggleView;
  RegisterUser({required this.toggleView});

  @override
  _RegisterUserState createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  final AuthService _authService = AuthService();
  final Database _dbService = Database();

  final username = TextEditingController();

  final email = TextEditingController();

  final password = TextEditingController();

  final _sigInFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double actualWidth = MediaQuery.of(context).size.width;
    double actualHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[400],
        elevation: 0.0,
        title: Text('Hostel Registration'),
        actions: <Widget>[
          TextButton.icon(
            icon: Icon(Icons.app_registration),
            label: Text(
              'Sign In',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onPressed: () => widget.toggleView(),
          ),
        ],
      ),
      body: Center(
        child: SizedBox(
          width: actualWidth * 0.75,
          height: actualHeight * 0.85,
          child: Card(
            elevation: 8,
            shadowColor: Colors.white,
            color: Color(0xFF8e18d2),
            child: Padding(
              padding: EdgeInsets.all(5),
              child: Form(
                key: _sigInFormKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextFormField(
                        autofocus: true,
                        controller: username,
                        decoration: InputDecoration(
                          hintText: 'useranme',
                          fillColor: Colors.white,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            width: 2.0,
                            color: Colors.white,
                          )),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            width: 2.0,
                            color: Colors.deepPurple,
                          )),
                        ),
                        onChanged: (val) {
                          setState(() {});
                        }),
                    TextFormField(
                        autofocus: true,
                        controller: email,
                        decoration: InputDecoration(
                          hintText: 'email',
                          fillColor: Colors.white,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            width: 2.0,
                            color: Colors.white,
                          )),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            width: 2.0,
                            color: Colors.deepPurple,
                          )),
                        ),
                        onChanged: (val) {
                          setState(() {});
                        }),
                    TextFormField(
                        autofocus: true,
                        obscureText: true,
                        controller: password,
                        decoration: InputDecoration(
                          hintText: 'password',
                          fillColor: Colors.white,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            width: 2.0,
                            color: Colors.white,
                          )),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            width: 2.0,
                            color: Colors.deepPurple,
                          )),
                        ),
                        onChanged: (val) {
                          setState(() {});
                        }),
                    GestureDetector(
                      child: MycustomBtn(
                          Colors.green, Icons.how_to_reg, 'Register'),
                      onTap: () async {
                        if (_sigInFormKey.currentState!.validate()) {
                          await _authService.registerWithEmailAndPassword(
                              email.text,
                              password.text); // use the email provided here

                          await _authService.addInDatabase(
                              username.text, password.text);

                          await _dbService.addCheckbox([]);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget MycustomBtn(Color Btncolor, iconPassed, labelValue) {
    final IconData? icon = iconPassed;
    final String label = labelValue;
    final Color color = Btncolor;

    return Container(
      margin: EdgeInsets.all(10),
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(offset: Offset.zero, blurRadius: 1, color: Colors.white)
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 15,
            ),
            Icon(
              icon,
              size: 25,
              color: Colors.white,
            ),
            SizedBox(
              width: 15,
            ),
            Text(
              label,
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }

  Widget myTextInput(String hintText, TextEditingController controller,
      obsureText, String Value) {
    return TextFormField(
      onChanged: (text) {},
      obscureText: obsureText,
      controller: controller..text = Value,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.indigoAccent, width: 2.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2.0),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.grey,
          ),
          fillColor: Color.fromARGB(255, 87, 47, 103)),
    );
  }
}
