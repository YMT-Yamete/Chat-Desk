import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

final ImagePicker _picker = ImagePicker();
final storage = FirebaseStorage.instance;

class AddImageScreen extends StatefulWidget {
  static String route = '/add_image';
  const AddImageScreen({Key? key}) : super(key: key);

  @override
  State<AddImageScreen> createState() => _AddImageScreenState();
}

class _AddImageScreenState extends State<AddImageScreen> {
  List<File> _imageList = [];
  final storageRef = storage.ref();

  chooseImage() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageList.add(File(pickedImage!.path));
    });
  }

  Future uploadImages() async {
    for (var img in _imageList) {
      var ref = storageRef.child("images/${img.path}");
      await ref.putFile(img);
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
                uploadImages().whenComplete(() => Navigator.pop(context));
              },
              child: const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text('Upload'),
              ),
            ),
          ],
        ),
        body: GridView.builder(
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
                          icon: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            chooseImage();
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
      ),
    );
  }
}
