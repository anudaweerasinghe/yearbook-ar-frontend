import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:async/async.dart';
import 'dart:typed_data';
import 'video.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String barcode = "";

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: PreferredSize(
            child: new AppBar(
              elevation: 0,
              title: new Text(
                'OSC Augmented Yearbook',
                textAlign: TextAlign.center,
                style: new TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      new Color.fromARGB(255, 252, 70, 107),
                      new Color.fromARGB(255, 63, 94, 251)
                    ],
                  ),
                ),
              ),
            ),
            preferredSize: Size.fromHeight(55)),
        body: Center(
            child: Column(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text("Welcome!",
                        textAlign: TextAlign.left,
                        style: new TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.w900,
                            fontFamily: 'Roboto')),
                    Padding(padding: EdgeInsets.all(10),),
                    Text("1. Buy a copy of the 2019-2020 Yearbook from the OSC Library",
                        textAlign: TextAlign.left,
                        style: new TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Roboto')),
                    Padding(padding: EdgeInsets.all(5),),
                    Text("2. Find a page with Augmented Content",
                        textAlign: TextAlign.left,
                        style: new TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Roboto')),
                    Padding(padding: EdgeInsets.all(5),),
                    Text("3. Scan the QR Code by pressing the button below",
                        textAlign: TextAlign.left,
                        style: new TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Roboto')),
                    Padding(padding: EdgeInsets.all(5),),
                    Text("4. Relive the memories and Enjoy!",
                        textAlign: TextAlign.left,
                        style: new TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Roboto')),
                  ],
                )),
            new Container(
              margin:
                  new EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: RaisedButton(
                  onPressed: scan,
                  textColor: Colors.white,
                  color: Colors.white,
                  padding: const EdgeInsets.all(0.0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          new Color.fromARGB(255, 252, 70, 107),
                          new Color.fromARGB(255, 63, 94, 251)
                        ],
                      ),
                    ),
                    padding: const EdgeInsets.all(10.0),
                    child: const Text('Scan for Augmented Content',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 26, fontWeight: FontWeight.w600)),
                  )),
            ),
          ],
        )));
  }

  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();

      Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (ctxt) => new VideoScreen(
                  qrText: barcode,
                )),
      );
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException {
      setState(() => this.barcode =
          'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }
}
