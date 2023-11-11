import 'package:flutter/material.dart';

class GlassContainer extends StatelessWidget {
  const GlassContainer({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100.withOpacity(0.12),
        borderRadius: BorderRadius.circular(12)
      ),
      child: child,
    );
  }
}
