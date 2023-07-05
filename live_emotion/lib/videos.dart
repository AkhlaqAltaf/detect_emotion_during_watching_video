import 'package:flutter/material.dart';
import 'package:live_emotion_detection/emotion_detection.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String video;
  final int videoNumber;

  VideoPlayerWidget(this.video, this.videoNumber);

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController controller;
  late Future<void> initializer;
  bool _isPlaying = true;
  bool _feedback = false;
  String? selectedEmotion;

  @override
  void initState() {
    super.initState();

    controller = VideoPlayerController.asset(widget.video);
    initializer = controller.initialize().then((_) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  void selectEmotion(String emotion) {
    setState(() {
      selectedEmotion = emotion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          EmotionDetector(videoNumber: widget.videoNumber, isCamera: false),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.purple,
            child: FutureBuilder(
              future: initializer,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (_isPlaying) {
                    controller.play();
                  } else {
                    controller.pause();
                  }
                  return AspectRatio(
                    aspectRatio: controller.value.aspectRatio,
                    child: VideoPlayer(controller),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              title: Text("Video"),
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
          ),
          Positioned(
            bottom: 29,
            left: 5,
            child: Visibility(
              visible: true,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _isPlaying = !_isPlaying;
                    if (_isPlaying) {
                      controller.play();
                    } else {
                      controller.pause();
                    }
                  });
                },
                child: Icon(
                  _isPlaying ? Icons.pause : Icons.play_arrow,
                  size: 33,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 25,
            left: 40,
            child: Container(
              child: IconButton(
                onPressed: () {
                  setState(() {
                    _feedback = !_feedback;
                  });
                },
                icon: Icon(Icons.feedback, color: Colors.white, size: 27),
              ),
            ),
          ),
          Positioned(
            bottom: 5,
            left: 10,
            child: _feedback
                ? Row(
                    children: [
                      FeedbackButton(
                        emotion: 'Happy',
                        icon: Icons.sentiment_satisfied,
                        isSelected: selectedEmotion == 'Happy',
                        onTap: selectEmotion,
                      ),
                      FeedbackButton(
                        emotion: 'Sad',
                        icon: Icons.sentiment_dissatisfied,
                        isSelected: selectedEmotion == 'Sad',
                        onTap: selectEmotion,
                      ),
                      FeedbackButton(
                        emotion: 'Angry',
                        icon: Icons.sentiment_very_dissatisfied,
                        isSelected: selectedEmotion == 'Angry',
                        onTap: selectEmotion,
                      ),
                      FeedbackButton(
                        emotion: 'Surprised',
                        icon: Icons.sentiment_neutral,
                        isSelected: selectedEmotion == 'Surprised',
                        onTap: selectEmotion,
                      ),
                      FeedbackButton(
                        emotion: 'Fear',
                        icon: Icons.sentiment_very_satisfied,
                        isSelected: selectedEmotion == 'Fear',
                        onTap: selectEmotion,
                      ),
                      FeedbackButton(
                        emotion: 'Neutral',
                        icon: Icons.sentiment_satisfied_alt,
                        isSelected: selectedEmotion == 'Neutral',
                        onTap: selectEmotion,
                      ),
                    ],
                  )
                : SizedBox(),
          ),
        ],
      ),
    );
  }
}

class FeedbackButton extends StatelessWidget {
  final String emotion;
  final IconData icon;
  final bool isSelected;
  final Function(String) onTap;

  const FeedbackButton({
    required this.emotion,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => onTap(emotion),
      icon: Icon(
        icon,
        color: isSelected ? Colors.purple : Colors.white,
      ),
    );
  }
}
