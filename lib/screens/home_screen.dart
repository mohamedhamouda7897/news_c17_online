import 'package:flutter/material.dart';
import 'package:news_c17_online/core/api_manager.dart';
import 'package:news_c17_online/models/sources_reponse.dart';
import 'package:news_c17_online/screens/news_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "/";

  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue.shade50,
        title: Text("News"),
      ),

      body: FutureBuilder(
        future: ApiManager.getSources(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Something went wrong"));
          }

          List<Sources> sources = snapshot.data?.sources ?? [];
          return Column(
            children: [
              DefaultTabController(
                length: sources.length,
                initialIndex: selectedIndex,
                child: TabBar(
                  isScrollable: true,

                  onTap: (index) {
                    selectedIndex = index;
                    setState(() {});
                  },
                  tabAlignment: TabAlignment.start,
                  dividerColor: Colors.transparent,
                  tabs: sources
                      .map((e) => Tab(child: Text(e.name ?? "")))
                      .toList(),
                ),
              ),
              Expanded(child: NewsScreen(sourceId: sources[selectedIndex].id ?? "")),
            ],
          );
        },
      ),
    );
  }
}
