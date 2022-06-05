import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:random_password_generator/random_password_generator.dart';
import 'package:dio/dio.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

final nameGenerator = RandomPasswordGenerator();
final storage = FirebaseStorage.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;

class ViewImage extends StatefulWidget {
  static String route = '/view_image';
  const ViewImage({Key? key}) : super(key: key);

  @override
  State<ViewImage> createState() => _ViewImageState();
}

class _ViewImageState extends State<ViewImage> {
  String? currentUserKey;
  getCurrentUserKey() async {
    await SharedPreferences.getInstance().then((value) {
      setState(() {
        currentUserKey = value.getString('key');
      });
    });
  }

  //download img function (used two packages)
  //dio for downloading img
  //gallerysaver for saving the downloaded img in gallery
  Future downloadImg(String url) async {
    final tempDir = await getTemporaryDirectory();
    String imgName = nameGenerator.randomPassword(
        letters: true, numbers: true, uppercase: true, passwordLength: 12);
    final path = '${tempDir.path}/$imgName.jpg';
    await Dio().download(url, path);
    if (url.contains('.jpg') ||
        url.contains('.jpeg') ||
        url.contains('.jpe') ||
        url.contains('.jif') ||
        url.contains('.jfif') ||
        url.contains('.jfi') ||
        url.contains('.png')) {
      await GallerySaver.saveImage(path, toDcim: true).whenComplete(
        () => ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Downloaded'),
          ),
        ),
      );
    }
  }

  //delete img function
  Future deleteImg(List<dynamic> galleryItems, String url) async {
    try {
      galleryItems.remove(url);
      firestore.collection('keys').doc(currentUserKey).update({
        'imgUrls': FieldValue.arrayRemove([url])
      }).then(
        (value) => ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Deleted'),
          ),
        ),
      );
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUserKey();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    var galleryItems = args['imgUrls'];
    int currentImgIndex = args['index'];
    bool newlyDeleted = false;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          actions: [
            GestureDetector(
              onTap: () {
                downloadImg(galleryItems);
              },
              child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(Icons.download)),
            ),
            GestureDetector(
              onTap: () {
                deleteImg(galleryItems, galleryItems[currentImgIndex])
                    //after an img is deleted
                    //currentImgIndex-- manually
                    //to show the img next to it
                    //bcuz gallery builder does not update the index automatically
                    .whenComplete(() {
                  setState(() {
                    currentImgIndex--;
                    newlyDeleted = true;
                  });
                });
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Icon(Icons.delete),
              ),
            ),
          ],
        ),
        body: PhotoViewGallery.builder(
          pageController: PageController(initialPage: currentImgIndex),
          scrollPhysics: const BouncingScrollPhysics(),
          onPageChanged: (value) {
            setState(() {
              print(value);
              currentImgIndex = value;
            });
          },
          builder: (context, index) {
            //if img is newly deleted
            //assign manual index to gallery builder's index
            if (newlyDeleted) {
              index = currentImgIndex;
              newlyDeleted = false;
            } else {
              currentImgIndex = index;
            }
            return PhotoViewGalleryPageOptions(
              minScale: PhotoViewComputedScale.contained,
              maxScale: PhotoViewComputedScale.contained * 4,
              imageProvider: NetworkImage(galleryItems[index]),
              initialScale: PhotoViewComputedScale.contained * 0.8,
              heroAttributes:
                  PhotoViewHeroAttributes(tag: galleryItems[index].toString()),
            );
          },
          itemCount: galleryItems.length,
          loadingBuilder: (context, event) => Center(
            child: SizedBox(
              width: 20.0,
              height: 20.0,
              child: CircularProgressIndicator(
                value: event == null
                    ? 0
                    : event.cumulativeBytesLoaded /
                        event.expectedTotalBytes!.toInt(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
