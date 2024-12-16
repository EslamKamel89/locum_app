import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locum_app/core/extensions/context-extensions.dart';
import 'package:locum_app/core/themes/theme_cubit.dart';

class BadgeWrap extends StatelessWidget {
  BadgeWrap({super.key, required this.items});
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    context.watch<ThemeCubit>();
    return Wrap(
      spacing: 8.w,
      runSpacing: 8.w,
      children: items.map((item) => _buildBadge(context, item)).toList(),
    );
  }

  Widget _buildBadge(BuildContext context, String item) {
    Color color = _getRandomColor(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color),
      ),
      child: Text(
        item,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: color,
        ),
      ),
    );
  }

  final List<Color> _lightThemeColors = [
    Colors.black,
    Colors.blueGrey,
    Colors.brown,
    Colors.deepPurple,
    Colors.indigo,
    Colors.teal,
    Colors.deepOrange,
    Colors.grey[900]!,
    Colors.blue[900]!,
    Colors.green[900]!,
  ];
  final List<Color> _darkThemeColors = [
    Colors.lightBlueAccent,
    Colors.lightGreenAccent,
    Colors.yellowAccent,
    Colors.orangeAccent,
    Colors.pinkAccent,
    Colors.amberAccent,
    Colors.limeAccent,
    Colors.cyanAccent,
    Colors.tealAccent,
    // Colors.purpleAccent,
  ];
  Color _getRandomColor(BuildContext context) {
    Color randomColor = context.primaryColor;
    List<Color> color = context.read<ThemeCubit>().isDarkMode()
        ? _darkThemeColors
        : _lightThemeColors;
    final random = Random();
    return color[random.nextInt(color.length)];
  }
}
