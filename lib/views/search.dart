import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_app/model/wallpaper_model.dart';
import 'package:my_app/widget/widget.dart';
import 'package:http/http.dart' as http;

class Search extends StatefulWidget {
  final String searchQuery;
  Search({this.searchQuery});

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final searchControler = new TextEditingController();
  List<WallpaperModel> wallpapers = new List();

  getSearchWallpaper(String query) async {
    var response = await http.get(
        Uri.https(
            'api.pexels.com', 'v1/search', {'query': query, 'per_page': '100'}),
        headers: {
          "Authorization":
              '563492ad6f917000010000011c125b87e7a743879a7834c2324e1037'
        });

    Map<String, dynamic> jsonData = jsonDecode(response.body);
    jsonData['photos'].forEach((element) {
      WallpaperModel wallpaperModel = new WallpaperModel();
      wallpaperModel = WallpaperModel.fromMap(element);
      wallpapers.add(wallpaperModel);
    });

    setState(() {});
  }

  @override
  void initState() {
    getSearchWallpaper(widget.searchQuery);
    searchControler.text = widget.searchQuery;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1e2022),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Branding(),
            SizedBox(
              width: 55.5,
            )
          ],
        ),
        backgroundColor: Color(0xff1e2022),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              wallpaperList(wallpapers: wallpapers, context: context),
            ],
          ),
        ),
      ),
    );
  }
}
