import 'package:flutter/material.dart';
import 'package:flutter_codigo5_youapp/ui/general/colors.dart';

class ChannelPage extends StatefulWidget {

  @override
  State<ChannelPage> createState() => _ChannelPageState();
}

class _ChannelPageState extends State<ChannelPage> with TickerProviderStateMixin{
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 6, vsync: this,);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBrandTerciaryColor,
      appBar: AppBar(
        backgroundColor: kBrandTerciaryColor,
        title: Text("TechFest"),
        bottom: TabBar(
          isScrollable: true,
          indicatorColor: Colors.white,
          indicatorWeight: 2.7,
          controller: _tabController,
          tabs: [
            Tab(child: Text("PAGINA PRINCIPAL",style: TextStyle(fontSize: 16.0),),),
            Tab(child: Text("VIDEOS",style: TextStyle(fontSize: 16.0),),),
            Tab(child: Text("LISTA DE REPRODUCCION",style: TextStyle(fontSize: 16.0),),),
            Tab(child: Text("COMUNIDAD",style: TextStyle(fontSize: 16.0),),),
            Tab(child: Text("CANALES",style: TextStyle(fontSize: 16.0),),),
            Tab(child: Text("MÁS INFORMACIÓN",style: TextStyle(fontSize: 16.0),),),
          ],
        ),
      ),
    );
  }
}
