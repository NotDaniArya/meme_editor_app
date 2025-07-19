import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

enum ItemType { text }

class EditableItem extends Equatable {
  EditableItem({
    String? id,
    this.type = ItemType.text,
    this.text = '',
    this.position = Offset.zero,
    this.scale = 1.0,
    this.rotation = 0.0,
    this.color = Colors.white,
    this.isSelected = true,
  }) : id = id ?? const Uuid().v4();

  EditableItem copyWith({
    String? id,
    ItemType? type,
    String? text,
    Offset? position,
    double? scale,
    double? rotation,
    Color? color,
    bool? isSelected,
  }) {
    return EditableItem(
      id: id ?? this.id,
      type: type ?? this.type,
      text: text ?? this.text,
      position: position ?? this.position,
      scale: scale ?? this.scale,
      rotation: rotation ?? this.rotation,
      color: color ?? this.color,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  final String id;
  final ItemType type;
  final String text;
  final Offset position;
  final double scale;
  final double rotation;
  final Color color;
  final bool isSelected;

  @override
  List<Object?> get props => [
    id,
    type,
    text,
    position,
    scale,
    rotation,
    color,
    isSelected,
  ];
}
