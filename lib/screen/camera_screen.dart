// ignore_for_file: must_be_immutable
// ignore: avoid_web_libraries_in_flutter
import 'package:breed_detector/screen/preview__photo_screen.dart';
import 'package:breed_detector/screen/preview_video_screen.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraScreen extends StatefulWidget {
  final List<CameraDescription> camera;
  const CameraScreen({required this.camera, super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  int selectCamera = 0;
  bool isRecording = false;
  late final videoPath;

  initializeCamera(int cameraIndex) async {
    _controller = CameraController(
      widget.camera[cameraIndex],
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void initState() {
    initializeCamera(selectCamera);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _switchCamera() {
    if (widget.camera.length > 1) {
      setState(() {
        selectCamera = selectCamera == 0 ? 1 : 0;
        initializeCamera(selectCamera);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No secondary camera found'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  _onCapture() async {
    try {
      await _initializeControllerFuture;
      final imgPath = await _controller.takePicture();
      await _controller.takePicture().then((value) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PerviewScreen(
              imgPath: imgPath.path,
            ),
          ),
        );
      });
    } catch (err) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$err'),
        ),
      );
    }
  }

  void _startRecording() async {
    // ignore: await_only_futures
    await _controller.startVideoRecording();
    setState(() {
      isRecording = true;
    });
  }

  void _stopRecording() async {
    setState(() {
      isRecording = false;
    });
    // ignore: use_build_context_synchronously
    await _controller.stopVideoRecording().then(
          (value) => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => PerviewVideoScreen(videoPath: videoPath),
            ),
          ),
        );
  }

  late Widget cameraState;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: FutureBuilder(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: CameraPreview(
                        _controller,
                      ));
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
          // const Spacer(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.2,
              width: double.infinity,
              padding:
                  EdgeInsets.all(MediaQuery.of(context).size.height * 0.04),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  //SwitchCamera Button
                  GestureDetector(
                    onTap: _switchCamera,
                    child: Container(
                      height: MediaQuery.of(context).size.width * 0.19,
                      width: MediaQuery.of(context).size.width * 0.14,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.transparent,
                      ),
                      child: Icon(
                        Icons.flip_camera_ios_outlined,
                        color: Colors.grey[900],
                        size: MediaQuery.of(context).size.width * 0.1,
                      ),
                    ),
                  ),
                  //Capture Button
                  GestureDetector(
                    onLongPress: _startRecording,
                    onLongPressUp: _stopRecording,
                    onTap: (() {
                      if (!isRecording) {
                        _onCapture();
                      }
                    }),
                    child: Container(
                      height: MediaQuery.of(context).size.width * 0.19,
                      width: MediaQuery.of(context).size.width * 0.14,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.transparent,
                      ),
                      child: isRecording
                          ? Icon(
                              Icons.radio_button_on,
                              color: Colors.red,
                              size: MediaQuery.of(context).size.width * 0.12,
                            )
                          : Icon(
                              Icons.radio_button_off,
                              color: Colors.white,
                              size: MediaQuery.of(context).size.width * 0.12,
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
