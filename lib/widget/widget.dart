import 'package:flutter/material.dart';
import 'package:my_app/model/wallpaper_model.dart';
import 'package:my_app/views/image_view.dart';

Widget Branding() {
  return RichText(
    text: TextSpan(
      style: TextStyle(color: Colors.white, fontSize: 20),
      children: <TextSpan>[
        TextSpan(
            text: 'Bangin',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            )),
        TextSpan(
            text: 'Hub',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xffe85a71),
            )),
      ],
    ),
  );
}

Widget wallpaperList({List<WallpaperModel> wallpapers, context}) {
  return Container(
      child: GridView.count(
    shrinkWrap: true,
    physics: ClampingScrollPhysics(),
    crossAxisCount: 2,
    childAspectRatio: 0.6,
    padding: EdgeInsets.symmetric(horizontal: 24),
    mainAxisSpacing: 10,
    crossAxisSpacing: 10,
    children: wallpapers.map((e) {
      return GridTile(
        child: Container(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ImageView(
                            ImgUrl: e.src.portrait,
                          )));
            },
            child: Hero(
              tag: e.src.portrait,
              // tag: ,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/3.gif',
                  image: e.src.portrait,
                  fit: BoxFit.cover,
                ),
                // child: Image.network(
                //   e.src.portrait,
                //   fit: BoxFit.cover
                // ),
              ),
            ),
          ),
        ),
      );
    }).toList(),
  ));
}
