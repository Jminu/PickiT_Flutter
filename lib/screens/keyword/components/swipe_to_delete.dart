import 'package:flutter/material.dart';

class SwipeToDelete extends StatelessWidget {
  final Widget child; // 삭제될 UI
  final VoidCallback onDelete; // 삭제 동작

  const SwipeToDelete({required this.child, required this.onDelete, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) => onDelete(),
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      child: child,
    );
  }
}
