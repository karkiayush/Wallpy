// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, await_only_futures, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:google_fonts/google_fonts.dart';

class FullImage extends StatefulWidget {
  final String imageUrl;
  const FullImage({super.key, required this.imageUrl});

  @override
  State<FullImage> createState() => _FullImageState();
}

class _FullImageState extends State<FullImage> {
  Future<void> setWallpaper() async {
    int location = WallpaperManager.BOTH_SCREEN; //can be Home/Lock Screen
    var file = await DefaultCacheManager().getSingleFile(widget.imageUrl);
    bool result = await WallpaperManager.setWallpaperFromFile(
        file.toString(), location); //provide image path
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(children: [
          Expanded(
              child: Container(
            child: Image.network(
              widget.imageUrl,
              fit: BoxFit.cover,
            ),
          )),
          Center(
            child: ElevatedButton(
                onPressed: () {
                  // loadMore();
                },
                child: Text(
                  "Set Wallpaper",
                  style: GoogleFonts.ptMono(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                )),
          ),
          SizedBox(
            height: 10,
          ),
        ]),
      ),
    );
  }
}
