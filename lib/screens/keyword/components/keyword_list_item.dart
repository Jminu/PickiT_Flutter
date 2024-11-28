import 'package:flutter/material.dart';
import '../../../models/keyword.dart';

class KeywordListItem extends StatelessWidget {
  final Keyword keyword;
  final VoidCallback onTap;

  const KeywordListItem({required this.keyword, required this.onTap, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
        title: Text(
          keyword.keyWord,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        trailing: Icon(
          keyword.isActivated ? Icons.check : Icons.add,
          color: Theme.of(context).iconTheme.color,
          size: 16.0,
        ),
        onTap: onTap,
      ),
    );
  }
}
