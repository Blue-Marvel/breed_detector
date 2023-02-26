import 'dart:io';
import 'package:flutter/material.dart';

class PerviewScreen extends StatefulWidget {
  const PerviewScreen({required this.imgPath, super.key});

  final String imgPath;

  @override
  State<PerviewScreen> createState() => _PerviewScreenState();
}

class _PerviewScreenState extends State<PerviewScreen> {
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
            child: Image.file(
              File(widget.imgPath),
              fit: BoxFit.cover,
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
