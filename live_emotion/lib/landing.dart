import 'package:flutter/material.dart';
import 'package:live_emotion_detection/main.dart';
import 'package:live_emotion_detection/video_list.dart';

import 'emotion_detection.dart';

void main() {
  runApp(const MyApp());
}

class Landing extends StatelessWidget {
  const Landing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Live Emotion Detection App 🐇'),
          backgroundColor: Colors.purple,
        ),
        body: Container(
          padding: const EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 5.0),
          child: SafeArea(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // ClipRRect(
                  //   borderRadius: BorderRadius.circular(8.0),
                  //   child: Image.asset(
                  //     'assets/hehe.gif',
                  //     height: 100.0,
                  //     width: 120.0,
                  //   ),
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/hehe.gif',
                        width: 100,
                        height: 120,
                      )
                    ],
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Emotion Detection',
                        style: TextStyle(
                            fontSize: 25.0, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5.0),
                  const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Fake Feedback Recognisation',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ]),
                  const SizedBox(height: 30.0),
                  const Row(
                    children: [
                      Text(
                        'Choose from the following options -',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                      height: 15.0,
                      width: MediaQuery.of(context).size.width * 0.8),
                  Row(children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Stack(
                        children: <Widget>[
                          Positioned.fill(
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.7,
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: <Color>[
                                    // Color(0xFFffa500),
                                    Color.fromARGB(255, 135, 17, 178),
                                    Color.fromARGB(255, 139, 45, 220),
                                    Color.fromARGB(255, 178, 110, 250),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.all(20),
                                textStyle: const TextStyle(fontSize: 20),
                                fixedSize: Size(
                                    MediaQuery.of(context).size.width * 0.8,
                                    MediaQuery.of(context).size.height * 0.2)),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EmotionDetector(
                                          isCamera: true,
                                          videoNumber: 0,
                                        )),
                              );
                            },
                            child: const Text(
                                '               Live From Camera               '),
                          ),
                        ],
                      ),
                    ),
                  ]),
                  SizedBox(
                      height: 15.0,
                      width: MediaQuery.of(context).size.width * 0.8),
                  Row(children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Stack(
                        children: <Widget>[
                          Positioned.fill(
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.7,
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: <Color>[
                                    // Color(0xFFcb7600),
                                    // Color(0xFFf18c00),
                                    // Color(0xFFffa500),
                                    Color.fromARGB(255, 135, 17, 178),
                                    Color.fromARGB(255, 139, 45, 220),
                                    Color.fromARGB(255, 178, 110, 250),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.all(20),
                                textStyle: const TextStyle(fontSize: 20),
                                fixedSize: Size(
                                    MediaQuery.of(context).size.width * 0.8,
                                    MediaQuery.of(context).size.height * 0.2)),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const VideosList()),
                              );
                            },
                            child: const Text(
                                ' Emotion Detect During Video play '),
                          ),
                        ],
                      ),
                    ),
                  ]),
                  const SizedBox(height: 15.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [Text('Made With Tflite')],
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: const [
                  //     Text('Submitted by Eklavya Prasad & Bushra Khan')
                  //   ],
                  // )
                ]),
          ),
        ));
  }
}
