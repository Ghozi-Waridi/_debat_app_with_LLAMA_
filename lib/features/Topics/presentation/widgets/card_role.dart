import 'package:debate_app/core/theme/color.dart';
import 'package:flutter/material.dart';

class CardRole extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color iconColor;
  final String role;

  const CardRole({
    super.key,
    required this.icon,
    required this.onTap,
    required this.iconColor,
    required this.role,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: AppColor.background.withOpacity(0.6), // warna dasar card
        borderRadius: BorderRadius.circular(16),
        elevation: 4,
        shadowColor: AppColor.background.withOpacity(0.2),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          splashColor: iconColor.withAlpha(50),
          highlightColor: Colors.white.withAlpha(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: iconColor, size: 28),
                const SizedBox(height: 8),
                Text(
                  role,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
