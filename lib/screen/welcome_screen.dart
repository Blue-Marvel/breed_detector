import 'package:breed_detector/screen/camera_screen.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final camera;
  const HomePage({required this.camera, super.key});

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width;
    double maxHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.brown[700],
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 1,
                child: Container(),
              ),
              // Center(
              //   child: Text(
              //     'Welcome',
              //     style: TextStyle(
              //       fontWeight: FontWeight.bold,
              //       fontSize: maxWidth * 0.1,
              //       fontStyle: FontStyle.italic,
              //       color: Colors.white,
              //     ),
              //   ),
              // ),
              SizedBox(
                height: maxHeight * 0.1,
              ),
              Container(
                width: maxHeight * 0.4,
                height: maxHeight * 0.4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(maxHeight * 0.04),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(maxHeight * 0.04),
                  child: const Image(
                    image: AssetImage('assets/dogs.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: maxHeight * 0.02,
              ),
              Center(
                child: Text(
                  'Dog breed detector',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: maxWidth * 0.05,
                    // fontStyle: FontStyle.italic,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: maxHeight * 0.1,
              ),
              InkWell(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CameraScreen(camera: camera),
                  ),
                ),
                child: Container(
                  width: maxWidth * 0.7,
                  height: maxHeight * 0.1,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(maxHeight * 0.02),
                    color: Colors.grey[900],
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Take photo or video',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: maxWidth * 0.05,
                        // fontStyle: FontStyle.italic,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Container(),
              ),
            ],
          ),
        ));
  }
}
