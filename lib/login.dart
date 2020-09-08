import 'dart:async';
import 'dart:convert';

import 'package:acovid19/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

String username = '';

class Login extends StatelessWidget {
  @override
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'ACOVID-19',
      debugShowCheckedModeBanner: false,
      home: new MyHomePage(),
      routes: <String, WidgetBuilder>{
        '/DashboardPage': (BuildContext context) => new DashboardPage(
              username: username,
            ),
        '/MyHomePage': (BuildContext context) => new MyHomePage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController user = new TextEditingController();
  TextEditingController pass = new TextEditingController();

  Future<List> _login() async {
    final response = await http
        .post("https://d1m.000webhostapp.com/asisten/login.php", body: {
      "username": user.text,
      "password": pass.text,
    });

    var datauser = json.decode(response.body);

    if (datauser.length == 0) {
      setState(() {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Status"),
                content: Text('Email atau Password Salah'),
              );
            });
      });
    } else {
      Navigator.pushReplacementNamed(context, '/MemberPage');

      setState(() {
        username = datauser[0]['username'];
      });
    }
    return datauser;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context)
        .size; //this gonna give us total height and with of our device
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Container(
          color: Color(0xff0c39da),
          child: SafeArea(
            child: ListView(
              children: <Widget>[
                new Column(
                  children: [
                    new Container(
                      height: size.height * .44,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            "images/login.png",
                          ),
                        ),
                      ),
                    ),
                    new Container(
                      margin:
                          EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(29.5)),
                      child: new TextField(
                        keyboardType: TextInputType.numberWithOptions(),
                        controller: user,
                        decoration: InputDecoration(
                            icon: Icon(
                              Icons.person_outline,
                              color: Colors.blue,
                            ),
                            hintText: 'Email'),
                      ),
                    ),
                    new Container(
                      margin:
                          EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(29.5)),
                      child: new TextField(
                        controller: pass,
                        obscureText: true,
                        decoration: InputDecoration(
                            icon: Icon(
                              Icons.vpn_key,
                              color: Colors.blue,
                            ),
                            hintText: 'Kata Sandi'),
                      ),
                    ),
                    new Container(
                      margin: EdgeInsets.only(
                        top: 10.0,
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                      child: new FlatButton(
                        child: Column(
                          children: [
                            Text(
                              "Login",
                              style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        onPressed: () {
                          _login();
                        },
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.white, width: 3.0),
                            borderRadius: BorderRadius.circular(20.0)),
                      ),
                    ),
                    new Container(
                      width: double.infinity,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
                      child: new FlatButton(
                        child: Column(
                          children: [
                            Text(
                              "Buat Akun Baru",
                              style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        onPressed: () {},
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.white, width: 3.0),
                            borderRadius: BorderRadius.circular(20.0)),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
