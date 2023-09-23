// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, avoid_print, file_names, prefer_interpolation_to_compose_strings, unused_local_variable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:wallpy/api_key.dart';
import 'package:wallpy/full_image.dart';

//first class
class WallpaperScreen extends StatefulWidget {
  const WallpaperScreen({super.key});

  @override
  State<WallpaperScreen> createState() => _WallpaperScreenState();
}

//second class
class _WallpaperScreenState extends State<WallpaperScreen> {
  String? fullImageUrl;
  List fetchedImages = [];
  int page = 1;
  fetchApi() async {
    await http.get(
        Uri.parse(
          'https://api.pexels.com/v1/curated?per_page=80',
        ),
        headers: {'Authorization': ApiKey.apiKey}).then((value) {
      Map requiredResult = jsonDecode(value.body);
      // print(requiredResult['photos']);
      // print(value.body);
      fetchedImages = requiredResult['photos'];
      print(fetchedImages);
    });
  }

  loadMore() async {
    setState(() {
      page++;
    });
    String url =
        'https://api.pexels.com/v1/curated?per_page=80&page=' + page.toString();
    await http.get(Uri.parse(url),
        headers: {'Authorization': ApiKey.apiKey}).then((value) {
      Map requiredResult = jsonDecode(value.body);
      fetchedImages.addAll(requiredResult['photos']);
    });
  }

  @override
  void initState() {
    super.initState();
    fetchApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Wallpy",
            style: GoogleFonts.ptMono(
              fontWeight: FontWeight.bold,
              fontSize: 40,
              color: Colors.blue,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Container(
            padding: EdgeInsets.only(top: 10),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(40)),
            child: Image(
              image: AssetImage('images/wallpaper.png'),
              height: 30,
              width: 30,
              fit: BoxFit.cover,
            ),
          )
        ],
      )),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: GridView.builder(
                physics: AlwaysScrollableScrollPhysics(),
                itemCount: fetchedImages.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 2 / 3,
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      fullImageUrl = fetchedImages[index]['src']['original'];
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                FullImage(imageUrl: fullImageUrl.toString()),
                          ));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                            30,
                          )),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.network(
                          fetchedImages[index]['src']['large'],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Center(
            child: ElevatedButton(
                onPressed: () {
                  loadMore();
                },
                child: Text(
                  "Load More",
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
        ],
      ),
    );
  }
}
