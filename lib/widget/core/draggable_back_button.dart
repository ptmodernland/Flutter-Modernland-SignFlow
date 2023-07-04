import 'package:flutter/material.dart';

class DraggableBackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 16.0,
      right: 16.0,
      child: Draggable(
        child: FloatingActionButton(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Icon(Icons.arrow_back),
        ),
        feedback: Container(
          child: FloatingActionButton(
            onPressed: () {},
            child: Icon(Icons.arrow_back),
            backgroundColor: Colors.grey.withOpacity(0.7),
          ),
        ),
        childWhenDragging: Container(),
        onDragEnd: (details) {
          if (details.offset.dx < -100) {
            Navigator.of(context).pop();
          }
        },
      ),
    );
  }
}
