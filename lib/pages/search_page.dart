import 'package:flutter/material.dart';
import 'package:flutter_codigo5_youapp/pages/home_page.dart';
import 'package:flutter_codigo5_youapp/ui/widgets/item_search_widget.dart';

import '../models/video_model.dart';
import '../services/api_services.dart';
import '../ui/general/colors.dart';
import '../ui/widgets/item_list_video_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool _isSearching = true;
  int currentPage = 0;

  List<String> _listBusquedas = ["Alan Walker", "Peru Rusia 2018", "Wifi 6s"];

  List<Widget> _pages = [
    HomePage(),
    Center(
      child: Text(
        "Page 2",
      ),
    ),
    Center(
      child: Text(
        "Page 3",
      ),
    ),
    Center(
      child: Text(
        "Page 4",
      ),
    ),
    Center(
      child: Text(
        "Page 5",
      ),
    ),
  ];

  ApiServices _apiServices = new ApiServices();
  List<VideoModel> listVideo = [];
  TextEditingController txtSearch = TextEditingController();

  getVideos() {
    _apiServices.getListVideo(txtSearch.text).then((value) {
      if (value != null) {
        listVideo = value;
        _isSearching = false;
        setState(() {});
      } else {
        print("Error al Buscar los Videos");
        _isSearching = true;
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBrandTerciaryColor,
        elevation: 0,
        title: Container(
          //margin: const EdgeInsets.symmetric(vertical: 15.0,),
          padding: const EdgeInsets.all(0),
          height: 36.0,
          child: TextField(
            controller: txtSearch,
            onSubmitted: (value) {
              // print("hola");
              _listBusquedas.add(txtSearch.text);
              getVideos();
              //setState(() {});
            },
            onTap: () {
              _isSearching = true;
              setState(() {});
            },
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
            cursorColor: Colors.redAccent,
            decoration: InputDecoration(
              counterText: "",
              filled: true,
              fillColor: Colors.white.withOpacity(0.15),
              hintText: "Buscar...",
              contentPadding: EdgeInsets.symmetric(
                vertical: 2.0,
                horizontal: 8.0,
              ),
              hintStyle: TextStyle(
                fontSize: 13.0,
                color: Colors.white70,
              ),
              suffixIcon: Icon(
                Icons.close,
                color: Colors.white,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(3.0),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(3.0),
                borderSide: BorderSide.none,
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(3.0),
                borderSide: BorderSide.none,
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(3.0),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        actions: [
          //TextFormField(),
          Container(
            width: 35.0,
            height: 35.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white10,
            ),
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.mic_rounded,
                size: 18.0,
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.cast,
              size: 18.0,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.more_vert_outlined,
              size: 18.0,
            ),
          ),
          const SizedBox(
            width: 14.0,
          ),
        ],
      ),
      body: !_isSearching
          ? SingleChildScrollView(
            child: Column(
                children: listVideo
                        .map<Widget>((e) => ItemListVideoWidget(
                              videoModel: e,
                            ))
                        .toList(),
              ),
          )
          : Container(
              decoration: BoxDecoration(
                color: kBrandTerciaryColor,
              ),
              child: Column(
                children: _listBusquedas
                    .map<Widget>((e) => ItemSearchWidget(text: e))
                    .toList(),
              ),
            ),
      bottomNavigationBar: !_isSearching
          ? BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: kBrandTerciaryColor,
              selectedFontSize: 12.0,
              selectedItemColor: Colors.white,
              unselectedFontSize: 10.0,
              unselectedItemColor: Colors.white70,
              currentIndex: currentPage,
              onTap: (int value) {
                print(value);
                currentPage = value;
                setState(() {});
              },
              items: [
                const BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home,
                    ),
                    label: "Pricipal"),
                const BottomNavigationBarItem(
                    icon: Icon(
                      Icons.play_arrow_rounded,
                    ),
                    label: "Shorts"),
                BottomNavigationBarItem(
                    icon: Container(
                        margin: const EdgeInsets.only(
                          top: 4.0,
                        ),
                        child: const Icon(
                          Icons.add_circle_outline,
                          size: 30,
                        )),
                    label: ""),
                const BottomNavigationBarItem(
                    icon: Icon(
                      Icons.subscriptions_outlined,
                    ),
                    label: "Suscripciones"),
                const BottomNavigationBarItem(
                    icon: Icon(
                      Icons.video_collection_outlined,
                    ),
                    label: "Biblioteca"),
              ],
            )
          : null,
    );
  }
}
