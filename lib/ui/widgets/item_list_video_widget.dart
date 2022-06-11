//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_codigo5_youapp/models/video_model.dart';
import 'package:flutter_codigo5_youapp/pages/video_detail_page.dart';
import 'package:flutter_codigo5_youapp/services/api_services.dart';
import 'package:flutter_codigo5_youapp/ui/general/colors.dart';

import '../../models/chanel_model.dart';

class ItemListVideoWidget extends StatelessWidget {
  VideoModel videoModel;
  ItemListVideoWidget({required this.videoModel});

  final ApiServices _apiService = ApiServices();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>VideoDetailPage(idVideo: videoModel.id.videoId ?? "",titleVideo: videoModel.snippet.title,idChannel: videoModel.snippet.channelId,)));
      },
      child: Container(
        padding: const EdgeInsets.only(
          bottom: 10.0,
        ),
        decoration: BoxDecoration(
          color: kBrandTerciaryColor,
        ),
        child: Column(
          children: [
            Stack(
              children: [
                Image.network(
                  videoModel.snippet.thumbnails.high.url,
                  width: double.infinity,
                  height: height * 0.3,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    margin: const EdgeInsets.all(10.0),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 5.0, vertical: 2.0),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                    ),
                    child: Text(
                      "23.03",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            ListTile(
              leading: FutureBuilder(
                future: _apiService.getChanel(videoModel.snippet.channelId),
                builder: (BuildContext context, AsyncSnapshot snap){
                  if(snap.hasData){
                    ChanelModel channel = snap.data;
                    return Container(
                      margin: const EdgeInsets.only(left: 10.0),
                      child: CircleAvatar(
                        backgroundColor: Colors.white30,
                        backgroundImage: NetworkImage(channel.snippet.thumbnails.thumbnailsDefault.url),
                      ),
                    );
                  }
                  return Container(
                    width: 50,
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: 16,
                      width: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.0,
                        color: Colors.white,
                      ),
                    ),
                  );
                },
              ),
              title: Text(
                videoModel.snippet.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                ),
              ),
              subtitle: Text(
                "alanxelmundo · 8.8 M vistas · hace 5 años",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 13.0,
                ),
              ),
              trailing: Container(
                //color: Colors.red,
                padding: const EdgeInsets.only(
                  top: 8.0,
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.more_vert,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              contentPadding: EdgeInsets.zero,
            ),
          ],
        ),
      ),
    );
  }
}
