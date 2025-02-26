import 'package:flutter/material.dart';

class ExpandableText extends StatefulWidget {
  final String content;
  final int maxLines;
  const ExpandableText ({super.key, required this.content, required this.maxLines});

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool isExpand = false;

  @override
  Widget build(BuildContext context) {
    return 
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.content,
            softWrap: true,
            maxLines: isExpand ? null : widget.maxLines,
            overflow: isExpand ? TextOverflow.visible : TextOverflow.ellipsis,
          ),
          GestureDetector(
            onTap: () => {
              setState(() {
                isExpand = !isExpand;
              })
            },
            child: Text(
              isExpand ? "Show Less" : "Show More",
              style: TextStyle(
                fontSize: 10,
                color: Colors.grey[700]
              ),
            ),
          )
        ],
      );
  }
}