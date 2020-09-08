import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

int positif;
int sembuh;
int meninggal;
int upositif;
int usembuh;
int umeninggal;
String tanggal;

class DashboardPage extends StatefulWidget {
  final String username;

  const DashboardPage({Key key, this.username}) : super(key: key);
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  void initState() {
    _getdatacovid();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            color: Color(0xff0c39da),
            child: Column(
              children: [
                new Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(15.0),
                  child: FlatButton(
                    onPressed: null,
                    child: Column(
                      children: [
                        Padding(padding: EdgeInsets.only(top: 20)),
                        Text(
                          "Update Data \nCovid-19 Indonesia",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20.0,
                              letterSpacing: 5,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        Padding(padding: EdgeInsets.only(top: 20)),
                        Text(
                          tanggal,
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: 20)),
                        IsiMenu(nama: 'Positif Covid-19'),
                        Menu(nama: "Hari Ini : $positif | Total : $upositif"),
                        IsiMenu(nama: 'Sembuh Covid-19'),
                        Menu(nama: "Hari Ini : $sembuh | Total : $usembuh"),
                        IsiMenu(nama: 'Meninggal Covid-19'),
                        Menu(
                            nama:
                                "Hari Ini : $meninggal | Total : $umeninggal"),
                        Padding(
                          padding: EdgeInsets.only(top: 30),
                        )
                      ],
                    ),
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.white, width: 3.0),
                        borderRadius: BorderRadius.circular(20.0)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<String> _getdatacovid() async {
    final response =
        await http.get("https://data.covid19.go.id/public/api/update.json");

    var data = json.decode(response.body);

    setState(() {
      tanggal = data['update']['penambahan']['created'];
      positif = data['update']['penambahan']['jumlah_positif'];
      sembuh = data['update']['penambahan']['jumlah_sembuh'];
      meninggal = data['update']['penambahan']['jumlah_meninggal'];
      upositif = data['update']['total']['jumlah_positif'];
      usembuh = data['update']['total']['jumlah_sembuh'];
      umeninggal = data['update']['total']['jumlah_meninggal'];
    });
    // return data;
  }
}

class IsiMenu extends StatelessWidget {
  final String nama;
  const IsiMenu({
    Key key,
    this.nama,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      nama,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 16.0,
        letterSpacing: 5,
        color: Colors.white,
      ),
    );
  }
}

class Menu extends StatelessWidget {
  final String nama;
  final Function press;
  const Menu({
    Key key,
    this.nama,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: FlatButton(
        onPressed: press,
        child: new Text(
          nama,
          style: TextStyle(
              fontSize: 14.0, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.white, width: 3.0),
            borderRadius: BorderRadius.circular(20.0)),
      ),
    );
  }
}
