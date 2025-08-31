import 'package:flutter/material.dart';
import 'package:debate_app/core/theme/color.dart';

class TypingBubble extends StatefulWidget {
  const TypingBubble({super.key});

  @override
  State<TypingBubble> createState() => _TypingBubbleState();
}

class _TypingBubbleState extends State<TypingBubble>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  Widget _dot(int index) {
    final curve = CurvedAnimation(
      parent: _c,
      curve: Interval(
        index * 0.15,
        index * 0.15 + 0.70,
        curve: Curves.easeInOut,
      ),
    );

    return FadeTransition(
      opacity: Tween<double>(begin: 0.3, end: 1.0).animate(curve),
      child: ScaleTransition(
        scale: Tween<double>(begin: 0.85, end: 1.15).animate(curve),
        child: Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.95),
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: AppColor.accent,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(30),
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
        child: AnimatedBuilder(
          animation: _c,
          builder:
              (_, __) => Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _dot(0),
                  const SizedBox(width: 6),
                  _dot(1),
                  const SizedBox(width: 6),
                  _dot(2),
                ],
              ),
        ),
      ),
    );
  }
}
