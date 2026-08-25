import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/data/sources/remote/stoplog/models/stop_log_attachment.model.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class AttachmentImageViewer extends StatefulWidget {
  final List<ImageProvider<Object>> imageProviders;
  final int initialIndex;

  const AttachmentImageViewer({
    super.key,
    required this.imageProviders,
    this.initialIndex = 0,
  });

  static void show(
    BuildContext context, {
    required List<StopLogAttachment> attachments,
    required int index,
  }) {
    if (index < 0 || index >= attachments.length) return;

    final tapped = attachments[index];
    final url = tapped.fileUrl?.trim() ?? '';
    final mimeType = tapped.mimeType?.toLowerCase() ?? '';
    final isSvg =
        url.toLowerCase().endsWith('.svg') || mimeType == 'image/svg+xml';

    if (url.isEmpty || !mimeType.startsWith('image/') || isSvg) return;

    final imageAttachments = attachments
        .where(
          (a) =>
              (a.fileUrl?.trim().isNotEmpty ?? false) &&
              (a.mimeType?.toLowerCase().startsWith('image/') ?? false) &&
              !(a.mimeType!.toLowerCase() == 'image/svg+xml' ||
                  (a.fileUrl!.toLowerCase().endsWith('.svg'))),
        )
        .toList();

    if (imageAttachments.isEmpty) return;

    final imageProviders = imageAttachments
        .map((a) => CachedNetworkImageProvider(a.fileUrl!.trim()))
        .toList();

    final initialIndex = imageAttachments.indexOf(tapped);

    Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => AttachmentImageViewer(
          imageProviders: imageProviders,
          initialIndex: initialIndex,
        ),
      ),
    );
  }

  static void showFiles(
    BuildContext context, {
    required List<XFile> files,
    required int index,
  }) {
    if (index < 0 || index >= files.length) return;

    final imageProviders = files
        .map((f) => FileImage(File(f.path)) as ImageProvider<Object>)
        .toList();

    Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => AttachmentImageViewer(
          imageProviders: imageProviders,
          initialIndex: index,
        ),
      ),
    );
  }

  @override
  State<AttachmentImageViewer> createState() => _AttachmentImageViewerState();
}

class _AttachmentImageViewerState extends State<AttachmentImageViewer> {
  late int _currentIndex;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex.clamp(0, widget.imageProviders.length - 1);
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          PhotoViewGallery.builder(
            itemCount: widget.imageProviders.length,
            pageController: _pageController,
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
            },
            builder: (context, index) {
              return PhotoViewGalleryPageOptions(
                imageProvider: widget.imageProviders[index],
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.covered * 4,
                initialScale: PhotoViewComputedScale.contained,
              );
            },
            loadingBuilder: (context, event) => const Center(
              child: CircularProgressIndicator(color: ColorManager.primaryButton),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 8,
            left: 8,
            child: _CloseButton(
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          if (widget.imageProviders.length > 1)
            Positioned(
              bottom: 24,
              left: 0,
              right: 0,
              child: Text(
                '${_currentIndex + 1} / ${widget.imageProviders.length}',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
        ],
      ),
    );
  }
}

class _CloseButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _CloseButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withValues(alpha: 0.5),
      shape: const CircleBorder(),
      child: IconButton(
        onPressed: onPressed,
        icon: const Icon(Icons.close, color: Colors.white),
      ),
    );
  }
}
