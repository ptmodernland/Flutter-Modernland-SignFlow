import 'package:flutter/material.dart';

enum ShowRatingShape {
  star,
  circle,
}

class ShowRatingWidget extends StatelessWidget {
  final double rating;
  final int maxRating;
  final double shapeSize;
  final Color shapeColor;
  final Color emptyShapeColor;
  final ShowRatingShape ratingShape;

  ShowRatingWidget({
    required this.rating,
    required this.maxRating,
    this.shapeSize = 24.0,
    this.shapeColor = Colors.yellow,
    this.emptyShapeColor = Colors.grey,
    this.ratingShape = ShowRatingShape.star,
  });

  @override
  Widget build(BuildContext context) {
    int fullShapes = rating.floor();
    int emptyShapes = maxRating - 1 - fullShapes;
    bool hasHalfShape = rating - fullShapes > 0;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: List.generate(
            fullShapes,
                (index) => _buildRatingItem(true),
          ),
        ),
        if (hasHalfShape) _buildRatingItem(true),
        Row(
          children: List.generate(
            emptyShapes,
                (index) => _buildRatingItem(false),
          ),
        ),
      ],
    );
  }

  Widget _buildRatingItem(bool isFilled) {
    Color shapeFillColor = isFilled ? shapeColor : emptyShapeColor;

    return Container(
      width: shapeSize,
      height: shapeSize,
      margin: EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        shape: ratingShape == ShowRatingShape.circle
            ? BoxShape.circle
            : BoxShape.rectangle,
        color: shapeFillColor,
      ),
      child: ratingShape == ShowRatingShape.star
          ? Icon(
        Icons.star,
        size: shapeSize,
        color: Colors.white,
      )
          : Container(), // Add your custom shape widget here
    );
  }
}