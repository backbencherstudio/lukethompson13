import 'package:flutter/material.dart';

class TouchableOpacity extends StatefulWidget {
  const TouchableOpacity({
    super.key,
    required this.child,
    this.onPressed,
    this.isDisabled = false,
    this.pressedOpacity = 0.5,
    this.disabledOpacity = 0.5,
    this.duration = const Duration(milliseconds: 100),
    this.curve = Curves.easeOut,
    this.borderRadius,
  }) : assert(
         pressedOpacity >= 0 && pressedOpacity <= 1,
         'pressedOpacity must be between 0 and 1.',
       );

  final Widget child;
  final VoidCallback? onPressed;
  final bool isDisabled;

  /// The opacity when the widget is pressed.
  final double pressedOpacity;

  /// The opacity when the widget is disabled.
  final double disabledOpacity;

  final Duration duration;
  final Curve curve;

  /// Used for hit testing and splash clipping.
  final BorderRadius? borderRadius;

  @override
  State<TouchableOpacity> createState() => _TouchableOpacityState();
}

class _TouchableOpacityState extends State<TouchableOpacity> {
  bool _highlighted = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: widget.duration,
      curve: widget.curve,
      opacity: widget.isDisabled
          ? widget.disabledOpacity
          : _highlighted
          ? widget.pressedOpacity
          : 1,
      child: InkResponse(
        onTap: widget.isDisabled ? null : widget.onPressed,
        onHighlightChanged: (value) {
          if (_highlighted != value) {
            setState(() => _highlighted = value);
          }
        },

        // Disable Material splash/highlight.
        splashFactory: NoSplash.splashFactory,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        overlayColor: const WidgetStatePropertyAll(Colors.transparent),

        borderRadius: widget.borderRadius,
        child: widget.child,
      ),
    );
  }
}
