import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_amplify/analytics_events.dart';
import 'package:flutter_amplify/analytics_service.dart';

//1
class GalleryPage extends StatelessWidget {
  final StreamController<List<String>> imagesUrlsController;
  //2
  final VoidCallback shouldLogOut;

  final VoidCallback shouldShowCamera;

  GalleryPage(
      {Key key,
      this.shouldLogOut,
      this.shouldShowCamera,
      this.imagesUrlsController})
      : super(key: key) {
    AnalyticsService.log(ViewGalleryEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gallery'),
        actions: [
          // 4
          // Log out button
          Padding(
            padding: const EdgeInsets.all(8),
            child: GestureDetector(
              child: Icon(Icons.logout),
              onTap: shouldLogOut,
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.camera_alt), onPressed: shouldShowCamera),
      body: Container(child: _galleryGrid()),
    );
  }

  Widget _galleryGrid() {
    return StreamBuilder(
      stream: imagesUrlsController.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.length != 0) {
            return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return CachedNetworkImage(
                    imageUrl: snapshot.data[index],
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                        alignment: Alignment.center,
                        child: CircularProgressIndicator()),
                  );
                });
          } else {
            return Center(child: Text('No Images to display'));
          }
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
