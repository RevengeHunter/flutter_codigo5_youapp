import 'package:flutter/material.dart';
import 'package:flutter_codigo5_youapp/pages/home_page.dart';
import 'package:flutter_codigo5_youapp/pages/search_page.dart';

import '../ui/general/colors.dart';

class InitPage extends StatefulWidget {
  const InitPage({Key? key}) : super(key: key);

  @override
  State<InitPage> createState() => _InitPageState();
}

class _InitPageState extends State<InitPage> {
  int currentPage = 0;

  List<Widget> _pages = [
    HomePage(),
    Center(child: Text("Page 2",),),
    Center(child: Text("Page 3",),),
    Center(child: Text("Page 4",),),
    Center(child: Text("Page 5",),),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBrandTerciaryColor,
        title: Image.asset(
          'assets/images/logoYouTube.png',
          height: 26.0,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.cast,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(
                  Icons.notifications_none,
                ),
                Positioned(
                  top: -2,
                  right: -4,
                  child: Container(
                    padding: const EdgeInsets.all(2.4),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                    child: const Text(
                      "9+",
                      style: TextStyle(
                        fontSize: 11.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchPage()));
            },
            icon: Icon(
              Icons.search,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: CircleAvatar(
              // backgroundColor: Colors.redAccent,
              backgroundImage: NetworkImage(
                  "https://images.pexels.com/photos/733872/pexels-photo-733872.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
              radius: 14.0,
            ),
          ),
          const SizedBox(width: 14.0,),
        ],
      ),
      body:_pages[currentPage],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0xff241E28),
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
      ),
    );
  }
}
