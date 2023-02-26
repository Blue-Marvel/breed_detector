// import 'package:breed_detector/screen/camera_screen.dart';
import 'package:breed_detector/screen/welcome_screen.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  runApp(MyApp(
    camera: cameras,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({required this.camera, super.key});

  final List<CameraDescription> camera;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Breed detector',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(camera: camera),
    );
  }
}
