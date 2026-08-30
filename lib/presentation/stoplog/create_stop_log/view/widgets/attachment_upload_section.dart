import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lukethompson/core/extensions/sizedbox_extension.dart';
import 'package:lukethompson/core/extensions/snackbar_extension.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/core/utils/error.dart';
import 'package:lukethompson/core/widgets/attachment_image_viewer.dart';
import 'package:lukethompson/core/widgets/global_button.dart';
import 'package:lukethompson/core/widgets/link_button.dart';
import 'package:lukethompson/presentation/stoplog/create_stop_log/view/widgets/proof_package_list.dart';

class AttachmentUploadSection extends StatefulWidget {
  const AttachmentUploadSection({
    super.key,
    this.onAttachmentPicked,
    this.onAttachmentRemoved,
    this.disabled = false,
    required this.attachments,
  });

  final List<XFile> attachments;
  final void Function(List<XFile> files)? onAttachmentPicked;
  final void Function(List<XFile> files, int index)? onAttachmentRemoved;
  final bool disabled;

  @override
  State<AttachmentUploadSection> createState() =>
      _AttachmentUploadSectionState();
}

class _AttachmentUploadSectionState extends State<AttachmentUploadSection> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source, [bool forcePick = false]) async {
    if (widget.disabled && !forcePick) return;

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
    final (image, err) = await tryCatch(_picker.pickImage(source: source));
    if (!mounted) return;

    if (image == null) {
      context.showInfoSnackBar(
        source == ImageSource.camera
            ? 'No photo was taken.'
            : 'No image was selected.',
      );
      return;
    }

    final updated = [...widget.attachments, image];
    widget.onAttachmentPicked?.call(updated);
  }

  @override
  Widget build(BuildContext context) {
    final alpha = widget.disabled ? 0.4 : 1.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.attachments.isEmpty) _buildFilePicker(alpha),
        if (widget.attachments.isNotEmpty) ...[
          ProofPackageList(
            onItemPressed: (index) => AttachmentImageViewer.showFiles(
              context,
              files: widget.attachments,
              index: index,
            ),
            onRemoveItem: (index) {
              final updated = List<XFile>.from(widget.attachments)
                ..removeAt(index);
              widget.onAttachmentRemoved?.call(updated, index);
            },
            fineNames: widget.attachments.map((e) => e.name).toList(),
          ),

          8.height,
          Row(
            mainAxisAlignment: .end,
            children: [
              LinkButton(
                child: Text('Open camera'),
                onPressed: () => _pickImage(ImageSource.camera, true),
              ),
              12.width,
              LinkButton(
                child: Text('Add more photo'),
                onPressed: () => _pickImage(ImageSource.gallery, true),
              ),
            ],
          ),
        ],
      ],
    );
  }

  DottedBorder _buildFilePicker(double alpha) {
    return DottedBorder(
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
                      color: const Color(0xFF0F2623).withValues(alpha: alpha),
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
                      color: const Color(0xFF6C757D).withValues(alpha: alpha),
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
    );
  }
}
