import 'package:flutter/material.dart';
import '../viewmodels/home_view_model.dart';

class PodcastCard extends StatelessWidget {
  final Map<String, dynamic> podcast;
  final VoidCallback? onTap;

  const PodcastCard({
    Key? key,
    required this.podcast,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final images = podcast['album']?['images'] as List? ?? [];
    final imageUrl = images.isNotEmpty ? images[0]['url'] : null;
    final artists = (podcast['artists'] as List?)?.map((a) => a['name']).join(', ') ?? 'Unknown Artist';
    final name = podcast['name'] ?? 'Unknown Track';

    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                child: imageUrl != null
                    ? Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        errorBuilder: (context, error, stackTrace) {
                          print('Image error: $error');
                          return Container(
                            color: Colors.grey,
                            child: const Icon(Icons.music_note),
                          );
                        },
                      )
                    : Container(
                        color: Colors.grey,
                        child: const Icon(Icons.music_note),
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    artists,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}