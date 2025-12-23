import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view_gallery.dart';

class kWidgetPhotoGalleryWidget extends StatefulWidget {
  final List<String> imageUrls;
  final int initialIndex;
  final ValueChanged<int>? onPageChanged;
  final bool showCloseButton;

  const kWidgetPhotoGalleryWidget({super.key, required this.imageUrls, this.initialIndex = 0, this.onPageChanged, this.showCloseButton = true});

  @override
  State<kWidgetPhotoGalleryWidget> createState() => _kWidgetPhotoGalleryWidgetState();
}

class _kWidgetPhotoGalleryWidgetState extends State<kWidgetPhotoGalleryWidget> {
  late final PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    // If list is empty, initial index is 0.
    final maxIndex = (widget.imageUrls.isNotEmpty) ? widget.imageUrls.length - 1 : 0;
    _currentIndex = widget.initialIndex.clamp(0, maxIndex);
    _pageController = PageController(initialPage: _currentIndex);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget _loadingBuilder(BuildContext context, ImageChunkEvent? event) {
    final progress = event == null || event.expectedTotalBytes == null ? null : event.cumulativeBytesLoaded / event.expectedTotalBytes!;
    return Center(
      child: SizedBox(width: 36, height: 36, child: CircularProgressIndicator(value: progress)),
    );
  }

  PhotoViewGalleryPageOptions _buildPageOption(String url, int index) {
    return PhotoViewGalleryPageOptions.customChild(
      child: CachedNetworkImage(
        imageUrl: url,
        fit: BoxFit.contain,
        placeholder: (c, s) => _loadingBuilder(c, null),
        errorWidget: (c, s, e) => const Center(child: Icon(Icons.broken_image, size: 64, color: Colors.white70)),
      ),
      // heroAttributes: PhotoViewHeroAttributes(tag: url + index.toString()),
      // initialScale: PhotoViewComputedScale.contained,
      // minScale: PhotoViewComputedScale.contained * 0.8,
      // maxScale: PhotoViewComputedScale.covered * 2.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    final urls = widget.imageUrls;

    // Handle empty list gracefully
    if (urls.isEmpty) {
      return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          leading: widget.showCloseButton
              ? IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: () => Navigator.of(context).maybePop(),
          )
              : null,
        ),
        body: const Center(
          child: Text('No images', style: TextStyle(color: Colors.white70, fontSize: 16)),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          PhotoViewGallery.builder(
            pageController: _pageController,
            itemCount: urls.length,
            builder: (context, index) => _buildPageOption(urls[index], index),
            backgroundDecoration: const BoxDecoration(color: Colors.black),
            scrollPhysics: const BouncingScrollPhysics(),
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
              widget.onPageChanged?.call(index);
            },
            loadingBuilder: (context, event) => _loadingBuilder(context, event),
          ),

          // Top bar: close/back and index (index hidden when only 1 image)
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (widget.showCloseButton)
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () => Navigator.of(context).maybePop(),
                    )
                  else
                    const SizedBox(width: 48),

                  // Show page indicator only when there are more than 1 images
                  if (urls.length > 1)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(color: Colors.black45, borderRadius: BorderRadius.circular(20)),
                      child: Text('${_currentIndex + 1} / ${urls.length}', style: const TextStyle(color: Colors.white)),
                    )
                  else
                    const SizedBox.shrink(),

                  // placeholder to balance the row
                  const SizedBox(width: 48),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}