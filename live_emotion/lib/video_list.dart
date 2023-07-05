import 'package:flutter/material.dart';
import 'package:live_emotion_detection/record.dart';
import 'package:live_emotion_detection/videos.dart';

class VideosList extends StatefulWidget {
  const VideosList({super.key});

  @override
  State<VideosList> createState() => _VideosListState();
}

class _VideosListState extends State<VideosList> {
  var videos = [
    'assets/videos/Video1.mp4',
    'assets/videos/Video2.mp4',
    'assets/videos/Video3.mp4',
    // 'assets/videos/Video4.mp4',
    // 'assets/videos/Video5.mp4',
    // 'assets/videos/Video6.mp4',
    // 'assets/videos/Video7.mp4',
    // 'assets/videos/Video8.mp4',
    // 'assets/videos/Video9.mp4',
    // 'assets/videos/Video10.mp4',
    // 'assets/videos/Video11.mp4',
    // 'assets/videos/Video12.mp4',
    // 'assets/videos/Video13.mp4',
    // 'assets/videos/Video14.mp4',
    // 'assets/videos/Video15.mp4',
    // 'assets/videos/Video16.mp4',
    // 'assets/videos/Video17.mp4',
    // 'assets/videos/Video18.mp4',
    // 'assets/videos/Video19.mp4',
    // 'assets/videos/Video20.mp4',
    // 'assets/videos/Video21.mp4',
    // 'assets/videos/Video22.mp4',
    // 'assets/videos/Video23.mp4',
    // 'assets/videos/Video24.mp4',
  ];

  Map<String, dynamic>? getHighest(int video_number) {
    List<Map<String, dynamic>> filteredRecords = record
        .where((record) => record['video_number'] == video_number)
        .toList();

    if (filteredRecords.isNotEmpty) {
      Map<String, dynamic> emotions = filteredRecords.first['emotions'];
      if (emotions.isNotEmpty) {
        String highestKey = '';
        double highestValue = double.negativeInfinity;

        emotions.forEach((key, value) {
          if (value > highestValue) {
            highestValue = value;
            highestKey = key;
          }
        });

        if (highestKey.isNotEmpty) {
          logger.d("Record is Found At $highestKey");
          return {'emotion': highestKey, 'confidence': highestValue};
        }
      }
    }
    logger.d("Record Not found  at video ${video_number}");

    return null;
  }

  var highestOne;

  @override
  void initState() {
    highestOne = getHighest(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("List Of Videos"),
          backgroundColor: Colors.purple,
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(color: Colors.white),
          child: ListView.builder(
            itemCount: videos.length,
            itemBuilder: (context, index) => video(videos[index], index),
          ),
        ));
  }

  Widget video(var video, int index) {
    highestOne = getHighest(index + 1);
    String? detectedEmotion = highestOne != null ? highestOne['emotion'] : null;
    double? confidence = highestOne != null ? highestOne['confidence'] : null;

    return Container(
      child: Row(children: [
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
                  fixedSize: Size(MediaQuery.of(context).size.width,
                      MediaQuery.of(context).size.height * 0.2),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VideoPlayerWidget(video, index + 1),
                    ),
                  );
                },
                child: Text('Video number ${index + 1}'),
              ),
              Positioned(
                bottom: 20,
                right: 20,
                child: Text(
                  "Emotion Detected: ${detectedEmotion ?? 'N/A'}\nConfidence: ${(confidence ?? 0.0) * 100}",
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
