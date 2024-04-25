import 'package:flutter/material.dart';
import 'package:humun/theme.dart';

class QuestionWidget extends StatefulWidget {
  final String question;
  final String id;
  final ValueChanged<int> onButtonSelected;
  final int selectedButtonIndex;

  const QuestionWidget({
    required this.question,
    required this.id,
    required this.onButtonSelected,
    required this.selectedButtonIndex,
  });

  @override
  _QuestionWidgetState createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State <QuestionWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(24),
      elevation: 0.0,
      color: Colors.transparent,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${widget.id}.',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: Text(
                  widget.question,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              for (int i = 0; i < 7; i++)
                _buildCircleButton(50, i, widget.selectedButtonIndex == i),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCircleButton(double size, int index, bool isSelected) {
  return GestureDetector(
    onTap: () {
      widget.onButtonSelected(index);
    },
    child: Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSelected ? Colors.pink : mainColor,
        border: Border.all(
          color: isSelected ? Colors.pink : mainColor,
          width: 2,
        ),
      ),
    ),
  );
}
}
