import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  static String route = '/main_screen';
  MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> _items = [
      'https://developers.google.com/learn/images/flutter/flutter_logo.jpg',
      'https://instabug.com/blog/wp-content/uploads/2020/02/AppDev_Flutter-Apps.png',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRDpZEHqlu02DE3jsEA9VtJn3xbVsPTPdCSXA&usqp=CAU',
      'https://miro.medium.com/max/1000/1*ilC2Aqp5sZd1wi0CopD1Hw.png',
      'https://9to5google.com/wp-content/uploads/sites/4/2022/02/flutter-windows-promo.jpg?quality=82&strip=all&w=1600',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRfH8xyGMmerGW1yTxqdPctrk_3I4_iKzF7hQ&usqp=CAU',
      'https://developers.google.com/learn/images/flutter/flutter_logo.jpg',
      'https://instabug.com/blog/wp-content/uploads/2020/02/AppDev_Flutter-Apps.png',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRDpZEHqlu02DE3jsEA9VtJn3xbVsPTPdCSXA&usqp=CAU',
      'https://miro.medium.com/max/1000/1*ilC2Aqp5sZd1wi0CopD1Hw.png',
      'https://9to5google.com/wp-content/uploads/sites/4/2022/02/flutter-windows-promo.jpg?quality=82&strip=all&w=1600',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRfH8xyGMmerGW1yTxqdPctrk_3I4_iKzF7hQ&usqp=CAU',
      'https://developers.google.com/learn/images/flutter/flutter_logo.jpg',
      'https://instabug.com/blog/wp-content/uploads/2020/02/AppDev_Flutter-Apps.png',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRDpZEHqlu02DE3jsEA9VtJn3xbVsPTPdCSXA&usqp=CAU',
      'https://miro.medium.com/max/1000/1*ilC2Aqp5sZd1wi0CopD1Hw.png',
      'https://9to5google.com/wp-content/uploads/sites/4/2022/02/flutter-windows-promo.jpg?quality=82&strip=all&w=1600',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRfH8xyGMmerGW1yTxqdPctrk_3I4_iKzF7hQ&usqp=CAU',
      'https://developers.google.com/learn/images/flutter/flutter_logo.jpg',
      'https://instabug.com/blog/wp-content/uploads/2020/02/AppDev_Flutter-Apps.png',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRDpZEHqlu02DE3jsEA9VtJn3xbVsPTPdCSXA&usqp=CAU',
      'https://miro.medium.com/max/1000/1*ilC2Aqp5sZd1wi0CopD1Hw.png',
      'https://9to5google.com/wp-content/uploads/sites/4/2022/02/flutter-windows-promo.jpg?quality=82&strip=all&w=1600',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRfH8xyGMmerGW1yTxqdPctrk_3I4_iKzF7hQ&usqp=CAU',
    ];
    return SafeArea(
      child: Scaffold(
        floatingActionButton: const FloatingActionButton(
          onPressed: null,
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        appBar: AppBar(
          title: const Text('My Photos'),
          centerTitle: true,
        ),
        body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 3,
            mainAxisSpacing: 3,
            crossAxisCount: 3,
          ),
          itemCount: _items.length,
          itemBuilder: (context, index) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.black,
              ),
              child: Image(image: NetworkImage(_items[index])),
            );
          },
        ),
      ),
    );
  }
}
