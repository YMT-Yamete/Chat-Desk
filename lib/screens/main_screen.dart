import 'package:chat_desk/screens/add_image_screen.dart';
import 'package:chat_desk/screens/view_image_screen.dart';
import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

final storage = FirebaseStorage.instance;
FirebaseAuth auth = FirebaseAuth.instance;

class MainScreen extends StatefulWidget {
  static String route = '/main_screen';
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String? currentUserKey;
  getCurrentUserKey() async {
    await SharedPreferences.getInstance().then((value) {
      setState(() {
        currentUserKey = value.getString('key');
      });
      // ignore: avoid_print
      print(currentUserKey);
    });
  }

  Future<void> _signOut() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('key');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Logged Out"),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getCurrentUserKey();
  }

  @override
  Widget build(BuildContext context) {
    var keysStream = FirebaseFirestore.instance
        .collection('keys')
        .doc(currentUserKey)
        .snapshots();
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, AddImageScreen.route);
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        appBar: AppBar(
          title: const Text('My Photos'),
          centerTitle: true,
          automaticallyImplyLeading: false,
          actions: [
            GestureDetector(
              onTap: () {
                _signOut().whenComplete(() => Navigator.pop(context));
              },
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Icon(Icons.logout),
              ),
            ),
          ],
        ),
        body: StreamBuilder<DocumentSnapshot>(
          stream: keysStream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final currentUserData = snapshot.data;
            int imgCount = 0;
            try {
              imgCount = currentUserData!['imgUrls'].length;
            } catch (e) {
              imgCount = 0;
            }
            return imgCount == 0
                ? Container()
                : Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 6,
                        mainAxisSpacing: 6,
                        crossAxisCount: 3,
                      ),
                      itemCount: imgCount,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: const BoxDecoration(
                            color: Colors.black,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              // ignore: avoid_print
                              print('tapped');
                            },
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, ViewImage.route,
                                    arguments: {
                                      'imgUrls': currentUserData!['imgUrls'],
                                      'index': index,
                                    });
                              },
                              child: Hero(
                                tag: currentUserData!['imgUrls'][index]
                                    .toString(),
                                child: Image(
                                  image: NetworkImage(
                                      currentUserData['imgUrls'][index]),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
          },
        ),
      ),
    );
  }
}
