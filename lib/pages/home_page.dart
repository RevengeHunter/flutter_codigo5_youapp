import 'package:flutter/material.dart';
import 'package:flutter_codigo5_youapp/models/video_model.dart';
import 'package:flutter_codigo5_youapp/services/api_services.dart';

import '../ui/general/colors.dart';
import '../ui/widgets/item_filter_widget.dart';
import '../ui/widgets/item_list_video_widget.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ApiServices _apiServices = ApiServices();
  List<VideoModel> listVideo = [];
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getVideos();
  }

  getVideos() {
    _apiServices.getVideos().then((value) {
      if (value != null) {
        listVideo = value;
        isLoading = false;
        print(listVideo);
        setState(() {});
      } else {
        print("Error al Buscar los Videos");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBrandTerciaryColor,
      body: !isLoading
          ? SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 6.0,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 12.0,
                        ),
                        ElevatedButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.explore_outlined),
                          label: Text(
                            "Explorar",
                          ),
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              primary: kBrandSecondaryColor,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0)),
                        ),
                        SizedBox(
                          height: 30.0,
                          child: VerticalDivider(
                            thickness: 0.9,
                            color: kBrandSecondaryColor,
                          ),
                        ),
                        ItemFilterWidget(
                          text: "Todos",
                          isSelected: true,
                        ),
                        ItemFilterWidget(
                          text: "Musica",
                          isSelected: false,
                        ),
                        ItemFilterWidget(
                          text: "Videojuegos",
                          isSelected: false,
                        ),
                        ItemFilterWidget(
                          text: "Mixes",
                          isSelected: false,
                        ),
                        ItemFilterWidget(
                          text: "Comedia",
                          isSelected: false,
                        ),
                        ItemFilterWidget(
                          text: "Anime",
                          isSelected: false,
                        ),
                        ItemFilterWidget(
                          text: "En tiempo real",
                          isSelected: false,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  ...listVideo
                      .map<Widget>((e) => ItemListVideoWidget(
                            videoModel: e,
                          ))
                      .toList(),
                ],
              ),
            )
          : Center(
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2.0,
                  color: Colors.white,
                ),
              ),
            ),
    );
  }
}
