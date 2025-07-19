import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meme_editor_app/features/meme/presentation/notifiers/editor_notifier.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:saver_gallery/saver_gallery.dart';
import 'package:share_plus/share_plus.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

mixin SaveAndShareMixin {
  Future<bool> _requestPermission() async {
    if (Platform.isIOS) {
      var status = await Permission.photos.status;
      if (!status.isGranted) {
        status = await Permission.photos.request();
      }
      return status.isGranted;
    }
    return true;
  }

  Future<void> saveMeme(
    BuildContext context,
    WidgetsToImageController controller,
    WidgetRef ref,
  ) async {
    ref.read(editorNotifierProvider.notifier).deselectAll();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!context.mounted) return;

      try {
        if (!await _requestPermission()) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Izin penyimpanan ditolak.')),
          );
          return;
        }

        final bytes = await controller.capture();
        if (bytes == null) throw Exception('Gagal membuat gambar');

        final result = await SaverGallery.saveImage(
          bytes,
          fileName: 'meme-${DateTime.now().millisecondsSinceEpoch}.png',
          androidRelativePath: 'Pictures/MyMemes',
          skipIfExists: true,
        );

        if (result.isSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Meme berhasil disimpan!')),
          );
        } else {
          throw Exception(result.errorMessage ?? 'Gagal menyimpan gambar');
        }
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
      }
    });
  }

  Future<void> shareMeme(
    BuildContext context,
    WidgetsToImageController controller,
    WidgetRef ref,
  ) async {
    try {
      final bytes = await controller.capture();
      if (bytes == null) throw Exception('Gagal membuat gambar');

      final tempDir = await getTemporaryDirectory();
      final path = '${tempDir.path}/meme.png';
      File(path).writeAsBytesSync(bytes);

      await Share.shareXFiles([
        XFile(path),
      ], text: 'Lihat meme yang kubuat guys!');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal membagikan: ${e.toString()}')),
      );
    }
  }
}
