import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meme_editor_app/features/meme/presentation/features/models/editable_item.dart';

class EditorState {
  EditorState({
    this.items = const [],
    this.history = const [],
    this.redoStack = const [],
  });

  EditorState copyWith({
    List<EditableItem>? items,
    List<List<EditableItem>>? history,
    List<List<EditableItem>>? redoStack,
  }) {
    return EditorState(
      items: items ?? this.items,
      history: history ?? this.history,
      redoStack: redoStack ?? this.redoStack,
    );
  }

  final List<EditableItem> items;
  final List<List<EditableItem>> history;
  final List<List<EditableItem>> redoStack;
}

class EditorNotifier extends StateNotifier<EditorState> {
  EditorNotifier() : super(EditorState());

  void _addStateToHistory() {
    state = state.copyWith(
      history: [...state.history, state.items],
      redoStack: [],
    );
  }

  void addText() {
    _addStateToHistory();
    final newItem = EditableItem(
      text: 'Teks Baru',
      position: const Offset(150, 150),
    );
    state = state.copyWith(items: [...state.items, newItem]);
  }

  void updateItem(EditableItem updatedItem) {
    final newItems = state.items.map((item) {
      return item.id == updatedItem.id ? updatedItem : item;
    }).toList();
    state = state.copyWith(items: newItems);
  }

  void finaliseItemUpdate() {
    _addStateToHistory();
  }

  void undo() {
    if (state.history.isNotEmpty) {
      final lastState = state.history.last;
      final newHistory = List<List<EditableItem>>.from(state.history)
        ..removeLast();
      state = state.copyWith(
        items: lastState,
        history: newHistory,
        redoStack: [...state.redoStack, state.items],
      );
    }
  }

  void redo() {
    if (state.redoStack.isNotEmpty) {
      final nextState = state.redoStack.last;
      final newRedoStack = List<List<EditableItem>>.from(state.redoStack)
        ..removeLast();
      state = state.copyWith(
        items: nextState,
        history: [...state.history, state.items],
        redoStack: newRedoStack,
      );
    }
  }

  void selectItem(String id) {
    final newItems = state.items.map((item) {
      return item.copyWith(isSelected: item.id == id);
    }).toList();
    state = state.copyWith(items: newItems);
  }

  void deselectAll() {
    final newItems = state.items.map((item) {
      return item.copyWith(isSelected: false);
    }).toList();
    state = state.copyWith(items: newItems);
  }
}

final editorNotifierProvider =
    StateNotifierProvider<EditorNotifier, EditorState>((ref) {
      return EditorNotifier();
    });
