import 'package:flutter/material.dart';

class HourlyForecastItem extends StatelessWidget {
  final IconData icon;
  final String time;
  final String temperature;

  const HourlyForecastItem({
    Key? key,
    required this.icon,
    required this.time,
    required this.temperature,
  }) : super(key: key);

  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Container(
        width: 150,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          children: [
            Text(
              time,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
            ),
            SizedBox(height: 2),
            Icon(
              icon,
              size: 48,
            ),
            SizedBox(height: 8),
            Text(
              temperature,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
