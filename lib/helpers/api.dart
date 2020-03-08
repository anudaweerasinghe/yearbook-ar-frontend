import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:yearbook/models/video_model.dart';


const baseUrl = "http://142.93.212.170:8080/yearbook/";


Future<Video> getVideoDetails(String qrText) async{

  String url = baseUrl+'videos/get?qrText='+qrText;

  final response = await http.get(url);

  if(response.statusCode == 200){

    Video videoDetails;

    var data = json.decode(response.body);
    videoDetails = new Video.fromJson(data);
    return videoDetails;

  }else{

    return null;

  }

}
