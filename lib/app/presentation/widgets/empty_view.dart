import 'package:flutter/material.dart';

class EmptyView extends StatelessWidget {
  final String message;
  final IconData? icon;

  const EmptyView({super.key, this.message = 'No data available', this.icon});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 48, color: Colors.grey),
            const SizedBox(height: 16),
          ],
          Text(
            message,
            style: const TextStyle(color: Colors.grey, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
