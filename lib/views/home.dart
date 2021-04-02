import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:my_app/data/data.dart';
import 'package:my_app/model/categori_model.dart';
import 'package:my_app/model/wallpaper_model.dart';
import 'package:my_app/views/categori.dart';
import 'package:my_app/views/search.dart';
import 'package:my_app/widget/widget.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategorieModel> categories = new List();
  List<WallpaperModel> wallpapers = new List();
  TextEditingController searchControler = new TextEditingController();

  getTrendingWallpaper() async {
    var response = await http.get(
        Uri.https('api.pexels.com', 'v1/curated', {'per_page': '100'}),
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
    getTrendingWallpaper();
    categories = getCategories();
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
          ],
        ),
        backgroundColor: Color(0xff1e2022),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Color(0xffe85a71),
                    borderRadius: BorderRadius.circular(30)),
                margin: EdgeInsets.symmetric(horizontal: 24),
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: searchControler,
                        decoration: InputDecoration(
                          hintText: 'Search',
                          border: InputBorder.none,
                        ),
                        cursorColor: Color(0xffd8e9ef),
                      ),
                    ),
                    Divider(),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Search(
                                      searchQuery: searchControler.text)));
                        },
                        child: Container(child: Icon(Icons.search))),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 60,
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  itemCount: categories.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    // wallpapers[index].src.portrait;
                    return CategoriesTile(
                      title: categories[index].categorieName,
                      imgUrl: categories[index].imgUrl,
                    );
                  },
                ),
              ),
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

class CategoriesTile extends StatelessWidget {
  final String imgUrl, title;
  CategoriesTile({@required this.imgUrl, @required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Categorie(
                    categorieName: title.toLowerCase(),
                  )),
        );
      },
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: 5),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  imgUrl,
                  height: 60,
                  width: 150,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                color: Colors.black26,
                alignment: Alignment.center,
                height: 60,
                width: 150,
                child: Text(
                  title,
                  style: TextStyle(
                      color: Color(0xffd8e9ef),
                      fontWeight: FontWeight.w900,
                      fontSize: 17),
                ),
              ),
            ],
          )),
    );
  }
}
