import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

final ImagePicker _picker = ImagePicker();
final storage = FirebaseStorage.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;

class AddImageScreen extends StatefulWidget {
  static String route = '/add_image';
  const AddImageScreen({Key? key}) : super(key: key);

  @override
  State<AddImageScreen> createState() => _AddImageScreenState();
}

class _AddImageScreenState extends State<AddImageScreen> {
  List<File> _imageList = [];
  String? currentUserKey;
  bool uploading = false;
  double val = 0;

  final storageRef = storage.ref();

  chooseImage() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageList.add(File(pickedImage!.path));
    });
  }

  Future uploadImages() async {
    int i = 1;
    for (var img in _imageList) {
      //update circular progress indicator progress
      setState(() {
        val = i / _imageList.length;
      });
      //get current user key
      final prefs = await SharedPreferences.getInstance().then((value) {
        currentUserKey = value.getString('key');
      });

      var currentImagesUrls = [];
      var ref = storageRef.child("images/${img.path}");

      //upload image to firebase storage
      await ref.putFile(img).whenComplete(() async {
        //generate download url and update the urls array
        await ref.getDownloadURL().then((value) async {
          await firestore
              .collection('keys')
              .doc(currentUserKey)
              .get()
              .then((value) {
            if (value.data()!['imgUrls'] != null) {
              currentImagesUrls = value.data()!['imgUrls'];
            }
          });
          currentImagesUrls.add(value);

          //upload the updated urls array to firestore db
          firestore.collection('keys').doc(currentUserKey).update({
            'imgUrls': FieldValue.arrayUnion(currentImagesUrls),
          });
          i++;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            GestureDetector(
              onTap: () {
                setState(() {
                  uploading = true;
                });
                uploadImages().whenComplete(() => Navigator.pop(context));
              },
              child: const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text('Upload'),
              ),
            ),
          ],
        ),
        body: Stack(
          children: [
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 6,
                mainAxisSpacing: 6,
                crossAxisCount: 3,
              ),
              itemCount: _imageList.length + 1,
              itemBuilder: (context, index) {
                return index == 0
                    ? Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          color: const Color.fromARGB(255, 74, 74, 74),
                          child: Center(
                            child: IconButton(
                              icon: const Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                uploading ? null : chooseImage();
                              },
                            ),
                          ),
                        ),
                      )
                    : Container(
                        decoration: const BoxDecoration(
                          color: Colors.black,
                        ),
                        child: Image(
                          image: FileImage(
                            _imageList[index - 1],
                          ),
                          fit: BoxFit.cover,
                        ),
                      );
              },
            ),
            uploading
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Uploading...',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        CircularProgressIndicator(
                          value: val,
                          valueColor:
                              const AlwaysStoppedAnimation<Color>(Colors.purple),
                        )
                      ],
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
