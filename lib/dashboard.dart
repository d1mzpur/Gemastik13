import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:url_launcher/url_launcher.dart';

int positif;
int sembuh;
int meninggal;
int upositif;
int usembuh;
int umeninggal;
String tanggal = '';

class DashboardPage extends StatefulWidget {
  final String username;

  const DashboardPage({Key key, this.username}) : super(key: key);
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  void initState() {
    _getdatacovid();
    _getdata();
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
                new Image.asset(
                  "images/logo.png",
                  width: double.infinity,
                  height: 150.0,
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(bottom: 20),
                  child: Center(
                    child: Text(
                      "Dimas Purnomo",
                      style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                          letterSpacing: 5,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: FlatButton(
                    onPressed: null,
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      child: new Text(
                        "Lokasi Terkini",
                        style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.white, width: 3.0),
                        borderRadius: BorderRadius.circular(20.0)),
                  ),
                ),
                new GridView.count(
                  crossAxisCount: 2,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  children: <Widget>[
                    Covid(
                      nama: "Positif Covid-19",
                      data: "$upositif",
                      data2: "Hari Ini : $positif",
                    ),
                    Covid(
                      nama: "Sembuh Covid-19",
                      data: "$usembuh",
                      data2: "Hari Ini : $sembuh",
                    ),
                    Covid(
                      nama: "Meninggal Covid-19",
                      data: "$umeninggal",
                      data2: "Hari Ini : $meninggal",
                    ),
                    Covid(
                      nama: "Update Data Covid-19",
                      data: "$tanggal",
                      data2: "",
                    ),
                  ],
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(15.0),
                  child: FlatButton(
                    onPressed: null,
                    child: Column(
                      children: [
                        Padding(padding: EdgeInsets.only(top: 20)),
                        Text(
                          "Berita Covid-19",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20.0,
                              letterSpacing: 5,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        Padding(padding: EdgeInsets.only(top: 20)),
                        new ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: dataList == null ? 0 : dataList.length = 5,
                          itemBuilder: (BuildContext context, int i) {
                            return Berita(
                              tittle: "${dataList[i]['title']}",
                              press: () {
                                String url = "${dataList[i]['url']}";
                                _launchURL(url);
                              },
                            );
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 30),
                        )
                      ],
                    ),
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.white, width: 3.0),
                        borderRadius: BorderRadius.circular(20.0)),
                  ),
                ),
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
    return data;
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  List<dynamic> dataList = List();
  Future<String> _getdata() async {
    final response =
        await http.get("https://dekontaminasi.com/api/id/covid19/news");

    var data = json.decode(response.body);

    // print(response.body);
    setState(() {
      dataList = data;
    });
    return data;
  }
}

class Covid extends StatelessWidget {
  final String nama;
  final String data;
  final String data2;
  const Covid({
    Key key,
    this.nama,
    this.data,
    this.data2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: EdgeInsets.all(20.0),
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13),
        color: Colors.white,
      ),
      child: Center(
        child: new Column(
          children: <Widget>[
            new Text(
              nama,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 15.0,
                  letterSpacing: 1.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            Padding(padding: EdgeInsets.only(top: 10.0)),
            Text(
              data,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black,
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 10.0)),
            Text(
              data2,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Berita extends StatelessWidget {
  final String tittle;
  final Function press;
  const Berita({
    Key key,
    this.tittle,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 8),
      child: FlatButton(
        onPressed: press,
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: new Text(
            tittle,
            style: TextStyle(
                fontSize: 14.0,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
        ),
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.white, width: 3.0),
            borderRadius: BorderRadius.circular(20.0)),
      ),
    );
  }
}
