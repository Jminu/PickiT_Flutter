import 'package:flutter/material.dart';

class ArticleFloatingButton extends StatefulWidget {
  final VoidCallback onBookmark;
  final VoidCallback onScrollToTop;
  final VoidCallback onSummarize;

  const ArticleFloatingButton({
    Key? key,
    required this.onBookmark,
    required this.onScrollToTop,
    required this.onSummarize,
  }) : super(key: key);

  @override
  _ArticleFloatingButtonState createState() => _ArticleFloatingButtonState();
}

class _ArticleFloatingButtonState extends State<ArticleFloatingButton> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isExpanded) ...[
          FloatingActionButton(
            heroTag: 'bookmark',
            onPressed: widget.onBookmark,
            backgroundColor: Colors.white,
            child: Icon(Icons.bookmark),
          ),
          SizedBox(height: 8),
          FloatingActionButton(
            heroTag: 'scroll_to_top',
            onPressed: widget.onScrollToTop,
            backgroundColor: Colors.white,
            child: Icon(Icons.arrow_upward),
          ),
          SizedBox(height: 8),
          FloatingActionButton(
            heroTag: 'summarize',
            onPressed: widget.onSummarize,
            backgroundColor: Colors.white,
            child: Icon(Icons.remove_red_eye),
          ),
          SizedBox(height: 8),
        ],
        FloatingActionButton(
          onPressed: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          backgroundColor: isExpanded ? Colors.grey : Colors.white,
          child: Icon(isExpanded ? Icons.close : Icons.add),
        ),
      ],
    );
  }
}
