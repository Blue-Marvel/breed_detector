import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class photoButton extends StatelessWidget {
  const photoButton({
    required this.onCapture,
    super.key,
  });

  final onCapture;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onCapture,
      child: Container(
        height: MediaQuery.of(context).size.width * 0.19,
        width: MediaQuery.of(context).size.width * 0.14,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.transparent,
        ),
        child: Icon(
          Icons.camera,
          color: Colors.grey[900],
          size: MediaQuery.of(context).size.width * 0.12,
        ),
      ),
    );
  }
}

class VideoButton extends StatelessWidget {
  const VideoButton(
      {required this.recordVideo, required this.isRecording, super.key});

  final Function recordVideo;
  final bool isRecording;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: recordVideo(),
      child: Icon(
        isRecording ? Icons.stop : Icons.play_arrow,
        color: Colors.grey[900],
        size: MediaQuery.of(context).size.width * 0.12,
      ),
    );
  }
}
