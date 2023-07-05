import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:live_emotion_detection/main.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:live_emotion_detection/record.dart';
import 'package:logger/logger.dart';

// ignore: must_be_immutable
class EmotionDetector extends StatefulWidget {
  bool isCamera;
  int videoNumber;

  EmotionDetector({Key? key, required this.videoNumber, required this.isCamera})
      : super(key: key);

  @override
  _HomeState createState() => _HomeState(isCamera, videoNumber);
}

class _HomeState extends State<EmotionDetector> {
  bool _isCamera = false;
  int _videoNumber = 0;
  var logger = Logger();
  bool front = true;
  _HomeState(this._isCamera, this._videoNumber);
  CameraImage? cameraImage;
  CameraController? cameraController;
  String output = '';
  double confidence = 0.0;
  Map<String, dynamic> recorder = {
    'Angry': 0.0,
    'Fear': 0.0,
    'Happy': 0.0,
    'Neutral': 0.0,
    'Sad': 0.0,
    'Surprised': 0.0
  };

  @override
  void initState() {
    super.initState();

    cameraController = CameraController(cameras![1], ResolutionPreset.high);
    loadCamera();
    loadmodel();
  }

  @override
  void dispose() {
    cameraController!.dispose();
    setRecord(recorder, widget.videoNumber);
    super.dispose();
  }

  loadCamera() {
    cameraController!.initialize().then((value) {
      if (!mounted) {
        return;
      } else {
        setState(() {
          cameraController!.startImageStream((imageStream) {
            cameraImage = imageStream;
            runModel();
          });
        });
      }
    });
  }

  runModel() async {
    if (cameraImage != null) {
      var predictions = await Tflite.runModelOnFrame(
          bytesList: cameraImage!.planes.map((plane) {
            return plane.bytes;
          }).toList(),
          imageHeight: cameraImage!.height,
          imageWidth: cameraImage!.width,
          imageMean: 127.5,
          imageStd: 127.5,
          rotation: 90,
          numResults: 2,
          threshold: 0.1,
          asynch: true);
      predictions!.forEach((element) {
        setState(() {
          output = element['label'];
          confidence = element['confidence'];

          logger.d(".........$output");
          logger.d("......................$confidence");

          if (!_isCamera) {
            recorder[output] = recorder[output] + confidence;
          }
        });
      });
    }
  }

  loadmodel() async {
    await Tflite.loadModel(
        model: "assets/model.tflite", labels: "assets/labels.txt");
  }

  @override
  Widget build(BuildContext context) {
    return _isCamera
        ? Scaffold(
            body: Stack(
              children: [
                Positioned.fill(child: _cameraPreview()),
                _displayEmotion(),
                _switchCameraButton(),
              ],
            ),
          )
        : Container();
  }

  Widget _displayEmotion() {
    // Assuming the model output is a map with the emotion and its confidence as keys
    String detectedEmotion = output;
    double percentage = confidence;

    return Positioned(
      bottom: 20,
      left: 20,
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          'Detected Emotion: $detectedEmotion\nConfidence: ${(percentage * 100).toStringAsFixed(2)}%',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }

  Widget _cameraPreview() {
    if (!cameraController!.value.isInitialized) {
      return Container();
    }
    return AspectRatio(
      aspectRatio: cameraController!.value.aspectRatio,
      child: CameraPreview(cameraController!),
    );
  }

  Widget _switchCameraButton() {
    IconData icon = _isCamera ? Icons.camera_rear : Icons.camera_front;
    return Positioned(
      top: 20,
      right: 20,
      child: FloatingActionButton(
        onPressed: () {
          _toggleCamera();
        },
        child: Icon(icon),
      ),
    );
  }

  void _toggleCamera() {
    setState(() {
      front = !front;
      cameraController!.dispose();
      if (front) {
        cameraController = CameraController(cameras![1], ResolutionPreset.high);
      } else {
        cameraController = CameraController(cameras![0], ResolutionPreset.high);
      }
      cameraController!.initialize().then((_) {
        cameraController!.startImageStream((imageStream) {
          cameraImage = imageStream;
          runModel();
        });
      });
    });
  }
}
