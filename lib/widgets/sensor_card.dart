import 'package:flutter/material.dart';

class SensorCard extends StatelessWidget {
  final DateTime? timestamp;
  final String finger;
  final double angle;
  final double tremor;

  const SensorCard({
    super.key,
    required this.timestamp,
    required this.finger,
    required this.angle,
    required this.tremor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Finger: $finger', style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text('Angle: ${angle.toStringAsFixed(1)}°'),
                Text('Tremor: ${tremor.toStringAsFixed(2)}'),
              ],
            ),
            Text(
              timestamp?.toLocal().toString().split('.').first ?? '-',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
