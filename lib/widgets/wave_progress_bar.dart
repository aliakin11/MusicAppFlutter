import 'package:flutter/material.dart';

class WaveProgressBar extends StatelessWidget {
  final double progress;
  final int barCount;
  
  const WaveProgressBar({
    Key? key,
    required this.progress,
    this.barCount = 40,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(barCount, (index) {
          final isActive = index / barCount <= progress;
          final height = _getBarHeight(index);
          
          return Container(
            width: 4,
            height: height,
            decoration: BoxDecoration(
              color: isActive ? Colors.white : Colors.white.withOpacity(0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          );
        }),
      ),
    );
  }

  double _getBarHeight(int index) {
    final heights = [16.0, 24.0, 12.0, 20.0, 8.0, 16.0, 24.0, 12.0];
    return heights[index % heights.length];
  }
} 