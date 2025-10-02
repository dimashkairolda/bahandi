// Automatic FlutterFlow imports
// Imports other custom widgets
// Imports custom actions
// Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';

class Base64Media extends StatefulWidget {
  final double width;
  final double height;
  final String base64Data; // строка data:<mime>;base64,...

  const Base64Media({
    super.key,
    required this.width,
    required this.height,
    required this.base64Data,
  });

  @override
  _Base64MediaState createState() => _Base64MediaState();
}

class _Base64MediaState extends State<Base64Media> {
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();
    _initVideoIfNeeded();
  }

  Future<void> _initVideoIfNeeded() async {
    if (widget.base64Data.startsWith("data:video")) {
      final base64Str = widget.base64Data.split(',').last;
      final bytes = base64Decode(base64Str);

      // сохраняем во временный файл
      final dir = await getTemporaryDirectory();
      final file = File("${dir.path}/temp_video.mp4");
      await file.writeAsBytes(bytes);

      _controller = VideoPlayerController.file(file)
        ..initialize().then((_) {
          setState(() {});
          _controller?.play();
        });
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.base64Data.startsWith("data:image")) {
      final base64Str = widget.base64Data.split(',').last;
      final decodedBytes = base64Decode(base64Str);
      return Image.memory(
        decodedBytes,
        width: widget.width,
        height: widget.height,
        fit: BoxFit.contain,
      );
    } else if (widget.base64Data.startsWith("data:video")) {
      if (_controller != null && _controller!.value.isInitialized) {
        return SizedBox(
          width: widget.width,
          height: widget.height,
          child: AspectRatio(
            aspectRatio: _controller!.value.aspectRatio,
            child: VideoPlayer(_controller!),
          ),
        );
      } else {
        return SizedBox(
          width: widget.width,
          height: widget.height,
          child: const Center(child: CircularProgressIndicator()),
        );
      }
    } else {
      return SizedBox(
        width: widget.width,
        height: widget.height,
        child: const Center(child: Text("Unsupported media type")),
      );
    }
  }
}
