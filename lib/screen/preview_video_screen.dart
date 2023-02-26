import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PerviewVideoScreen extends StatefulWidget {
  const PerviewVideoScreen({required this.videoPath, super.key});

  final File videoPath;

  @override
  State<PerviewVideoScreen> createState() => _PerviewVideoScreenState();
}

class _PerviewVideoScreenState extends State<PerviewVideoScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.videoPath.toString()))
      ..initialize().then((value) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[700],
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 2,
            child: _controller.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.15,
              child: Center(
                child: GestureDetector(
                  onTap: () {},
                  child: Column(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.touch_app,
                          color: Colors.white,
                        ),
                        onPressed: () {},
                      ),
                      const Text(
                        'Check breed',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
