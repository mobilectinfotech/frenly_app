import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'dart:io';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;
  const VideoPlayerWidget({super.key, required this.videoUrl});

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  bool _isVideoPlaying = false;
  bool _isVideoDownloaded = true;
  late String _localVideoPath;
  late Dio dio;
  bool _showOverlay = false; // T

  @override
  void initState() {
    super.initState();
    dio = Dio(); // Dio instance
    _checkAndDownloadVideo();
    // VideoManager.getSavedVideoUrls();
  }

  Future<void> _checkAndDownloadVideo() async {
    final directory = await getApplicationDocumentsDirectory();
    final videoFileName = widget.videoUrl.split('/').last;
    _localVideoPath = '${directory.path}/$videoFileName';

    if (File(_localVideoPath).existsSync()) {
      // Video already downloaded
      setState(() {
        _isVideoDownloaded = true;
      });
      _initializeVideoPlayer(File(_localVideoPath));
    } else {
      // Start downloading the video
      await _downloadVideo();
    }
  }
  Future<void> _downloadVideo() async {
    try {
      // Start downloading video in chunks
      final response = await dio.get(
        widget.videoUrl,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            print("Download progress: ${(received / total * 100).toStringAsFixed(0)}%");
            // Start playing the video once 10% is downloaded
            if (received / total >= 0.1 && !_isVideoPlaying) {
              _initializeVideoPlayer(File(_localVideoPath));
              setState(() {
                _isVideoPlaying = true;
              });
            }
          }
        },
        options: Options(
          responseType: ResponseType.stream,
        ),
      );

      final file = File(_localVideoPath);
      final raf = file.openSync(mode: FileMode.write);

      int downloaded = 0;
      final contentLength = response.headers.value(Headers.contentLengthHeader);

      if (contentLength != null) {
        final totalLength = int.parse(contentLength);

        response.data.stream.listen(
              (List<int> chunk) {
            downloaded += chunk.length;
            raf.writeFromSync(chunk);
            print("Download progress: ${(downloaded / totalLength * 100).toStringAsFixed(0)}%");

            // Update the UI if video is fully downloaded
            setState(() {
              if (downloaded == totalLength) {
                _isVideoDownloaded = true;
              }
            });
          },
          onDone: () {
            raf.closeSync();
            print("Download complete!");
            // After download complete, initialize the player again
            if (!_isVideoPlaying) {
              _initializeVideoPlayer(file);
            }
          },
          onError: (e) {
            print("Download error: $e");
          },
          cancelOnError: true,
        );
      } else {
        print("Error: Couldn't get content length");
      }
    } catch (e) {
      print("Error downloading video: $e");
    }
  }
  double? _aspectRatio;
  void _initializeVideoPlayer(File file) {
    _videoPlayerController = VideoPlayerController.file(file)
      ..initialize().then((_) {
        setState(() {
          _aspectRatio = _videoPlayerController.value.aspectRatio;

          _chewieController = ChewieController(
              videoPlayerController: _videoPlayerController,
              autoPlay: true,
              draggableProgressBar: true,
              placeholder: Container(color: Colors.black,),
              looping: false,
              allowFullScreen: true,
              customControls: _CustomControls());
        });
      });
  }

  void _togglePlayPause() {
    if (_videoPlayerController.value.isPlaying) {
      _videoPlayerController.pause();
      _showOverlay =true;
    } else {
      _videoPlayerController.play();
      _showOverlay =false;
    }
    setState(() {

    });

  }


  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return _chewieController != null &&
        _chewieController!.videoPlayerController.value.isInitialized
        ? Column(
      children: [
        GestureDetector(
          onTap: _togglePlayPause,
          child: Stack(
            alignment: Alignment.center,
            children: [
              AspectRatio(
               aspectRatio: _aspectRatio! > 1 ? _aspectRatio! : (_aspectRatio!*1.4),
                child: Chewie(
                  controller: _chewieController!,
                ),
              ),
              if (_showOverlay) // Show overlay icon when the state changes
                Icon(
                   Icons.play_circle_fill_outlined,
                  size: 80,
                  color: Colors.white.withOpacity(0.8),
                ),
            ],
          ),
        ),

      ],
    )
        :  AspectRatio(
      aspectRatio: 16/9,
      child:   SizedBox(
        height: 30,
        width: 30,
        child: LinearProgressIndicator(
          color: Colors.grey.shade200,
          backgroundColor: Colors.grey.shade100,
        ),
      ),
    );
  }
}


class _CustomControls extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final chewieController = ChewieController.of(context);
    final videoController = chewieController.videoPlayerController;

    return Container(
      // color: Colors.black.withOpacity(.50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Seek bar
          Align(
            alignment: Alignment.bottomRight,
            child: IconButton(
              icon: Icon(
                chewieController.isFullScreen ? Icons.fullscreen_exit
                    : Icons.fullscreen,
                color: Colors.grey,
              ),
              onPressed: () {
                chewieController.toggleFullScreen();
              },
            ),
          ),
          VideoProgressIndicator(
            videoController,
            allowScrubbing: true,
            colors: const VideoProgressColors(
              playedColor: Colors.blue,
              bufferedColor: Colors.grey,
              backgroundColor: Colors.black38,
            ),
          ),
          // Full-screen button
        ],
      ),
    );
  }
}


class VideoManager {
  // Function to get all saved video URLs (paths)
  static Future<List<String>> getSavedVideoUrls() async {
    try {
      final directory = await getApplicationDocumentsDirectory();

      // Get all files from the directory that end with ".mp4"
      final videoFiles = directory.listSync().where((file) => file.path.endsWith('.mp4')).toList();

      // Extract the paths (URLs) of the saved video files
      List<String> videoUrls = videoFiles.map((file) => file.path).toList();
      print("videos_length=>${videoUrls.length}");
      print("videos_url=>${videoUrls.toString()}");

      return videoUrls; // Return the list of video URLs
    } catch (e) {
      print("Error fetching saved video URLs: $e");
      return []; // Return an empty list in case of error
    }
  }
}
