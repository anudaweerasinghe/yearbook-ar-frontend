import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';
import 'package:yearbook/models/video_model.dart';
import 'package:yearbook/helpers/api.dart';

class VideoScreen extends StatefulWidget{

  final String qrText;

  VideoScreen(
      {Key key, this.qrText})
      : super(key: key);

  @override
  _VideoScreenState createState() => new _VideoScreenState(qrText: qrText);
}

class _VideoScreenState extends State<VideoScreen>{

  String qrText;
  Video videoDetails = new Video();

  _VideoScreenState({Key key, this.qrText});

  @override
  initState() {
    super.initState();
    getData();
  }

  openStream(String url) async{
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  getData() async{

    videoDetails = await getVideoDetails(qrText);

    if(videoDetails!=null) {
      setState(() {});
    }else{
      _showDialog();
    }

  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Invalid QR Code!"),
          content: new Text("The QR Code you have scanned seems to be invalid... Please try again."),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("OK", style: new TextStyle(color: Colors.white),),
              color: new Color.fromARGB(255, 252, 70, 107),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();

              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    if(videoDetails.url!=null){
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
              preferredSize: Size.fromHeight(55)
          ),
          body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(videoDetails.description,
                                textAlign: TextAlign.left,
                                style: new TextStyle(
                                    fontSize: 23.0,
                                    fontWeight: FontWeight.w900,
                                    fontFamily: 'Roboto')),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 3, horizontal: 8),
                            ),
                            Text("Views: "+videoDetails.views.toString(),
                                textAlign: TextAlign.left,
                                style: new TextStyle(
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Roboto')),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 3, horizontal: 8),
                            ),
                            new Stack(
                              children: <Widget>[
                                new Image.network(
                                  videoDetails.thumbnailUrl,
                                  color: Color.fromRGBO(255, 255, 255, 0.85),
                                  colorBlendMode: BlendMode.modulate,
                                ),

                                Positioned.fill(
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.play_circle_filled,
                                        color: Colors.white,size: 50,
                                      ),
                                      onPressed: (){
                                        openStream(videoDetails.url);
                                      },
                                    )
                                )
                              ],
                            )
                          ]
                      ),
                    ),
                  ),
                )
              ]
          )

      );

    }else{

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
              preferredSize: Size.fromHeight(55)
          ),

      );

    }


  }
}