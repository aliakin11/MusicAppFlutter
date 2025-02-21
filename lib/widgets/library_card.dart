import 'package:flutter/material.dart';
import '../constants/app_theme.dart';
import '../models/library_item.dart';

class LibraryCard extends StatelessWidget {
  final LibraryItem item;

  const LibraryCard({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: Colors.grey[850],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: _buildImageContainer(),
          ),
          _buildDetails(),
        ],
      ),
    );
  }

  Widget _buildImageContainer() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[800],
        shape: item.isCircular ? BoxShape.circle : BoxShape.rectangle,
        borderRadius: item.isCircular
            ? null
            : const BorderRadius.vertical(
                top: Radius.circular(12),
                bottom: Radius.circular(12),
              ),
        image: item.imageUrl != null
            ? DecorationImage(
                image: NetworkImage(item.imageUrl!),
                fit: BoxFit.cover,
              )
            : null,
      ),
      child: item.imageUrl == null
          ? Center(
              child: Icon(
                item.icon,
                color: AppTheme.textGrey,
                size: 40,
              ),
            )
          : null,
    );
  }

  Widget _buildDetails() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(12),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.title,
            style: const TextStyle(
              color: AppTheme.textLight,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            item.subtitle,
            style: const TextStyle(
              color: AppTheme.textGrey,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
} 