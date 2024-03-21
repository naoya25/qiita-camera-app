import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // カメラの処理
  XFile? _image;
  final ImagePicker _picker = ImagePicker();

  // カメラから画像を指定する関数
  Future<void> _getImageFromCamera() async {
    final file = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (file != null) {
        _image = XFile(file.path);
      }
    });
  }

  // 写真フォルダから画像を指定する関数
  Future<void> _getImageFromGallery() async {
    final file = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (file != null) {
        _image = XFile(file.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: _image == null
            ? const Text("写真を撮ってね")
            : Image.file(File(_image!.path)),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
        FloatingActionButton(
          onPressed: _getImageFromCamera,
          child: const Icon(Icons.photo_camera),
        ),
        FloatingActionButton(
          onPressed: _getImageFromGallery,
          child: const Icon(Icons.photo_album),
        ),
      ]),
    );
  }
}
