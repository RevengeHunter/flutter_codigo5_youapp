import 'dart:convert';

import 'package:flutter_codigo5_youapp/models/chanel_model.dart';
import 'package:flutter_codigo5_youapp/models/video_model.dart';
import 'package:flutter_codigo5_youapp/ui/general/config.dart';
import 'package:http/http.dart' as http;

class ApiServices {

  Future<List<VideoModel>> getVideos() async {
    Uri url = Uri.parse(
        "${videoURL}part=snippet&maxResults=5&key=$apiKey");
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = jsonDecode(response.body);
      List movies = myMap["items"];
      //print(movies);
      List<VideoModel> movieList =
      movies.map<VideoModel>((e) => VideoModel.fromJson(e)).toList();
      return movieList;
    }

    return [];
  }

  Future<List<VideoModel>> getListVideo(String textSearch) async {
    Uri url = Uri.parse(
        "${videoURL}part=snippet&maxResults=5&q=$textSearch&key=$apiKey");
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = jsonDecode(response.body);
      List movies = myMap["items"];
      List<VideoModel> movieList =
      movies.map<VideoModel>((e) => VideoModel.fromJson(e)).toList();
      print(movieList);
      return movieList;
    }

    return [];
  }

  Future<ChanelModel?> getChanel(String chanelID) async{
    Uri url = Uri.parse(
        "${channelURL}part=snippet,brandingSettings,contentDetails,topicDetails&id=$chanelID&key=$apiKey");
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = jsonDecode(response.body);
      print(myMap);
      ChanelModel chanelModel = ChanelModel.fromJson(myMap["items"][0]);
      return chanelModel;
    }

    return null;
  }
}

