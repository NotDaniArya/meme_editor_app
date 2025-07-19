import 'package:flutter/material.dart';

import '../../models/editable_item.dart';

class DraggableItemWidget extends StatefulWidget {
  final EditableItem item;
  final Function(EditableItem) onUpdate;
  final VoidCallback onFinaliseUpdate;

  const DraggableItemWidget({
    super.key,
    required this.item,
    required this.onUpdate,
    required this.onFinaliseUpdate,
  });

  @override
  State<DraggableItemWidget> createState() => _DraggableItemWidgetState();
}

class _DraggableItemWidgetState extends State<DraggableItemWidget> {
  // Fungsi untuk menampilkan dialog edit
  Future<void> _showEditTextDialog() async {
    final textController = TextEditingController(text: widget.item.text);
    final newText = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Teks'),
        content: TextField(
          controller: textController,
          autofocus: true,
          decoration: const InputDecoration(hintText: 'Masukkan teks Anda'),
          onSubmitted: (text) =>
              Navigator.of(context).pop(text), // Simpan saat tekan enter
        ),
        actions: [
          TextButton(
            child: const Text('Batal'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
            child: const Text('Simpan'),
            onPressed: () => Navigator.of(context).pop(textController.text),
          ),
        ],
      ),
    );

    // Pastikan widget masih ada di tree sebelum update state
    if (!mounted) return;

    if (newText != null && newText.isNotEmpty) {
      // Jika ada teks baru, panggil callback untuk update item
      widget.onUpdate(widget.item.copyWith(text: newText));
      // Finalisasi update agar masuk ke histori undo/redo
      widget.onFinaliseUpdate();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: widget.item.position.dy,
      left: widget.item.position.dx,
      child: GestureDetector(
        // TAMBAHKAN onDoubleTap DI SINI
        onDoubleTap: _showEditTextDialog,
        onTap: () {
          // TODO: Nanti kita bisa gunakan ini untuk memilih item
        },
        onScaleUpdate: (details) {
          final updatedItem = widget.item.copyWith(
            scale: widget.item.scale * details.scale,
            rotation: widget.item.rotation + details.rotation,
            position: Offset(
              widget.item.position.dx + details.focalPointDelta.dx,
              widget.item.position.dy + details.focalPointDelta.dy,
            ),
          );
          widget.onUpdate(updatedItem);
        },
        onScaleEnd: (_) => widget.onFinaliseUpdate(),
        child: Transform.scale(
          scale: widget.item.scale,
          child: Transform.rotate(
            angle: widget.item.rotation,
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: widget.item.isSelected
                      ? Colors.blue
                      : Colors.transparent,
                  width: 2,
                ),
              ),
              child: Text(
                widget.item.text,
                style: TextStyle(
                  fontSize: 24,
                  color: widget.item.color,
                  shadows: const [
                    // Tambahkan shadow agar teks lebih terbaca
                    Shadow(blurRadius: 4.0, color: Colors.black54),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
