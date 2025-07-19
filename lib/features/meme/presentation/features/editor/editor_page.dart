import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meme_editor_app/features/meme/presentation/features/editor/save_and_share_mixin.dart';
import 'package:meme_editor_app/features/meme/presentation/features/editor/widgets/draggable_item_widget.dart';
import 'package:meme_editor_app/features/meme/presentation/notifiers/editor_notifier.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

import '../../../domain/entities/meme.dart';

class EditorPage extends ConsumerStatefulWidget {
  const EditorPage({super.key, required this.meme});

  final Meme meme;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditorPageState();
}

class _EditorPageState extends ConsumerState<EditorPage>
    with SaveAndShareMixin {
  final WidgetsToImageController _imageController = WidgetsToImageController();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final editorState = ref.watch(editorNotifierProvider);
    final editorNotifier = ref.read(editorNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.primary.withAlpha(190),
        foregroundColor: Colors.white,
        title: Text(
          widget.meme.name,
          style: textTheme.titleLarge!.copyWith(color: Colors.white),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.text_fields),
                onPressed: () {
                  editorNotifier.addText();
                },
              ),
              IconButton(
                icon: const Icon(Icons.undo),
                onPressed: () {
                  editorNotifier.undo();
                },
              ),
              IconButton(
                icon: const Icon(Icons.redo),
                onPressed: () {
                  editorNotifier.redo();
                },
              ),
              IconButton(
                icon: const Icon(Icons.share),
                onPressed: () => shareMeme(context, _imageController, ref),
              ),
              IconButton(
                icon: const Icon(Icons.save),
                onPressed: () => saveMeme(context, _imageController, ref),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Center(
            child: WidgetsToImage(
              controller: _imageController,
              child: InteractiveViewer(
                minScale: 0.1,
                maxScale: 4.0,
                child: Stack(
                  children: [
                    CachedNetworkImage(imageUrl: widget.meme.url),

                    ...editorState.items.map((item) {
                      return DraggableItemWidget(
                        item: item,
                        onUpdate: (updatedItem) {
                          editorNotifier.updateItem(updatedItem);
                        },
                        onFinaliseUpdate: () {
                          editorNotifier.finaliseItemUpdate();
                        },
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
