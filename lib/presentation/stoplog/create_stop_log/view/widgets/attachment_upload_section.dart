import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lukethompson/core/extensions/snackbar_extension.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/core/widgets/global_button.dart';

class AttachmentUploadSection extends StatefulWidget {
  const AttachmentUploadSection({
    super.key,
    this.onAttachmentPicked,
    this.disabled = false,
  });

  final void Function(XFile file)? onAttachmentPicked;
  final bool disabled;

  @override
  State<AttachmentUploadSection> createState() =>
      _AttachmentUploadSectionState();
}

class _AttachmentUploadSectionState extends State<AttachmentUploadSection> {
  final ImagePicker _picker = ImagePicker();
  final List<XFile> _attachments = [];

  Future<void> _pickImage(ImageSource source) async {
    if (widget.disabled) return;
    final isAvailable = _picker.supportsImageSource(source);
    if (!isAvailable) {
      if (mounted) {
        context.showErrorSnackBar(
          source == ImageSource.camera
              ? 'Unable to access the camera. Please check your camera permissions or try again.'
              : 'Unable to select an image. Please try again.',
        );
      }
      return;
    }
    final XFile? image = await _picker.pickImage(source: source);
    if (!mounted) return;

    if (image == null) {
      context.showInfoSnackBar(
        source == ImageSource.camera
            ? 'No photo was taken.'
            : 'No image was selected.',
      );
      return;
    }

    setState(() => _attachments.add(image));
    widget.onAttachmentPicked?.call(image);
  }

  @override
  Widget build(BuildContext context) {
    final alpha = widget.disabled ? 0.4 : 1.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text("Attachments", style: context.labelLarge),
        // SizedBox(height: 12.h),
        DottedBorder(
          color: ColorManager.subtextColor.withValues(
            alpha: widget.disabled ? 0.2 : 0.5,
          ),
          strokeWidth: 1.5,
          dashPattern: const [6, 4],
          borderType: BorderType.RRect,
          radius: Radius.circular(15.r),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 20.h),
            decoration: BoxDecoration(
              color: const Color(0xFF111821).withValues(alpha: alpha),
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: Column(
              children: [
                InkWell(
                  onTap: widget.disabled
                      ? null
                      : () => _pickImage(ImageSource.gallery),
                  child: Column(
                    children: [
                      Container(
                        height: 45.w,
                        width: 45.w,
                        decoration: BoxDecoration(
                          color: const Color(
                            0xFF0F2623,
                          ).withValues(alpha: alpha),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.cloud_upload,
                          color: ColorManager.primaryButton.withValues(
                            alpha: alpha,
                          ),
                          size: 24,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        "Tap to upload photo",
                        style: TextStyle(
                          color: ColorManager.primaryButton.withValues(
                            alpha: alpha,
                          ),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        "PNG, JPG or PDF (max. 800x400px)",
                        style: TextStyle(
                          color: const Color(
                            0xFF6C757D,
                          ).withValues(alpha: alpha),
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15.h),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: ColorManager.subtextColor.withValues(
                          alpha: widget.disabled ? 0.15 : 0.5,
                        ),
                        indent: 40.w,
                        endIndent: 10.w,
                      ),
                    ),
                    Text(
                      "or",
                      style: TextStyle(
                        color: ColorManager.subtextColor.withValues(
                          alpha: widget.disabled ? 0.15 : 0.5,
                        ),
                        fontSize: 14.sp,
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: ColorManager.subtextColor.withValues(
                          alpha: widget.disabled ? 0.15 : 0.5,
                        ),
                        indent: 10.w,
                        endIndent: 40.w,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15.h),
                GlobalButton.primaryOutlined(
                  foregroundColor: ColorManager.primaryButton.withValues(
                    alpha: alpha,
                  ),
                  borderSide: BorderSide(
                    color: ColorManager.primaryButton.withValues(alpha: alpha),
                  ),
                  width: 160,
                  fontSize: 14,
                  label: 'Open Camera',
                  onPressed: widget.disabled
                      ? null
                      : () => _pickImage(ImageSource.camera),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
