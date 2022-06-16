import 'package:flutter/material.dart';
import 'package:flutter_codigo5_youapp/models/chanel_model.dart';
import 'package:flutter_codigo5_youapp/ui/general/colors.dart';

import '../services/api_services.dart';

class ChannelPage extends StatefulWidget {
  String idChannel;
  ChannelPage({required this.idChannel});

  @override
  State<ChannelPage> createState() => _ChannelPageState();
}

class _ChannelPageState extends State<ChannelPage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  late ChanelModel chanelModel;
  final ApiServices _apiServices = ApiServices();

  bool _isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(
      length: 6,
      vsync: this,
    );
    getChannel();
  }

  getChannel() {
    _apiServices.getChanel(widget.idChannel).then((value) {
      if (value != null) {
        chanelModel = ChanelModel(
          id: value.id,
          brandingSettings: value.brandingSettings,
          contentDetails: value.contentDetails,
          etag: value.etag,
          kind: value.kind,
          snippet: value.snippet,
          topicDetails: value.topicDetails,
        );
        _isLoading = false;
        setState(() {});
      } else {
        _isLoading = false;
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBrandTerciaryColor,
      appBar: AppBar(
        backgroundColor: kBrandTerciaryColor,
        title: Text(chanelModel.snippet.title),
        bottom: TabBar(
          isScrollable: true,
          indicatorColor: Colors.white,
          indicatorWeight: 2.7,
          controller: _tabController,
          tabs: [
            Tab(
              child: Text(
                "PAGINA PRINCIPAL",
                style: TextStyle(fontSize: 16.0),
              ),
            ),
            Tab(
              child: Text(
                "VIDEOS",
                style: TextStyle(fontSize: 16.0),
              ),
            ),
            Tab(
              child: Text(
                "LISTA DE REPRODUCCION",
                style: TextStyle(fontSize: 16.0),
              ),
            ),
            Tab(
              child: Text(
                "COMUNIDAD",
                style: TextStyle(fontSize: 16.0),
              ),
            ),
            Tab(
              child: Text(
                "CANALES",
                style: TextStyle(fontSize: 16.0),
              ),
            ),
            Tab(
              child: Text(
                "MÁS INFORMACIÓN",
                style: TextStyle(fontSize: 16.0),
              ),
            ),
          ],
        ),
      ),
      body: !_isLoading
          ? TabBarView(
              controller: _tabController,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(
                        vertical: 20.0,
                        horizontal: 10.0,
                      ),
                      child: CircleAvatar(
                        radius: 35,
                        foregroundImage: NetworkImage(
                          chanelModel.snippet.thumbnails.thumbnailsDefault.url,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      "SUBSCRIBIRSE",
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      "25K suscriptores · 12 videos",
                      style: TextStyle(color: Colors.white54, fontSize: 12.0),
                    ),
                  ],
                ),
                Center(
                  child: Text("Videos"),
                ),
                Center(
                  child: Text("Lista de Reproducción"),
                ),
                Center(
                  child: Text("Comunidad"),
                ),
                Center(
                  child: Text("Canales"),
                ),
                Center(
                  child: Text("Más Información"),
                ),
              ],
            )
          : const Center(
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
