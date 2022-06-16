import 'package:flutter/material.dart';
import 'package:flutter_codigo5_youapp/pages/channel_page.dart';
import 'package:flutter_codigo5_youapp/ui/general/colors.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../models/chanel_model.dart';
import '../models/video_model.dart';
import '../services/api_services.dart';
import '../ui/widgets/item_list_video_widget.dart';

class VideoDetailPage extends StatefulWidget {
  String idVideo;
  String titleVideo;
  String? descriptionVideo;
  String idChannel;

  VideoDetailPage({
    required this.idVideo,
    required this.titleVideo,
    this.descriptionVideo,
    required this.idChannel,
  });

  @override
  State<VideoDetailPage> createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.idVideo;
    _controller = YoutubePlayerController(
      initialVideoId: widget.idVideo,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        hideControls: false,
      ),
    );
    getVideos();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  final ApiServices _apiServices = ApiServices();
  List<VideoModel> listVideo = [];

  getVideos() {
    _apiServices.getVideos().then((value) {
      if (value != null) {
        listVideo = value;
        setState(() {});
      } else {
        print("Error al Buscar los Videos");
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: kBrandTerciaryColor,
      body: Column(
        children: [
          SizedBox(
            height: height * 0.35,
            child: YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: false,
              progressColors: ProgressBarColors(
                backgroundColor: Colors.white.withOpacity(0.1),
                bufferedColor: Colors.white54,
                handleColor: Colors.red,
                playedColor: Colors.red,
              ),
              // bottomActions: [
              //
              // ],
              // thumbnail: Text(
              //   "Hola",
              //   style: TextStyle(
              //     color: Colors.white,
              //     fontSize: 20.0,
              //   ),
              // ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(children: [
                ListTile(
                  title: Text(
                    widget.titleVideo,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      height: 1.3,
                    ),
                  ),
                  subtitle: Container(
                    margin: EdgeInsets.symmetric(
                      vertical: 4.0,
                    ),
                    child: Text(
                      "8.8M de vistas · hace 5 años",
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 13.0,
                      ),
                    ),
                  ),
                  trailing: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.white,
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconDetailVideoWidget(
                          icon: Icons.thumb_up_alt_outlined,
                          text: "354 K",
                        ),
                        IconDetailVideoWidget(
                          icon: Icons.thumb_down_alt_outlined,
                          text: "No me gusta",
                        ),
                        IconDetailVideoWidget(
                          icon: Icons.share,
                          text: "Compartir",
                        ),
                        IconDetailVideoWidget(
                          icon: Icons.download_rounded,
                          text: "Descargar",
                        ),
                        IconDetailVideoWidget(
                          icon: Icons.cut,
                          text: "Recortar",
                        ),
                        IconDetailVideoWidget(
                          icon: Icons.video_settings,
                          text: "Guardar",
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(color: Colors.white12,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  child: GestureDetector(
                    onTap: (){
                      _controller.pause();
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ChannelPage(idChannel: widget.idChannel,)));
                    },
                    child: FutureBuilder(
                      future: _apiServices.getChanel(widget.idChannel),
                      builder: (BuildContext context, AsyncSnapshot snap){
                        if(snap.hasData){
                          ChanelModel channel = snap.data;
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.black12,
                                backgroundImage: NetworkImage(
                                  channel.snippet.thumbnails.thumbnailsDefault.url,
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        channel.snippet.title,
                                        style: TextStyle(color: Colors.white70, fontSize: 15.0),
                                      ),
                                      Text(
                                        "25K suscriptores",
                                        style: TextStyle(color: Colors.white54, fontSize: 12.0),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Text(
                                "SUSCRIBIRSE",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w500
                                ),
                              )
                            ],
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
                  ),
                ),
                Divider(color: Colors.white12,),
                SingleChildScrollView(
                  child: Column(
                    children: listVideo
                        .map<Widget>((e) => ItemListVideoWidget(
                      videoModel: e,
                    ))
                        .toList(),
                  ),
                )
              ],),
            ),
          ),
        ],
      ),
    );
  }
}

class IconDetailVideoWidget extends StatelessWidget {

  IconData icon;
  String text;
  IconDetailVideoWidget({required this.icon, required this.text,});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 20.0),
      child: Column(
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 26.0,
          ),
          SizedBox(
            height: 6.0,
          ),
          Text(
            text,
            style: TextStyle(
                color: Colors.white60,
                fontSize: 12.0,
                fontWeight: FontWeight.w500
            ),
          )
        ],
      ),
    );
  }
}
