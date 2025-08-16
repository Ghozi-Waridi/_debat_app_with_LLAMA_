import 'package:debate_app/core/theme/color.dart';
import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.onClear,
    this.hint,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;
  final String? hint;

  @override
  Widget build(BuildContext context) {
    final hasText = controller.text.isNotEmpty;

    return TextField(
      cursorColor: Colors.white,
      controller: controller,
      onChanged: onChanged,
      textInputAction: TextInputAction.search,
      style: const TextStyle(color: Colors.white), // text color white
      decoration: InputDecoration(
        prefixIconColor: Colors.white,
        fillColor: AppColor.background,
        hintText: hint ?? 'Search',
        hintStyle: const TextStyle(color: Colors.white), // hint color white
        prefixIcon: const Icon(Icons.search),
        suffixIcon:
            hasText
                ? IconButton(
                  tooltip: 'Clear',
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: onClear,
                )
                : null,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: AppColor.accent), // border color white
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: AppColor.accent),
        ), // border color white

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: AppColor.purpleLight,
          ), // border color white
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 12,
        ),
      ),
    );
  }
}
