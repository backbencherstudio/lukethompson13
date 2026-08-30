import 'package:background_downloader/background_downloader.dart';
import 'package:flutter/material.dart';
import 'package:lukethompson/core/extensions/snackbar_extension.dart';
import 'package:lukethompson/core/utils/logger.dart';
import 'package:lukethompson/core/widgets/global_button.dart';

class ExportPdfButton extends StatefulWidget {
  const ExportPdfButton({super.key, this.fileUrl, this.fineName});

  final String? fileUrl;
  final String? fineName;

  @override
  State<ExportPdfButton> createState() => _ExportPdfButtonState();
}

class _ExportPdfButtonState extends State<ExportPdfButton> {
  bool _isDownloading = false;

  Future<void> _handleExportPdf(String? fileUrl, String? fileName) async {
    // logger.d("Download pdf url $fileUrl");

    if (fileUrl == null || fileUrl.isEmpty) {
      context.showWarningSnackBar("Empty fileUrl");
      return;
    }
    if (fileName == null || fileName.isEmpty) {
      context.showWarningSnackBar("Empty filename");
      return;
    }

    setState(() => _isDownloading = true);
    try {
      final task = DownloadTask(url: fileUrl, filename: fileName);
      final result = await FileDownloader().download(task);

      if (mounted) {
        setState(() => _isDownloading = false);
        if (result.status == TaskStatus.complete) {
          await FileDownloader().openFile(task: result.task);
        } else {
          context.showErrorSnackBar('Failed to download PDF');
        }
      }
    } catch (e, st) {
      if (mounted) {
        setState(() => _isDownloading = false);
        context.showErrorSnackBar('Failed to download PDF');
      }
      logger.e('PDF download failed', error: e, stackTrace: st);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GlobalButton.outlined(
      isDisabled:
          widget.fileUrl == null || widget.fineName == null || _isDownloading,
      isLoading: _isDownloading,
      label: 'Export PDF',
      onPressed: () => _handleExportPdf(widget.fileUrl, widget.fineName),
    );
  }
}
