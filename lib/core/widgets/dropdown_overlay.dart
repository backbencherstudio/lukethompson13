import 'package:flutter/material.dart';

class DropdownOverlay extends StatefulWidget {
  final Widget Function(BuildContext context, VoidCallback toggle) triggerBuilder;
  final Widget Function(BuildContext context, VoidCallback dismiss) popupBuilder;
  final Alignment targetAnchor;
  final Alignment followerAnchor;
  final Offset offset;

  const DropdownOverlay({
    super.key,
    required this.triggerBuilder,
    required this.popupBuilder,
    this.targetAnchor = Alignment.bottomCenter,
    this.followerAnchor = Alignment.topCenter,
    this.offset = Offset.zero,
  });

  @override
  State<DropdownOverlay> createState() => _DropdownOverlayState();
}

class _DropdownOverlayState extends State<DropdownOverlay> {
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();

  @override
  void dispose() {
    _removeOverlay();
    super.dispose();
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _toggle() {
    if (_overlayEntry != null) {
      _removeOverlay();
    } else {
      _overlayEntry = OverlayEntry(
        builder: (context) => Stack(
          children: [
            GestureDetector(
              onTap: _removeOverlay,
              child: Container(color: Colors.transparent),
            ),
            CompositedTransformFollower(
              link: _layerLink,
              targetAnchor: widget.targetAnchor,
              followerAnchor: widget.followerAnchor,
              offset: widget.offset,
              child: Material(
                color: Colors.transparent,
                child: widget.popupBuilder(context, _removeOverlay),
              ),
            ),
          ],
        ),
      );
      Overlay.of(context).insert(_overlayEntry!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: widget.triggerBuilder(context, _toggle),
    );
  }
}
